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

find /tmp/%FIFO_DIR%/fifo/ \( -name '*P34[^0-9]*' -o -name '*P34' \) -exec rm -R -f {} +
mkdir -p /tmp/%FIFO_DIR%/fifo/full_correlation/
rm -R -f work/*
mkdir -p work/kat/
mkdir -p work/full_correlation/
mkdir -p work/full_correlation/kat/

mkdir -p work/gul_S1_summaryleccalc
mkdir -p work/gul_S1_summaryaalcalc
mkdir -p work/full_correlation/gul_S1_summaryleccalc
mkdir -p work/full_correlation/gul_S1_summaryaalcalc
mkdir -p work/il_S1_summaryleccalc
mkdir -p work/il_S1_summaryaalcalc
mkdir -p work/full_correlation/il_S1_summaryleccalc
mkdir -p work/full_correlation/il_S1_summaryaalcalc

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_fc_P34

mkfifo /tmp/%FIFO_DIR%/fifo/gul_P34

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P34
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P34.idx
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P34
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P34
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P34

mkfifo /tmp/%FIFO_DIR%/fifo/il_P34

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P34
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P34.idx
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P34
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P34
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P34

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_P34

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P34
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P34.idx
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_eltcalc_P34
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summarycalc_P34
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_pltcalc_P34

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_P34

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P34
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P34.idx
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_eltcalc_P34
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summarycalc_P34
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_pltcalc_P34



# --- Do insured loss computes ---
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P34 > work/kat/il_S1_eltcalc_P34 & pid1=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P34 > work/kat/il_S1_summarycalc_P34 & pid2=$!
pltcalc -H < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P34 > work/kat/il_S1_pltcalc_P34 & pid3=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P34 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P34 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P34 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P34 work/il_S1_summaryaalcalc/P34.bin work/il_S1_summaryleccalc/P34.bin > /dev/null & pid4=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P34.idx work/il_S1_summaryaalcalc/P34.idx work/il_S1_summaryleccalc/P34.idx > /dev/null & pid5=$!
summarycalc -m -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P34 < /tmp/%FIFO_DIR%/fifo/il_P34 &

# --- Do ground up loss computes ---
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P34 > work/kat/gul_S1_eltcalc_P34 & pid6=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P34 > work/kat/gul_S1_summarycalc_P34 & pid7=$!
pltcalc -H < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P34 > work/kat/gul_S1_pltcalc_P34 & pid8=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P34 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P34 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P34 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P34 work/gul_S1_summaryaalcalc/P34.bin work/gul_S1_summaryleccalc/P34.bin > /dev/null & pid9=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P34.idx work/gul_S1_summaryaalcalc/P34.idx work/gul_S1_summaryleccalc/P34.idx > /dev/null & pid10=$!
summarycalc -m -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P34 < /tmp/%FIFO_DIR%/fifo/gul_P34 &

# --- Do insured loss computes ---
eltcalc -s < /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_eltcalc_P34 > work/full_correlation/kat/il_S1_eltcalc_P34 & pid11=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summarycalc_P34 > work/full_correlation/kat/il_S1_summarycalc_P34 & pid12=$!
pltcalc -H < /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_pltcalc_P34 > work/full_correlation/kat/il_S1_pltcalc_P34 & pid13=$!
tee < /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P34 /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_eltcalc_P34 /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summarycalc_P34 /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_pltcalc_P34 work/full_correlation/il_S1_summaryaalcalc/P34.bin work/full_correlation/il_S1_summaryleccalc/P34.bin > /dev/null & pid14=$!
tee < /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P34.idx work/full_correlation/il_S1_summaryaalcalc/P34.idx work/full_correlation/il_S1_summaryleccalc/P34.idx > /dev/null & pid15=$!
summarycalc -m -f  -1 /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P34 < /tmp/%FIFO_DIR%/fifo/full_correlation/il_P34 &

# --- Do ground up loss computes ---
eltcalc -s < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_eltcalc_P34 > work/full_correlation/kat/gul_S1_eltcalc_P34 & pid16=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summarycalc_P34 > work/full_correlation/kat/gul_S1_summarycalc_P34 & pid17=$!
pltcalc -H < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_pltcalc_P34 > work/full_correlation/kat/gul_S1_pltcalc_P34 & pid18=$!
tee < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P34 /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_eltcalc_P34 /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summarycalc_P34 /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_pltcalc_P34 work/full_correlation/gul_S1_summaryaalcalc/P34.bin work/full_correlation/gul_S1_summaryleccalc/P34.bin > /dev/null & pid19=$!
tee < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P34.idx work/full_correlation/gul_S1_summaryaalcalc/P34.idx work/full_correlation/gul_S1_summaryleccalc/P34.idx > /dev/null & pid20=$!
summarycalc -m -i  -1 /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P34 < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_P34 &

tee < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_fc_P34 /tmp/%FIFO_DIR%/fifo/full_correlation/gul_P34  | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/full_correlation/il_P34  &
eve 34 40 | getmodel | gulcalc -S100 -L100 -r -j /tmp/%FIFO_DIR%/fifo/full_correlation/gul_fc_P34 -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P34 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P34  &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11 $pid12 $pid13 $pid14 $pid15 $pid16 $pid17 $pid18 $pid19 $pid20

