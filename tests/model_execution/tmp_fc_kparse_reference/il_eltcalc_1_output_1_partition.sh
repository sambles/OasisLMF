#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---
set -euET -o pipefail
shopt -s inherit_errexit 2>/dev/null || echo "WARNING: Unable to set inherit_errexit. Possibly unsupported by this shell, Subprocess failures may not be detected."

LOG_DIR=log
mkdir -p $LOG_DIR
rm -R -f $LOG_DIR/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +
mkdir -p output/full_correlation/

rm -R -f work/*
mkdir -p work/kat/
mkdir -p work/full_correlation/
mkdir -p work/full_correlation/kat/

rm -R -f /tmp/%FIFO_DIR%/
mkdir -p /tmp/%FIFO_DIR%/fifo/
mkdir -p /tmp/%FIFO_DIR%/fifo/full_correlation/

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_fc_P1

mkfifo /tmp/%FIFO_DIR%/fifo/il_P1

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P1
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P1

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_P1

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P1
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_eltcalc_P1



# --- Do insured loss computes ---

eltcalc < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P1 > work/kat/il_S1_eltcalc_P1 & pid1=$!


tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P1 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P1 > /dev/null & pid2=$!

summarycalc -m -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P1 < /tmp/%FIFO_DIR%/fifo/il_P1 &

# --- Do insured loss computes ---

eltcalc < /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_eltcalc_P1 > work/full_correlation/kat/il_S1_eltcalc_P1 & pid3=$!


tee < /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P1 /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_eltcalc_P1 > /dev/null & pid4=$!

summarycalc -m -f  -1 /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P1 < /tmp/%FIFO_DIR%/fifo/full_correlation/il_P1 &

fmcalc -a2 < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_fc_P1 > /tmp/%FIFO_DIR%/fifo/full_correlation/il_P1 &
eve 1 1 | getmodel | gulcalc -S100 -L100 -r -j /tmp/%FIFO_DIR%/fifo/full_correlation/gul_fc_P1 -a1 -i - | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P1  &

wait $pid1 $pid2 $pid3 $pid4


# --- Do insured loss kats ---

kat work/kat/il_S1_eltcalc_P1 > output/il_S1_eltcalc.csv & kpid1=$!

# --- Do insured loss kats for fully correlated output ---

kat work/full_correlation/kat/il_S1_eltcalc_P1 > output/full_correlation/il_S1_eltcalc.csv & kpid2=$!
wait $kpid1 $kpid2


rm -R -f work/*
rm -R -f /tmp/%FIFO_DIR%/
