#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

set -e
set -o pipefail
mkdir -p log
rm -R -f log/*


touch log/stderror.err
ktools_monitor.sh $$ & pid0=$!

exit_handler(){
   exit_code=$?
   kill -9 $pid0 2> /dev/null
   if [ "$exit_code" -gt 0 ]; then
       echo 'Ktools Run Error - exitcode='$exit_code
   else
       echo 'Run Completed'
   fi

   set +x
   group_pid=$(ps -p $$ -o pgid --no-headers)
   sess_pid=$(ps -p $$ -o sess --no-headers)
   script_pid=$$
   printf "Script PID:%d, GPID:%s, SPID:%d
" $script_pid $group_pid $sess_pid >> log/killout.txt

   ps f -g $sess_pid > log/subprocess_list
   PIDS_KILL=$(pgrep -a --pgroup $group_pid | awk 'BEGIN { FS = "[ \t\n]+" }{ if ($1 >= '$script_pid') print}' | grep -v celery | grep -v *.sh)
   echo "$PIDS_KILL" >> log/killout.txt
   kill -9 $(echo "$PIDS_KILL" | awk 'BEGIN { FS = "[ \t\n]+" }{ print $1 }') 2>/dev/null
   exit $exit_code
}
trap exit_handler QUIT HUP INT KILL TERM ERR EXIT

check_complete(){
    set +e
    proc_list="eve getmodel gulcalc fmcalc summarycalc eltcalc aalcalc leccalc pltcalc ordleccalc"
    has_error=0
    for p in $proc_list; do
        started=$(find log -name "$p*.log" | wc -l)
        finished=$(find log -name "$p*.log" -exec grep -l "finish" {} + | wc -l)
        if [ "$finished" -lt "$started" ]; then
            echo "[ERROR] $p - $((started-finished)) processes lost"
            has_error=1
        elif [ "$started" -gt 0 ]; then
            echo "[OK] $p"
        fi
    done
    if [ "$has_error" -ne 0 ]; then
        false # raise non-zero exit code
    fi
}
# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -exec rm -R -f {} +

rm -R -f fifo/*
rm -R -f work/*
mkdir work/kat/

mkdir work/gul_S1_summaryleccalc
mkdir work/gul_S1_summaryaalcalc
mkdir work/il_S1_summaryleccalc
mkdir work/il_S1_summaryaalcalc

mkfifo fifo/gul_P1
mkfifo fifo/gul_P2
mkfifo fifo/gul_P3
mkfifo fifo/gul_P4
mkfifo fifo/gul_P5
mkfifo fifo/gul_P6
mkfifo fifo/gul_P7
mkfifo fifo/gul_P8
mkfifo fifo/gul_P9
mkfifo fifo/gul_P10

mkfifo fifo/gul_S1_summary_P1
mkfifo fifo/gul_S1_eltcalc_P1
mkfifo fifo/gul_S1_summarycalc_P1
mkfifo fifo/gul_S1_pltcalc_P1

mkfifo fifo/gul_S1_summary_P2
mkfifo fifo/gul_S1_eltcalc_P2
mkfifo fifo/gul_S1_summarycalc_P2
mkfifo fifo/gul_S1_pltcalc_P2

mkfifo fifo/gul_S1_summary_P3
mkfifo fifo/gul_S1_eltcalc_P3
mkfifo fifo/gul_S1_summarycalc_P3
mkfifo fifo/gul_S1_pltcalc_P3

mkfifo fifo/gul_S1_summary_P4
mkfifo fifo/gul_S1_eltcalc_P4
mkfifo fifo/gul_S1_summarycalc_P4
mkfifo fifo/gul_S1_pltcalc_P4

mkfifo fifo/gul_S1_summary_P5
mkfifo fifo/gul_S1_eltcalc_P5
mkfifo fifo/gul_S1_summarycalc_P5
mkfifo fifo/gul_S1_pltcalc_P5

mkfifo fifo/gul_S1_summary_P6
mkfifo fifo/gul_S1_eltcalc_P6
mkfifo fifo/gul_S1_summarycalc_P6
mkfifo fifo/gul_S1_pltcalc_P6

mkfifo fifo/gul_S1_summary_P7
mkfifo fifo/gul_S1_eltcalc_P7
mkfifo fifo/gul_S1_summarycalc_P7
mkfifo fifo/gul_S1_pltcalc_P7

mkfifo fifo/gul_S1_summary_P8
mkfifo fifo/gul_S1_eltcalc_P8
mkfifo fifo/gul_S1_summarycalc_P8
mkfifo fifo/gul_S1_pltcalc_P8

mkfifo fifo/gul_S1_summary_P9
mkfifo fifo/gul_S1_eltcalc_P9
mkfifo fifo/gul_S1_summarycalc_P9
mkfifo fifo/gul_S1_pltcalc_P9

mkfifo fifo/gul_S1_summary_P10
mkfifo fifo/gul_S1_eltcalc_P10
mkfifo fifo/gul_S1_summarycalc_P10
mkfifo fifo/gul_S1_pltcalc_P10

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
mkfifo fifo/il_S1_summarycalc_P1
mkfifo fifo/il_S1_pltcalc_P1

mkfifo fifo/il_S1_summary_P2
mkfifo fifo/il_S1_eltcalc_P2
mkfifo fifo/il_S1_summarycalc_P2
mkfifo fifo/il_S1_pltcalc_P2

mkfifo fifo/il_S1_summary_P3
mkfifo fifo/il_S1_eltcalc_P3
mkfifo fifo/il_S1_summarycalc_P3
mkfifo fifo/il_S1_pltcalc_P3

mkfifo fifo/il_S1_summary_P4
mkfifo fifo/il_S1_eltcalc_P4
mkfifo fifo/il_S1_summarycalc_P4
mkfifo fifo/il_S1_pltcalc_P4

mkfifo fifo/il_S1_summary_P5
mkfifo fifo/il_S1_eltcalc_P5
mkfifo fifo/il_S1_summarycalc_P5
mkfifo fifo/il_S1_pltcalc_P5

mkfifo fifo/il_S1_summary_P6
mkfifo fifo/il_S1_eltcalc_P6
mkfifo fifo/il_S1_summarycalc_P6
mkfifo fifo/il_S1_pltcalc_P6

mkfifo fifo/il_S1_summary_P7
mkfifo fifo/il_S1_eltcalc_P7
mkfifo fifo/il_S1_summarycalc_P7
mkfifo fifo/il_S1_pltcalc_P7

mkfifo fifo/il_S1_summary_P8
mkfifo fifo/il_S1_eltcalc_P8
mkfifo fifo/il_S1_summarycalc_P8
mkfifo fifo/il_S1_pltcalc_P8

mkfifo fifo/il_S1_summary_P9
mkfifo fifo/il_S1_eltcalc_P9
mkfifo fifo/il_S1_summarycalc_P9
mkfifo fifo/il_S1_pltcalc_P9

mkfifo fifo/il_S1_summary_P10
mkfifo fifo/il_S1_eltcalc_P10
mkfifo fifo/il_S1_summarycalc_P10
mkfifo fifo/il_S1_pltcalc_P10



# --- Do insured loss computes ---

( eltcalc < fifo/il_S1_eltcalc_P1 > work/kat/il_S1_eltcalc_P1 ) 2>> log/stderror.err & pid1=$!
( summarycalctocsv < fifo/il_S1_summarycalc_P1 > work/kat/il_S1_summarycalc_P1 ) 2>> log/stderror.err & pid2=$!
( pltcalc < fifo/il_S1_pltcalc_P1 > work/kat/il_S1_pltcalc_P1 ) 2>> log/stderror.err & pid3=$!
( eltcalc -s < fifo/il_S1_eltcalc_P2 > work/kat/il_S1_eltcalc_P2 ) 2>> log/stderror.err & pid4=$!
( summarycalctocsv -s < fifo/il_S1_summarycalc_P2 > work/kat/il_S1_summarycalc_P2 ) 2>> log/stderror.err & pid5=$!
( pltcalc -s < fifo/il_S1_pltcalc_P2 > work/kat/il_S1_pltcalc_P2 ) 2>> log/stderror.err & pid6=$!
( eltcalc -s < fifo/il_S1_eltcalc_P3 > work/kat/il_S1_eltcalc_P3 ) 2>> log/stderror.err & pid7=$!
( summarycalctocsv -s < fifo/il_S1_summarycalc_P3 > work/kat/il_S1_summarycalc_P3 ) 2>> log/stderror.err & pid8=$!
( pltcalc -s < fifo/il_S1_pltcalc_P3 > work/kat/il_S1_pltcalc_P3 ) 2>> log/stderror.err & pid9=$!
( eltcalc -s < fifo/il_S1_eltcalc_P4 > work/kat/il_S1_eltcalc_P4 ) 2>> log/stderror.err & pid10=$!
( summarycalctocsv -s < fifo/il_S1_summarycalc_P4 > work/kat/il_S1_summarycalc_P4 ) 2>> log/stderror.err & pid11=$!
( pltcalc -s < fifo/il_S1_pltcalc_P4 > work/kat/il_S1_pltcalc_P4 ) 2>> log/stderror.err & pid12=$!
( eltcalc -s < fifo/il_S1_eltcalc_P5 > work/kat/il_S1_eltcalc_P5 ) 2>> log/stderror.err & pid13=$!
( summarycalctocsv -s < fifo/il_S1_summarycalc_P5 > work/kat/il_S1_summarycalc_P5 ) 2>> log/stderror.err & pid14=$!
( pltcalc -s < fifo/il_S1_pltcalc_P5 > work/kat/il_S1_pltcalc_P5 ) 2>> log/stderror.err & pid15=$!
( eltcalc -s < fifo/il_S1_eltcalc_P6 > work/kat/il_S1_eltcalc_P6 ) 2>> log/stderror.err & pid16=$!
( summarycalctocsv -s < fifo/il_S1_summarycalc_P6 > work/kat/il_S1_summarycalc_P6 ) 2>> log/stderror.err & pid17=$!
( pltcalc -s < fifo/il_S1_pltcalc_P6 > work/kat/il_S1_pltcalc_P6 ) 2>> log/stderror.err & pid18=$!
( eltcalc -s < fifo/il_S1_eltcalc_P7 > work/kat/il_S1_eltcalc_P7 ) 2>> log/stderror.err & pid19=$!
( summarycalctocsv -s < fifo/il_S1_summarycalc_P7 > work/kat/il_S1_summarycalc_P7 ) 2>> log/stderror.err & pid20=$!
( pltcalc -s < fifo/il_S1_pltcalc_P7 > work/kat/il_S1_pltcalc_P7 ) 2>> log/stderror.err & pid21=$!
( eltcalc -s < fifo/il_S1_eltcalc_P8 > work/kat/il_S1_eltcalc_P8 ) 2>> log/stderror.err & pid22=$!
( summarycalctocsv -s < fifo/il_S1_summarycalc_P8 > work/kat/il_S1_summarycalc_P8 ) 2>> log/stderror.err & pid23=$!
( pltcalc -s < fifo/il_S1_pltcalc_P8 > work/kat/il_S1_pltcalc_P8 ) 2>> log/stderror.err & pid24=$!
( eltcalc -s < fifo/il_S1_eltcalc_P9 > work/kat/il_S1_eltcalc_P9 ) 2>> log/stderror.err & pid25=$!
( summarycalctocsv -s < fifo/il_S1_summarycalc_P9 > work/kat/il_S1_summarycalc_P9 ) 2>> log/stderror.err & pid26=$!
( pltcalc -s < fifo/il_S1_pltcalc_P9 > work/kat/il_S1_pltcalc_P9 ) 2>> log/stderror.err & pid27=$!
( eltcalc -s < fifo/il_S1_eltcalc_P10 > work/kat/il_S1_eltcalc_P10 ) 2>> log/stderror.err & pid28=$!
( summarycalctocsv -s < fifo/il_S1_summarycalc_P10 > work/kat/il_S1_summarycalc_P10 ) 2>> log/stderror.err & pid29=$!
( pltcalc -s < fifo/il_S1_pltcalc_P10 > work/kat/il_S1_pltcalc_P10 ) 2>> log/stderror.err & pid30=$!

tee < fifo/il_S1_summary_P1 fifo/il_S1_eltcalc_P1 fifo/il_S1_summarycalc_P1 fifo/il_S1_pltcalc_P1 work/il_S1_summaryaalcalc/P1.bin work/il_S1_summaryleccalc/P1.bin > /dev/null & pid31=$!
tee < fifo/il_S1_summary_P2 fifo/il_S1_eltcalc_P2 fifo/il_S1_summarycalc_P2 fifo/il_S1_pltcalc_P2 work/il_S1_summaryaalcalc/P2.bin work/il_S1_summaryleccalc/P2.bin > /dev/null & pid32=$!
tee < fifo/il_S1_summary_P3 fifo/il_S1_eltcalc_P3 fifo/il_S1_summarycalc_P3 fifo/il_S1_pltcalc_P3 work/il_S1_summaryaalcalc/P3.bin work/il_S1_summaryleccalc/P3.bin > /dev/null & pid33=$!
tee < fifo/il_S1_summary_P4 fifo/il_S1_eltcalc_P4 fifo/il_S1_summarycalc_P4 fifo/il_S1_pltcalc_P4 work/il_S1_summaryaalcalc/P4.bin work/il_S1_summaryleccalc/P4.bin > /dev/null & pid34=$!
tee < fifo/il_S1_summary_P5 fifo/il_S1_eltcalc_P5 fifo/il_S1_summarycalc_P5 fifo/il_S1_pltcalc_P5 work/il_S1_summaryaalcalc/P5.bin work/il_S1_summaryleccalc/P5.bin > /dev/null & pid35=$!
tee < fifo/il_S1_summary_P6 fifo/il_S1_eltcalc_P6 fifo/il_S1_summarycalc_P6 fifo/il_S1_pltcalc_P6 work/il_S1_summaryaalcalc/P6.bin work/il_S1_summaryleccalc/P6.bin > /dev/null & pid36=$!
tee < fifo/il_S1_summary_P7 fifo/il_S1_eltcalc_P7 fifo/il_S1_summarycalc_P7 fifo/il_S1_pltcalc_P7 work/il_S1_summaryaalcalc/P7.bin work/il_S1_summaryleccalc/P7.bin > /dev/null & pid37=$!
tee < fifo/il_S1_summary_P8 fifo/il_S1_eltcalc_P8 fifo/il_S1_summarycalc_P8 fifo/il_S1_pltcalc_P8 work/il_S1_summaryaalcalc/P8.bin work/il_S1_summaryleccalc/P8.bin > /dev/null & pid38=$!
tee < fifo/il_S1_summary_P9 fifo/il_S1_eltcalc_P9 fifo/il_S1_summarycalc_P9 fifo/il_S1_pltcalc_P9 work/il_S1_summaryaalcalc/P9.bin work/il_S1_summaryleccalc/P9.bin > /dev/null & pid39=$!
tee < fifo/il_S1_summary_P10 fifo/il_S1_eltcalc_P10 fifo/il_S1_summarycalc_P10 fifo/il_S1_pltcalc_P10 work/il_S1_summaryaalcalc/P10.bin work/il_S1_summaryleccalc/P10.bin > /dev/null & pid40=$!

( summarycalc -f  -1 fifo/il_S1_summary_P1 < fifo/il_P1 ) 2>> log/stderror.err  &
( summarycalc -f  -1 fifo/il_S1_summary_P2 < fifo/il_P2 ) 2>> log/stderror.err  &
( summarycalc -f  -1 fifo/il_S1_summary_P3 < fifo/il_P3 ) 2>> log/stderror.err  &
( summarycalc -f  -1 fifo/il_S1_summary_P4 < fifo/il_P4 ) 2>> log/stderror.err  &
( summarycalc -f  -1 fifo/il_S1_summary_P5 < fifo/il_P5 ) 2>> log/stderror.err  &
( summarycalc -f  -1 fifo/il_S1_summary_P6 < fifo/il_P6 ) 2>> log/stderror.err  &
( summarycalc -f  -1 fifo/il_S1_summary_P7 < fifo/il_P7 ) 2>> log/stderror.err  &
( summarycalc -f  -1 fifo/il_S1_summary_P8 < fifo/il_P8 ) 2>> log/stderror.err  &
( summarycalc -f  -1 fifo/il_S1_summary_P9 < fifo/il_P9 ) 2>> log/stderror.err  &
( summarycalc -f  -1 fifo/il_S1_summary_P10 < fifo/il_P10 ) 2>> log/stderror.err  &

# --- Do ground up loss computes ---

( eltcalc < fifo/gul_S1_eltcalc_P1 > work/kat/gul_S1_eltcalc_P1 ) 2>> log/stderror.err & pid41=$!
( summarycalctocsv < fifo/gul_S1_summarycalc_P1 > work/kat/gul_S1_summarycalc_P1 ) 2>> log/stderror.err & pid42=$!
( pltcalc < fifo/gul_S1_pltcalc_P1 > work/kat/gul_S1_pltcalc_P1 ) 2>> log/stderror.err & pid43=$!
( eltcalc -s < fifo/gul_S1_eltcalc_P2 > work/kat/gul_S1_eltcalc_P2 ) 2>> log/stderror.err & pid44=$!
( summarycalctocsv -s < fifo/gul_S1_summarycalc_P2 > work/kat/gul_S1_summarycalc_P2 ) 2>> log/stderror.err & pid45=$!
( pltcalc -s < fifo/gul_S1_pltcalc_P2 > work/kat/gul_S1_pltcalc_P2 ) 2>> log/stderror.err & pid46=$!
( eltcalc -s < fifo/gul_S1_eltcalc_P3 > work/kat/gul_S1_eltcalc_P3 ) 2>> log/stderror.err & pid47=$!
( summarycalctocsv -s < fifo/gul_S1_summarycalc_P3 > work/kat/gul_S1_summarycalc_P3 ) 2>> log/stderror.err & pid48=$!
( pltcalc -s < fifo/gul_S1_pltcalc_P3 > work/kat/gul_S1_pltcalc_P3 ) 2>> log/stderror.err & pid49=$!
( eltcalc -s < fifo/gul_S1_eltcalc_P4 > work/kat/gul_S1_eltcalc_P4 ) 2>> log/stderror.err & pid50=$!
( summarycalctocsv -s < fifo/gul_S1_summarycalc_P4 > work/kat/gul_S1_summarycalc_P4 ) 2>> log/stderror.err & pid51=$!
( pltcalc -s < fifo/gul_S1_pltcalc_P4 > work/kat/gul_S1_pltcalc_P4 ) 2>> log/stderror.err & pid52=$!
( eltcalc -s < fifo/gul_S1_eltcalc_P5 > work/kat/gul_S1_eltcalc_P5 ) 2>> log/stderror.err & pid53=$!
( summarycalctocsv -s < fifo/gul_S1_summarycalc_P5 > work/kat/gul_S1_summarycalc_P5 ) 2>> log/stderror.err & pid54=$!
( pltcalc -s < fifo/gul_S1_pltcalc_P5 > work/kat/gul_S1_pltcalc_P5 ) 2>> log/stderror.err & pid55=$!
( eltcalc -s < fifo/gul_S1_eltcalc_P6 > work/kat/gul_S1_eltcalc_P6 ) 2>> log/stderror.err & pid56=$!
( summarycalctocsv -s < fifo/gul_S1_summarycalc_P6 > work/kat/gul_S1_summarycalc_P6 ) 2>> log/stderror.err & pid57=$!
( pltcalc -s < fifo/gul_S1_pltcalc_P6 > work/kat/gul_S1_pltcalc_P6 ) 2>> log/stderror.err & pid58=$!
( eltcalc -s < fifo/gul_S1_eltcalc_P7 > work/kat/gul_S1_eltcalc_P7 ) 2>> log/stderror.err & pid59=$!
( summarycalctocsv -s < fifo/gul_S1_summarycalc_P7 > work/kat/gul_S1_summarycalc_P7 ) 2>> log/stderror.err & pid60=$!
( pltcalc -s < fifo/gul_S1_pltcalc_P7 > work/kat/gul_S1_pltcalc_P7 ) 2>> log/stderror.err & pid61=$!
( eltcalc -s < fifo/gul_S1_eltcalc_P8 > work/kat/gul_S1_eltcalc_P8 ) 2>> log/stderror.err & pid62=$!
( summarycalctocsv -s < fifo/gul_S1_summarycalc_P8 > work/kat/gul_S1_summarycalc_P8 ) 2>> log/stderror.err & pid63=$!
( pltcalc -s < fifo/gul_S1_pltcalc_P8 > work/kat/gul_S1_pltcalc_P8 ) 2>> log/stderror.err & pid64=$!
( eltcalc -s < fifo/gul_S1_eltcalc_P9 > work/kat/gul_S1_eltcalc_P9 ) 2>> log/stderror.err & pid65=$!
( summarycalctocsv -s < fifo/gul_S1_summarycalc_P9 > work/kat/gul_S1_summarycalc_P9 ) 2>> log/stderror.err & pid66=$!
( pltcalc -s < fifo/gul_S1_pltcalc_P9 > work/kat/gul_S1_pltcalc_P9 ) 2>> log/stderror.err & pid67=$!
( eltcalc -s < fifo/gul_S1_eltcalc_P10 > work/kat/gul_S1_eltcalc_P10 ) 2>> log/stderror.err & pid68=$!
( summarycalctocsv -s < fifo/gul_S1_summarycalc_P10 > work/kat/gul_S1_summarycalc_P10 ) 2>> log/stderror.err & pid69=$!
( pltcalc -s < fifo/gul_S1_pltcalc_P10 > work/kat/gul_S1_pltcalc_P10 ) 2>> log/stderror.err & pid70=$!

tee < fifo/gul_S1_summary_P1 fifo/gul_S1_eltcalc_P1 fifo/gul_S1_summarycalc_P1 fifo/gul_S1_pltcalc_P1 work/gul_S1_summaryaalcalc/P1.bin work/gul_S1_summaryleccalc/P1.bin > /dev/null & pid71=$!
tee < fifo/gul_S1_summary_P2 fifo/gul_S1_eltcalc_P2 fifo/gul_S1_summarycalc_P2 fifo/gul_S1_pltcalc_P2 work/gul_S1_summaryaalcalc/P2.bin work/gul_S1_summaryleccalc/P2.bin > /dev/null & pid72=$!
tee < fifo/gul_S1_summary_P3 fifo/gul_S1_eltcalc_P3 fifo/gul_S1_summarycalc_P3 fifo/gul_S1_pltcalc_P3 work/gul_S1_summaryaalcalc/P3.bin work/gul_S1_summaryleccalc/P3.bin > /dev/null & pid73=$!
tee < fifo/gul_S1_summary_P4 fifo/gul_S1_eltcalc_P4 fifo/gul_S1_summarycalc_P4 fifo/gul_S1_pltcalc_P4 work/gul_S1_summaryaalcalc/P4.bin work/gul_S1_summaryleccalc/P4.bin > /dev/null & pid74=$!
tee < fifo/gul_S1_summary_P5 fifo/gul_S1_eltcalc_P5 fifo/gul_S1_summarycalc_P5 fifo/gul_S1_pltcalc_P5 work/gul_S1_summaryaalcalc/P5.bin work/gul_S1_summaryleccalc/P5.bin > /dev/null & pid75=$!
tee < fifo/gul_S1_summary_P6 fifo/gul_S1_eltcalc_P6 fifo/gul_S1_summarycalc_P6 fifo/gul_S1_pltcalc_P6 work/gul_S1_summaryaalcalc/P6.bin work/gul_S1_summaryleccalc/P6.bin > /dev/null & pid76=$!
tee < fifo/gul_S1_summary_P7 fifo/gul_S1_eltcalc_P7 fifo/gul_S1_summarycalc_P7 fifo/gul_S1_pltcalc_P7 work/gul_S1_summaryaalcalc/P7.bin work/gul_S1_summaryleccalc/P7.bin > /dev/null & pid77=$!
tee < fifo/gul_S1_summary_P8 fifo/gul_S1_eltcalc_P8 fifo/gul_S1_summarycalc_P8 fifo/gul_S1_pltcalc_P8 work/gul_S1_summaryaalcalc/P8.bin work/gul_S1_summaryleccalc/P8.bin > /dev/null & pid78=$!
tee < fifo/gul_S1_summary_P9 fifo/gul_S1_eltcalc_P9 fifo/gul_S1_summarycalc_P9 fifo/gul_S1_pltcalc_P9 work/gul_S1_summaryaalcalc/P9.bin work/gul_S1_summaryleccalc/P9.bin > /dev/null & pid79=$!
tee < fifo/gul_S1_summary_P10 fifo/gul_S1_eltcalc_P10 fifo/gul_S1_summarycalc_P10 fifo/gul_S1_pltcalc_P10 work/gul_S1_summaryaalcalc/P10.bin work/gul_S1_summaryleccalc/P10.bin > /dev/null & pid80=$!

( summarycalc -i  -1 fifo/gul_S1_summary_P1 < fifo/gul_P1 ) 2>> log/stderror.err  &
( summarycalc -i  -1 fifo/gul_S1_summary_P2 < fifo/gul_P2 ) 2>> log/stderror.err  &
( summarycalc -i  -1 fifo/gul_S1_summary_P3 < fifo/gul_P3 ) 2>> log/stderror.err  &
( summarycalc -i  -1 fifo/gul_S1_summary_P4 < fifo/gul_P4 ) 2>> log/stderror.err  &
( summarycalc -i  -1 fifo/gul_S1_summary_P5 < fifo/gul_P5 ) 2>> log/stderror.err  &
( summarycalc -i  -1 fifo/gul_S1_summary_P6 < fifo/gul_P6 ) 2>> log/stderror.err  &
( summarycalc -i  -1 fifo/gul_S1_summary_P7 < fifo/gul_P7 ) 2>> log/stderror.err  &
( summarycalc -i  -1 fifo/gul_S1_summary_P8 < fifo/gul_P8 ) 2>> log/stderror.err  &
( summarycalc -i  -1 fifo/gul_S1_summary_P9 < fifo/gul_P9 ) 2>> log/stderror.err  &
( summarycalc -i  -1 fifo/gul_S1_summary_P10 < fifo/gul_P10 ) 2>> log/stderror.err  &

( eve 1 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P1 | fmcalc -a2 > fifo/il_P1  ) 2>> log/stderror.err &
( eve 2 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P2 | fmcalc -a2 > fifo/il_P2  ) 2>> log/stderror.err &
( eve 3 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P3 | fmcalc -a2 > fifo/il_P3  ) 2>> log/stderror.err &
( eve 4 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P4 | fmcalc -a2 > fifo/il_P4  ) 2>> log/stderror.err &
( eve 5 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P5 | fmcalc -a2 > fifo/il_P5  ) 2>> log/stderror.err &
( eve 6 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P6 | fmcalc -a2 > fifo/il_P6  ) 2>> log/stderror.err &
( eve 7 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P7 | fmcalc -a2 > fifo/il_P7  ) 2>> log/stderror.err &
( eve 8 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P8 | fmcalc -a2 > fifo/il_P8  ) 2>> log/stderror.err &
( eve 9 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P9 | fmcalc -a2 > fifo/il_P9  ) 2>> log/stderror.err &
( eve 10 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee fifo/gul_P10 | fmcalc -a2 > fifo/il_P10  ) 2>> log/stderror.err &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11 $pid12 $pid13 $pid14 $pid15 $pid16 $pid17 $pid18 $pid19 $pid20 $pid21 $pid22 $pid23 $pid24 $pid25 $pid26 $pid27 $pid28 $pid29 $pid30 $pid31 $pid32 $pid33 $pid34 $pid35 $pid36 $pid37 $pid38 $pid39 $pid40 $pid41 $pid42 $pid43 $pid44 $pid45 $pid46 $pid47 $pid48 $pid49 $pid50 $pid51 $pid52 $pid53 $pid54 $pid55 $pid56 $pid57 $pid58 $pid59 $pid60 $pid61 $pid62 $pid63 $pid64 $pid65 $pid66 $pid67 $pid68 $pid69 $pid70 $pid71 $pid72 $pid73 $pid74 $pid75 $pid76 $pid77 $pid78 $pid79 $pid80


# --- Do insured loss kats ---

kat -s work/kat/il_S1_eltcalc_P1 work/kat/il_S1_eltcalc_P2 work/kat/il_S1_eltcalc_P3 work/kat/il_S1_eltcalc_P4 work/kat/il_S1_eltcalc_P5 work/kat/il_S1_eltcalc_P6 work/kat/il_S1_eltcalc_P7 work/kat/il_S1_eltcalc_P8 work/kat/il_S1_eltcalc_P9 work/kat/il_S1_eltcalc_P10 > output/il_S1_eltcalc.csv & kpid1=$!
kat work/kat/il_S1_pltcalc_P1 work/kat/il_S1_pltcalc_P2 work/kat/il_S1_pltcalc_P3 work/kat/il_S1_pltcalc_P4 work/kat/il_S1_pltcalc_P5 work/kat/il_S1_pltcalc_P6 work/kat/il_S1_pltcalc_P7 work/kat/il_S1_pltcalc_P8 work/kat/il_S1_pltcalc_P9 work/kat/il_S1_pltcalc_P10 > output/il_S1_pltcalc.csv & kpid2=$!
kat work/kat/il_S1_summarycalc_P1 work/kat/il_S1_summarycalc_P2 work/kat/il_S1_summarycalc_P3 work/kat/il_S1_summarycalc_P4 work/kat/il_S1_summarycalc_P5 work/kat/il_S1_summarycalc_P6 work/kat/il_S1_summarycalc_P7 work/kat/il_S1_summarycalc_P8 work/kat/il_S1_summarycalc_P9 work/kat/il_S1_summarycalc_P10 > output/il_S1_summarycalc.csv & kpid3=$!

# --- Do ground up loss kats ---

kat -s work/kat/gul_S1_eltcalc_P1 work/kat/gul_S1_eltcalc_P2 work/kat/gul_S1_eltcalc_P3 work/kat/gul_S1_eltcalc_P4 work/kat/gul_S1_eltcalc_P5 work/kat/gul_S1_eltcalc_P6 work/kat/gul_S1_eltcalc_P7 work/kat/gul_S1_eltcalc_P8 work/kat/gul_S1_eltcalc_P9 work/kat/gul_S1_eltcalc_P10 > output/gul_S1_eltcalc.csv & kpid4=$!
kat work/kat/gul_S1_pltcalc_P1 work/kat/gul_S1_pltcalc_P2 work/kat/gul_S1_pltcalc_P3 work/kat/gul_S1_pltcalc_P4 work/kat/gul_S1_pltcalc_P5 work/kat/gul_S1_pltcalc_P6 work/kat/gul_S1_pltcalc_P7 work/kat/gul_S1_pltcalc_P8 work/kat/gul_S1_pltcalc_P9 work/kat/gul_S1_pltcalc_P10 > output/gul_S1_pltcalc.csv & kpid5=$!
kat work/kat/gul_S1_summarycalc_P1 work/kat/gul_S1_summarycalc_P2 work/kat/gul_S1_summarycalc_P3 work/kat/gul_S1_summarycalc_P4 work/kat/gul_S1_summarycalc_P5 work/kat/gul_S1_summarycalc_P6 work/kat/gul_S1_summarycalc_P7 work/kat/gul_S1_summarycalc_P8 work/kat/gul_S1_summarycalc_P9 work/kat/gul_S1_summarycalc_P10 > output/gul_S1_summarycalc.csv & kpid6=$!
wait $kpid1 $kpid2 $kpid3 $kpid4 $kpid5 $kpid6


( aalcalc -Kil_S1_summaryaalcalc > output/il_S1_aalcalc.csv ) 2>> log/stderror.err & lpid1=$!
( ordleccalc -r -Kil_S1_summaryleccalc -W -w -o output/il_S1_psept.csv ) 2>> log/stderror.err & lpid2=$!
( leccalc -r -Kil_S1_summaryleccalc -F output/il_S1_leccalc_full_uncertainty_aep.csv -f output/il_S1_leccalc_full_uncertainty_oep.csv -S output/il_S1_leccalc_sample_mean_aep.csv -s output/il_S1_leccalc_sample_mean_oep.csv -W output/il_S1_leccalc_wheatsheaf_aep.csv -M output/il_S1_leccalc_wheatsheaf_mean_aep.csv -m output/il_S1_leccalc_wheatsheaf_mean_oep.csv -w output/il_S1_leccalc_wheatsheaf_oep.csv ) 2>> log/stderror.err & lpid3=$!
( aalcalc -Kgul_S1_summaryaalcalc > output/gul_S1_aalcalc.csv ) 2>> log/stderror.err & lpid4=$!
( ordleccalc  -Kgul_S1_summaryleccalc -W -w -o output/gul_S1_psept.csv ) 2>> log/stderror.err & lpid5=$!
( leccalc -r -Kgul_S1_summaryleccalc -F output/gul_S1_leccalc_full_uncertainty_aep.csv -f output/gul_S1_leccalc_full_uncertainty_oep.csv -S output/gul_S1_leccalc_sample_mean_aep.csv -s output/gul_S1_leccalc_sample_mean_oep.csv -W output/gul_S1_leccalc_wheatsheaf_aep.csv -M output/gul_S1_leccalc_wheatsheaf_mean_aep.csv -m output/gul_S1_leccalc_wheatsheaf_mean_oep.csv -w output/gul_S1_leccalc_wheatsheaf_oep.csv ) 2>> log/stderror.err & lpid6=$!
wait $lpid1 $lpid2 $lpid3 $lpid4 $lpid5 $lpid6

rm -R -f work/*
rm -R -f fifo/*

check_complete
exit_handler
