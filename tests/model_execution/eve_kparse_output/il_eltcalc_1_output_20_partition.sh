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

rm -R -f fifo/*
rm -R -f work/*
mkdir -p work/kat/


mkfifo fifo/il_P1
mkfifo fifo/il_P2
mkfifo fifo/il_P3
mkfifo fifo/il_P4
mkfifo fifo/il_P5
mkfifo fifo/il_P6
mkfifo fifo/il_P7
mkfifo fifo/il_P8
mkfifo fifo/il_P9
mkfifo fifo/il_P10

mkfifo fifo/il_S1_summary_P1
mkfifo fifo/il_S1_eltcalc_P1

mkfifo fifo/il_S1_summary_P2
mkfifo fifo/il_S1_eltcalc_P2

mkfifo fifo/il_S1_summary_P3
mkfifo fifo/il_S1_eltcalc_P3

mkfifo fifo/il_S1_summary_P4
mkfifo fifo/il_S1_eltcalc_P4

mkfifo fifo/il_S1_summary_P5
mkfifo fifo/il_S1_eltcalc_P5

mkfifo fifo/il_S1_summary_P6
mkfifo fifo/il_S1_eltcalc_P6

mkfifo fifo/il_S1_summary_P7
mkfifo fifo/il_S1_eltcalc_P7

mkfifo fifo/il_S1_summary_P8
mkfifo fifo/il_S1_eltcalc_P8

mkfifo fifo/il_S1_summary_P9
mkfifo fifo/il_S1_eltcalc_P9

mkfifo fifo/il_S1_summary_P10
mkfifo fifo/il_S1_eltcalc_P10

mkfifo fifo/gul_lb_P1
mkfifo fifo/gul_lb_P2
mkfifo fifo/gul_lb_P3
mkfifo fifo/gul_lb_P4
mkfifo fifo/gul_lb_P5
mkfifo fifo/gul_lb_P6
mkfifo fifo/gul_lb_P7
mkfifo fifo/gul_lb_P8
mkfifo fifo/gul_lb_P9
mkfifo fifo/gul_lb_P10

mkfifo fifo/lb_il_P1
mkfifo fifo/lb_il_P2
mkfifo fifo/lb_il_P3
mkfifo fifo/lb_il_P4
mkfifo fifo/lb_il_P5
mkfifo fifo/lb_il_P6
mkfifo fifo/lb_il_P7
mkfifo fifo/lb_il_P8
mkfifo fifo/lb_il_P9
mkfifo fifo/lb_il_P10



# --- Do insured loss computes ---

eltcalc < fifo/il_S1_eltcalc_P1 > work/kat/il_S1_eltcalc_P1 & pid1=$!
eltcalc -s < fifo/il_S1_eltcalc_P2 > work/kat/il_S1_eltcalc_P2 & pid2=$!
eltcalc -s < fifo/il_S1_eltcalc_P3 > work/kat/il_S1_eltcalc_P3 & pid3=$!
eltcalc -s < fifo/il_S1_eltcalc_P4 > work/kat/il_S1_eltcalc_P4 & pid4=$!
eltcalc -s < fifo/il_S1_eltcalc_P5 > work/kat/il_S1_eltcalc_P5 & pid5=$!
eltcalc -s < fifo/il_S1_eltcalc_P6 > work/kat/il_S1_eltcalc_P6 & pid6=$!
eltcalc -s < fifo/il_S1_eltcalc_P7 > work/kat/il_S1_eltcalc_P7 & pid7=$!
eltcalc -s < fifo/il_S1_eltcalc_P8 > work/kat/il_S1_eltcalc_P8 & pid8=$!
eltcalc -s < fifo/il_S1_eltcalc_P9 > work/kat/il_S1_eltcalc_P9 & pid9=$!
eltcalc -s < fifo/il_S1_eltcalc_P10 > work/kat/il_S1_eltcalc_P10 & pid10=$!


tee < fifo/il_S1_summary_P1 fifo/il_S1_eltcalc_P1 > /dev/null & pid11=$!
tee < fifo/il_S1_summary_P2 fifo/il_S1_eltcalc_P2 > /dev/null & pid12=$!
tee < fifo/il_S1_summary_P3 fifo/il_S1_eltcalc_P3 > /dev/null & pid13=$!
tee < fifo/il_S1_summary_P4 fifo/il_S1_eltcalc_P4 > /dev/null & pid14=$!
tee < fifo/il_S1_summary_P5 fifo/il_S1_eltcalc_P5 > /dev/null & pid15=$!
tee < fifo/il_S1_summary_P6 fifo/il_S1_eltcalc_P6 > /dev/null & pid16=$!
tee < fifo/il_S1_summary_P7 fifo/il_S1_eltcalc_P7 > /dev/null & pid17=$!
tee < fifo/il_S1_summary_P8 fifo/il_S1_eltcalc_P8 > /dev/null & pid18=$!
tee < fifo/il_S1_summary_P9 fifo/il_S1_eltcalc_P9 > /dev/null & pid19=$!
tee < fifo/il_S1_summary_P10 fifo/il_S1_eltcalc_P10 > /dev/null & pid20=$!

summarycalc -m -f  -1 fifo/il_S1_summary_P1 < fifo/il_P1 &
summarycalc -m -f  -1 fifo/il_S1_summary_P2 < fifo/il_P2 &
summarycalc -m -f  -1 fifo/il_S1_summary_P3 < fifo/il_P3 &
summarycalc -m -f  -1 fifo/il_S1_summary_P4 < fifo/il_P4 &
summarycalc -m -f  -1 fifo/il_S1_summary_P5 < fifo/il_P5 &
summarycalc -m -f  -1 fifo/il_S1_summary_P6 < fifo/il_P6 &
summarycalc -m -f  -1 fifo/il_S1_summary_P7 < fifo/il_P7 &
summarycalc -m -f  -1 fifo/il_S1_summary_P8 < fifo/il_P8 &
summarycalc -m -f  -1 fifo/il_S1_summary_P9 < fifo/il_P9 &
summarycalc -m -f  -1 fifo/il_S1_summary_P10 < fifo/il_P10 &

eve -R 1 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P1  &
eve -R 2 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P2  &
eve -R 3 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P3  &
eve -R 4 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P4  &
eve -R 5 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P5  &
eve -R 6 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P6  &
eve -R 7 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P7  &
eve -R 8 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P8  &
eve -R 9 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P9  &
eve -R 10 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P10  &
load_balancer -i fifo/gul_lb_P1 fifo/gul_lb_P2 -o fifo/lb_il_P1 fifo/lb_il_P2 &
load_balancer -i fifo/gul_lb_P3 fifo/gul_lb_P4 -o fifo/lb_il_P3 fifo/lb_il_P4 &
load_balancer -i fifo/gul_lb_P5 fifo/gul_lb_P6 -o fifo/lb_il_P5 fifo/lb_il_P6 &
load_balancer -i fifo/gul_lb_P7 fifo/gul_lb_P8 -o fifo/lb_il_P7 fifo/lb_il_P8 &
load_balancer -i fifo/gul_lb_P9 fifo/gul_lb_P10 -o fifo/lb_il_P9 fifo/lb_il_P10 &
fmcalc -a2 < fifo/lb_il_P1 > fifo/il_P1 &
fmcalc -a2 < fifo/lb_il_P2 > fifo/il_P2 &
fmcalc -a2 < fifo/lb_il_P3 > fifo/il_P3 &
fmcalc -a2 < fifo/lb_il_P4 > fifo/il_P4 &
fmcalc -a2 < fifo/lb_il_P5 > fifo/il_P5 &
fmcalc -a2 < fifo/lb_il_P6 > fifo/il_P6 &
fmcalc -a2 < fifo/lb_il_P7 > fifo/il_P7 &
fmcalc -a2 < fifo/lb_il_P8 > fifo/il_P8 &
fmcalc -a2 < fifo/lb_il_P9 > fifo/il_P9 &
fmcalc -a2 < fifo/lb_il_P10 > fifo/il_P10 &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11 $pid12 $pid13 $pid14 $pid15 $pid16 $pid17 $pid18 $pid19 $pid20


# --- Do insured loss kats ---

kat -u work/kat/il_S1_eltcalc_P1 work/kat/il_S1_eltcalc_P2 work/kat/il_S1_eltcalc_P3 work/kat/il_S1_eltcalc_P4 work/kat/il_S1_eltcalc_P5 work/kat/il_S1_eltcalc_P6 work/kat/il_S1_eltcalc_P7 work/kat/il_S1_eltcalc_P8 work/kat/il_S1_eltcalc_P9 work/kat/il_S1_eltcalc_P10 work/kat/il_S1_eltcalc_P11 work/kat/il_S1_eltcalc_P12 work/kat/il_S1_eltcalc_P13 work/kat/il_S1_eltcalc_P14 work/kat/il_S1_eltcalc_P15 work/kat/il_S1_eltcalc_P16 work/kat/il_S1_eltcalc_P17 work/kat/il_S1_eltcalc_P18 work/kat/il_S1_eltcalc_P19 work/kat/il_S1_eltcalc_P20 > output/il_S1_eltcalc.csv & kpid1=$!
wait $kpid1


rm -R -f work/*
rm -R -f fifo/*
