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

find fifo/ \( -name '*P8[^0-9]*' -o -name '*P8' \) -exec rm -R -f {} +
mkdir -p fifo/full_correlation/
rm -R -f work/*
mkdir -p work/kat/
mkdir -p work/full_correlation/
mkdir -p work/full_correlation/kat/

mkdir -p work/gul_S1_summaryaalcalc
mkdir -p work/full_correlation/gul_S1_summaryaalcalc

mkfifo fifo/gul_P8

mkfifo fifo/gul_S1_summary_P8
mkfifo fifo/gul_S1_summary_P8.idx

mkfifo fifo/full_correlation/gul_P8

mkfifo fifo/full_correlation/gul_S1_summary_P8
mkfifo fifo/full_correlation/gul_S1_summary_P8.idx



# --- Do ground up loss computes ---
tee < fifo/gul_S1_summary_P8 work/gul_S1_summaryaalcalc/P8.bin > /dev/null & pid1=$!
tee < fifo/gul_S1_summary_P8.idx work/gul_S1_summaryaalcalc/P8.idx > /dev/null & pid2=$!
summarycalc -m -i  -1 fifo/gul_S1_summary_P8 < fifo/gul_P8 &

# --- Do ground up loss computes ---
tee < fifo/full_correlation/gul_S1_summary_P8 work/full_correlation/gul_S1_summaryaalcalc/P8.bin > /dev/null & pid3=$!
tee < fifo/full_correlation/gul_S1_summary_P8.idx work/full_correlation/gul_S1_summaryaalcalc/P8.idx > /dev/null & pid4=$!
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P8 < fifo/full_correlation/gul_P8 &

eve 8 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_P8 -a1 -i - > fifo/gul_P8  &

wait $pid1 $pid2 $pid3 $pid4

