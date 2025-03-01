#!/bin/bash

if [ ! -d "../tmp_kparse_output" ]; then
    echo 'no output in "tmp_kparse_output" to update - exit'
    exit 1
else 
    cp ../tmp_kparse_output/* .
fi

all_files=(
    all_calcs_1_output_1_partition.0.sh
    all_calcs_1_output_1_partition.output.sh
    all_calcs_1_output_1_partition.sh
    all_calcs_1_output_20_partition.0.sh
    all_calcs_1_output_20_partition.10.sh
    all_calcs_1_output_20_partition.11.sh
    all_calcs_1_output_20_partition.12.sh
    all_calcs_1_output_20_partition.13.sh
    all_calcs_1_output_20_partition.14.sh
    all_calcs_1_output_20_partition.15.sh
    all_calcs_1_output_20_partition.16.sh
    all_calcs_1_output_20_partition.17.sh
    all_calcs_1_output_20_partition.18.sh
    all_calcs_1_output_20_partition.19.sh
    all_calcs_1_output_20_partition.1.sh
    all_calcs_1_output_20_partition.2.sh
    all_calcs_1_output_20_partition.3.sh
    all_calcs_1_output_20_partition.4.sh
    all_calcs_1_output_20_partition.5.sh
    all_calcs_1_output_20_partition.6.sh
    all_calcs_1_output_20_partition.7.sh
    all_calcs_1_output_20_partition.8.sh
    all_calcs_1_output_20_partition.9.sh
    all_calcs_1_output_20_partition.output.sh
    all_calcs_1_output_20_partition.sh
    all_calcs_1_output_40_partition.0.sh
    all_calcs_1_output_40_partition.10.sh
    all_calcs_1_output_40_partition.11.sh
    all_calcs_1_output_40_partition.12.sh
    all_calcs_1_output_40_partition.13.sh
    all_calcs_1_output_40_partition.14.sh
    all_calcs_1_output_40_partition.15.sh
    all_calcs_1_output_40_partition.16.sh
    all_calcs_1_output_40_partition.17.sh
    all_calcs_1_output_40_partition.18.sh
    all_calcs_1_output_40_partition.19.sh
    all_calcs_1_output_40_partition.1.sh
    all_calcs_1_output_40_partition.20.sh
    all_calcs_1_output_40_partition.21.sh
    all_calcs_1_output_40_partition.22.sh
    all_calcs_1_output_40_partition.23.sh
    all_calcs_1_output_40_partition.24.sh
    all_calcs_1_output_40_partition.25.sh
    all_calcs_1_output_40_partition.26.sh
    all_calcs_1_output_40_partition.27.sh
    all_calcs_1_output_40_partition.28.sh
    all_calcs_1_output_40_partition.29.sh
    all_calcs_1_output_40_partition.2.sh
    all_calcs_1_output_40_partition.30.sh
    all_calcs_1_output_40_partition.31.sh
    all_calcs_1_output_40_partition.32.sh
    all_calcs_1_output_40_partition.33.sh
    all_calcs_1_output_40_partition.34.sh
    all_calcs_1_output_40_partition.35.sh
    all_calcs_1_output_40_partition.36.sh
    all_calcs_1_output_40_partition.37.sh
    all_calcs_1_output_40_partition.38.sh
    all_calcs_1_output_40_partition.39.sh
    all_calcs_1_output_40_partition.3.sh
    all_calcs_1_output_40_partition.4.sh
    all_calcs_1_output_40_partition.5.sh
    all_calcs_1_output_40_partition.6.sh
    all_calcs_1_output_40_partition.7.sh
    all_calcs_1_output_40_partition.8.sh
    all_calcs_1_output_40_partition.9.sh
    all_calcs_1_output_40_partition.output.sh
    all_calcs_1_output_40_partition.sh
    analysis_settings_1_1_partition.0.sh
    analysis_settings_1_1_partition.output.sh
    analysis_settings_1_1_partition.sh
    analysis_settings_2_1_partition.0.sh
    analysis_settings_2_1_partition.output.sh
    analysis_settings_2_1_partition.sh
    analysis_settings_3_1_reins_layer_1_partition.0.sh
    analysis_settings_3_1_reins_layer_1_partition.output.sh
    analysis_settings_3_1_reins_layer_1_partition.sh
    analysis_settings_4_1_reins_layer_1_partition.0.sh
    analysis_settings_4_1_reins_layer_1_partition.output.sh
    analysis_settings_4_1_reins_layer_1_partition.sh
    analysis_settings_5_1_reins_layer_1_partition.sh
    file-list
    gul_aalcalc_1_output_1_partition.0.sh
    gul_aalcalc_1_output_1_partition.output.sh
    gul_aalcalc_1_output_1_partition.sh
    gul_aalcalc_1_output_20_partition.0.sh
    gul_aalcalc_1_output_20_partition.10.sh
    gul_aalcalc_1_output_20_partition.11.sh
    gul_aalcalc_1_output_20_partition.12.sh
    gul_aalcalc_1_output_20_partition.13.sh
    gul_aalcalc_1_output_20_partition.14.sh
    gul_aalcalc_1_output_20_partition.15.sh
    gul_aalcalc_1_output_20_partition.16.sh
    gul_aalcalc_1_output_20_partition.17.sh
    gul_aalcalc_1_output_20_partition.18.sh
    gul_aalcalc_1_output_20_partition.19.sh
    gul_aalcalc_1_output_20_partition.1.sh
    gul_aalcalc_1_output_20_partition.2.sh
    gul_aalcalc_1_output_20_partition.3.sh
    gul_aalcalc_1_output_20_partition.4.sh
    gul_aalcalc_1_output_20_partition.5.sh
    gul_aalcalc_1_output_20_partition.6.sh
    gul_aalcalc_1_output_20_partition.7.sh
    gul_aalcalc_1_output_20_partition.8.sh
    gul_aalcalc_1_output_20_partition.9.sh
    gul_aalcalc_1_output_20_partition.output.sh
    gul_aalcalc_1_output_20_partition.sh
    gul_agg_fu_lec_1_output_1_partition.0.sh
    gul_agg_fu_lec_1_output_1_partition.output.sh
    gul_agg_fu_lec_1_output_1_partition.sh
    gul_agg_fu_lec_1_output_20_partition.0.sh
    gul_agg_fu_lec_1_output_20_partition.10.sh
    gul_agg_fu_lec_1_output_20_partition.11.sh
    gul_agg_fu_lec_1_output_20_partition.12.sh
    gul_agg_fu_lec_1_output_20_partition.13.sh
    gul_agg_fu_lec_1_output_20_partition.14.sh
    gul_agg_fu_lec_1_output_20_partition.15.sh
    gul_agg_fu_lec_1_output_20_partition.16.sh
    gul_agg_fu_lec_1_output_20_partition.17.sh
    gul_agg_fu_lec_1_output_20_partition.18.sh
    gul_agg_fu_lec_1_output_20_partition.19.sh
    gul_agg_fu_lec_1_output_20_partition.1.sh
    gul_agg_fu_lec_1_output_20_partition.2.sh
    gul_agg_fu_lec_1_output_20_partition.3.sh
    gul_agg_fu_lec_1_output_20_partition.4.sh
    gul_agg_fu_lec_1_output_20_partition.5.sh
    gul_agg_fu_lec_1_output_20_partition.6.sh
    gul_agg_fu_lec_1_output_20_partition.7.sh
    gul_agg_fu_lec_1_output_20_partition.8.sh
    gul_agg_fu_lec_1_output_20_partition.9.sh
    gul_agg_fu_lec_1_output_20_partition.output.sh
    gul_agg_fu_lec_1_output_20_partition.sh
    gul_agg_ws_lec_1_output_1_partition.0.sh
    gul_agg_ws_lec_1_output_1_partition.output.sh
    gul_agg_ws_lec_1_output_1_partition.sh
    gul_agg_ws_lec_1_output_20_partition.0.sh
    gul_agg_ws_lec_1_output_20_partition.10.sh
    gul_agg_ws_lec_1_output_20_partition.11.sh
    gul_agg_ws_lec_1_output_20_partition.12.sh
    gul_agg_ws_lec_1_output_20_partition.13.sh
    gul_agg_ws_lec_1_output_20_partition.14.sh
    gul_agg_ws_lec_1_output_20_partition.15.sh
    gul_agg_ws_lec_1_output_20_partition.16.sh
    gul_agg_ws_lec_1_output_20_partition.17.sh
    gul_agg_ws_lec_1_output_20_partition.18.sh
    gul_agg_ws_lec_1_output_20_partition.19.sh
    gul_agg_ws_lec_1_output_20_partition.1.sh
    gul_agg_ws_lec_1_output_20_partition.2.sh
    gul_agg_ws_lec_1_output_20_partition.3.sh
    gul_agg_ws_lec_1_output_20_partition.4.sh
    gul_agg_ws_lec_1_output_20_partition.5.sh
    gul_agg_ws_lec_1_output_20_partition.6.sh
    gul_agg_ws_lec_1_output_20_partition.7.sh
    gul_agg_ws_lec_1_output_20_partition.8.sh
    gul_agg_ws_lec_1_output_20_partition.9.sh
    gul_agg_ws_lec_1_output_20_partition.output.sh
    gul_agg_ws_lec_1_output_20_partition.sh
    gul_agg_ws_mean_lec_1_output_1_partition.0.sh
    gul_agg_ws_mean_lec_1_output_1_partition.output.sh
    gul_agg_ws_mean_lec_1_output_1_partition.sh
    gul_agg_ws_mean_lec_1_output_20_partition.0.sh
    gul_agg_ws_mean_lec_1_output_20_partition.10.sh
    gul_agg_ws_mean_lec_1_output_20_partition.11.sh
    gul_agg_ws_mean_lec_1_output_20_partition.12.sh
    gul_agg_ws_mean_lec_1_output_20_partition.13.sh
    gul_agg_ws_mean_lec_1_output_20_partition.14.sh
    gul_agg_ws_mean_lec_1_output_20_partition.15.sh
    gul_agg_ws_mean_lec_1_output_20_partition.16.sh
    gul_agg_ws_mean_lec_1_output_20_partition.17.sh
    gul_agg_ws_mean_lec_1_output_20_partition.18.sh
    gul_agg_ws_mean_lec_1_output_20_partition.19.sh
    gul_agg_ws_mean_lec_1_output_20_partition.1.sh
    gul_agg_ws_mean_lec_1_output_20_partition.2.sh
    gul_agg_ws_mean_lec_1_output_20_partition.3.sh
    gul_agg_ws_mean_lec_1_output_20_partition.4.sh
    gul_agg_ws_mean_lec_1_output_20_partition.5.sh
    gul_agg_ws_mean_lec_1_output_20_partition.6.sh
    gul_agg_ws_mean_lec_1_output_20_partition.7.sh
    gul_agg_ws_mean_lec_1_output_20_partition.8.sh
    gul_agg_ws_mean_lec_1_output_20_partition.9.sh
    gul_agg_ws_mean_lec_1_output_20_partition.output.sh
    gul_agg_ws_mean_lec_1_output_20_partition.sh
    gul_eltcalc_1_output_1_partition.0.sh
    gul_eltcalc_1_output_1_partition.output.sh
    gul_eltcalc_1_output_1_partition.sh
    gul_eltcalc_1_output_20_partition.0.sh
    gul_eltcalc_1_output_20_partition.10.sh
    gul_eltcalc_1_output_20_partition.11.sh
    gul_eltcalc_1_output_20_partition.12.sh
    gul_eltcalc_1_output_20_partition.13.sh
    gul_eltcalc_1_output_20_partition.14.sh
    gul_eltcalc_1_output_20_partition.15.sh
    gul_eltcalc_1_output_20_partition.16.sh
    gul_eltcalc_1_output_20_partition.17.sh
    gul_eltcalc_1_output_20_partition.18.sh
    gul_eltcalc_1_output_20_partition.19.sh
    gul_eltcalc_1_output_20_partition.1.sh
    gul_eltcalc_1_output_20_partition.2.sh
    gul_eltcalc_1_output_20_partition.3.sh
    gul_eltcalc_1_output_20_partition.4.sh
    gul_eltcalc_1_output_20_partition.5.sh
    gul_eltcalc_1_output_20_partition.6.sh
    gul_eltcalc_1_output_20_partition.7.sh
    gul_eltcalc_1_output_20_partition.8.sh
    gul_eltcalc_1_output_20_partition.9.sh
    gul_eltcalc_1_output_20_partition.output.sh
    gul_eltcalc_1_output_20_partition.sh
    gul_il_lec_1_output_1_partition.0.sh
    gul_il_lec_1_output_1_partition.output.sh
    gul_il_lec_1_output_1_partition.sh
    gul_il_lec_1_output_2_partition.0.sh
    gul_il_lec_1_output_2_partition.1.sh
    gul_il_lec_1_output_2_partition.output.sh
    gul_il_lec_1_output_2_partition.sh
    gul_il_lec_2_output_10_partition.0.sh
    gul_il_lec_2_output_10_partition.1.sh
    gul_il_lec_2_output_10_partition.2.sh
    gul_il_lec_2_output_10_partition.3.sh
    gul_il_lec_2_output_10_partition.4.sh
    gul_il_lec_2_output_10_partition.5.sh
    gul_il_lec_2_output_10_partition.6.sh
    gul_il_lec_2_output_10_partition.7.sh
    gul_il_lec_2_output_10_partition.8.sh
    gul_il_lec_2_output_10_partition.9.sh
    gul_il_lec_2_output_10_partition.output.sh
    gul_il_lec_2_output_10_partition.sh
    gul_il_lec_2_output_1_partition.0.sh
    gul_il_lec_2_output_1_partition.output.sh
    gul_il_lec_2_output_1_partition.sh
    gul_il_lec_2_output_2_partition.0.sh
    gul_il_lec_2_output_2_partition.1.sh
    gul_il_lec_2_output_2_partition.output.sh
    gul_il_lec_2_output_2_partition.sh
    gul_il_no_lec_1_output_1_partition.0.sh
    gul_il_no_lec_1_output_1_partition.output.sh
    gul_il_no_lec_1_output_1_partition.sh
    gul_il_no_lec_1_output_2_partition.0.sh
    gul_il_no_lec_1_output_2_partition.1.sh
    gul_il_no_lec_1_output_2_partition.output.sh
    gul_il_no_lec_1_output_2_partition.sh
    gul_il_no_lec_2_output_1_partition.0.sh
    gul_il_no_lec_2_output_1_partition.output.sh
    gul_il_no_lec_2_output_1_partition.sh
    gul_il_no_lec_2_output_2_partition.0.sh
    gul_il_no_lec_2_output_2_partition.1.sh
    gul_il_no_lec_2_output_2_partition.output.sh
    gul_il_no_lec_2_output_2_partition.sh
    gul_il_ord_ept_psept_2_output_10_partition.sh
    gul_il_ord_psept_lec_1_output_10_partition.sh
    gul_lec_1_output_1_partition.0.sh
    gul_lec_1_output_1_partition.output.sh
    gul_lec_1_output_1_partition.sh
    gul_lec_1_output_2_partition.0.sh
    gul_lec_1_output_2_partition.1.sh
    gul_lec_1_output_2_partition.output.sh
    gul_lec_1_output_2_partition.sh
    gul_lec_2_output_1_partition.0.sh
    gul_lec_2_output_1_partition.output.sh
    gul_lec_2_output_1_partition.sh
    gul_lec_2_output_2_partition.0.sh
    gul_lec_2_output_2_partition.1.sh
    gul_lec_2_output_2_partition.output.sh
    gul_lec_2_output_2_partition.sh
    gul_no_lec_1_output_1_partition.0.sh
    gul_no_lec_1_output_1_partition.output.sh
    gul_no_lec_1_output_1_partition.sh
    gul_no_lec_1_output_2_partition.0.sh
    gul_no_lec_1_output_2_partition.1.sh
    gul_no_lec_1_output_2_partition.output.sh
    gul_no_lec_1_output_2_partition.sh
    gul_no_lec_2_output_1_partition.0.sh
    gul_no_lec_2_output_1_partition.output.sh
    gul_no_lec_2_output_1_partition.sh
    gul_no_lec_2_output_2_partition.0.sh
    gul_no_lec_2_output_2_partition.1.sh
    gul_no_lec_2_output_2_partition.output.sh
    gul_no_lec_2_output_2_partition.sh
    gul_occ_fu_lec_1_output_1_partition.0.sh
    gul_occ_fu_lec_1_output_1_partition.output.sh
    gul_occ_fu_lec_1_output_1_partition.sh
    gul_occ_fu_lec_1_output_20_partition.0.sh
    gul_occ_fu_lec_1_output_20_partition.10.sh
    gul_occ_fu_lec_1_output_20_partition.11.sh
    gul_occ_fu_lec_1_output_20_partition.12.sh
    gul_occ_fu_lec_1_output_20_partition.13.sh
    gul_occ_fu_lec_1_output_20_partition.14.sh
    gul_occ_fu_lec_1_output_20_partition.15.sh
    gul_occ_fu_lec_1_output_20_partition.16.sh
    gul_occ_fu_lec_1_output_20_partition.17.sh
    gul_occ_fu_lec_1_output_20_partition.18.sh
    gul_occ_fu_lec_1_output_20_partition.19.sh
    gul_occ_fu_lec_1_output_20_partition.1.sh
    gul_occ_fu_lec_1_output_20_partition.2.sh
    gul_occ_fu_lec_1_output_20_partition.3.sh
    gul_occ_fu_lec_1_output_20_partition.4.sh
    gul_occ_fu_lec_1_output_20_partition.5.sh
    gul_occ_fu_lec_1_output_20_partition.6.sh
    gul_occ_fu_lec_1_output_20_partition.7.sh
    gul_occ_fu_lec_1_output_20_partition.8.sh
    gul_occ_fu_lec_1_output_20_partition.9.sh
    gul_occ_fu_lec_1_output_20_partition.output.sh
    gul_occ_fu_lec_1_output_20_partition.sh
    gul_occ_ws_lec_1_output_1_partition.0.sh
    gul_occ_ws_lec_1_output_1_partition.output.sh
    gul_occ_ws_lec_1_output_1_partition.sh
    gul_occ_ws_lec_1_output_20_partition.0.sh
    gul_occ_ws_lec_1_output_20_partition.10.sh
    gul_occ_ws_lec_1_output_20_partition.11.sh
    gul_occ_ws_lec_1_output_20_partition.12.sh
    gul_occ_ws_lec_1_output_20_partition.13.sh
    gul_occ_ws_lec_1_output_20_partition.14.sh
    gul_occ_ws_lec_1_output_20_partition.15.sh
    gul_occ_ws_lec_1_output_20_partition.16.sh
    gul_occ_ws_lec_1_output_20_partition.17.sh
    gul_occ_ws_lec_1_output_20_partition.18.sh
    gul_occ_ws_lec_1_output_20_partition.19.sh
    gul_occ_ws_lec_1_output_20_partition.1.sh
    gul_occ_ws_lec_1_output_20_partition.2.sh
    gul_occ_ws_lec_1_output_20_partition.3.sh
    gul_occ_ws_lec_1_output_20_partition.4.sh
    gul_occ_ws_lec_1_output_20_partition.5.sh
    gul_occ_ws_lec_1_output_20_partition.6.sh
    gul_occ_ws_lec_1_output_20_partition.7.sh
    gul_occ_ws_lec_1_output_20_partition.8.sh
    gul_occ_ws_lec_1_output_20_partition.9.sh
    gul_occ_ws_lec_1_output_20_partition.output.sh
    gul_occ_ws_lec_1_output_20_partition.sh
    gul_occ_ws_mean_lec_1_output_1_partition.0.sh
    gul_occ_ws_mean_lec_1_output_1_partition.output.sh
    gul_occ_ws_mean_lec_1_output_1_partition.sh
    gul_occ_ws_mean_lec_1_output_20_partition.0.sh
    gul_occ_ws_mean_lec_1_output_20_partition.10.sh
    gul_occ_ws_mean_lec_1_output_20_partition.11.sh
    gul_occ_ws_mean_lec_1_output_20_partition.12.sh
    gul_occ_ws_mean_lec_1_output_20_partition.13.sh
    gul_occ_ws_mean_lec_1_output_20_partition.14.sh
    gul_occ_ws_mean_lec_1_output_20_partition.15.sh
    gul_occ_ws_mean_lec_1_output_20_partition.16.sh
    gul_occ_ws_mean_lec_1_output_20_partition.17.sh
    gul_occ_ws_mean_lec_1_output_20_partition.18.sh
    gul_occ_ws_mean_lec_1_output_20_partition.19.sh
    gul_occ_ws_mean_lec_1_output_20_partition.1.sh
    gul_occ_ws_mean_lec_1_output_20_partition.2.sh
    gul_occ_ws_mean_lec_1_output_20_partition.3.sh
    gul_occ_ws_mean_lec_1_output_20_partition.4.sh
    gul_occ_ws_mean_lec_1_output_20_partition.5.sh
    gul_occ_ws_mean_lec_1_output_20_partition.6.sh
    gul_occ_ws_mean_lec_1_output_20_partition.7.sh
    gul_occ_ws_mean_lec_1_output_20_partition.8.sh
    gul_occ_ws_mean_lec_1_output_20_partition.9.sh
    gul_occ_ws_mean_lec_1_output_20_partition.output.sh
    gul_occ_ws_mean_lec_1_output_20_partition.sh
    gul_ord_ept_1_output_1_partition.sh
    gul_ord_ept_1_output_20_partition.sh
    gul_ord_ept_psept_lec_2_output_10_partition.sh
    gul_ord_psept_2_output_10_partition.sh
    gul_pltcalc_1_output_1_partition.0.sh
    gul_pltcalc_1_output_1_partition.output.sh
    gul_pltcalc_1_output_1_partition.sh
    gul_pltcalc_1_output_20_partition.0.sh
    gul_pltcalc_1_output_20_partition.10.sh
    gul_pltcalc_1_output_20_partition.11.sh
    gul_pltcalc_1_output_20_partition.12.sh
    gul_pltcalc_1_output_20_partition.13.sh
    gul_pltcalc_1_output_20_partition.14.sh
    gul_pltcalc_1_output_20_partition.15.sh
    gul_pltcalc_1_output_20_partition.16.sh
    gul_pltcalc_1_output_20_partition.17.sh
    gul_pltcalc_1_output_20_partition.18.sh
    gul_pltcalc_1_output_20_partition.19.sh
    gul_pltcalc_1_output_20_partition.1.sh
    gul_pltcalc_1_output_20_partition.2.sh
    gul_pltcalc_1_output_20_partition.3.sh
    gul_pltcalc_1_output_20_partition.4.sh
    gul_pltcalc_1_output_20_partition.5.sh
    gul_pltcalc_1_output_20_partition.6.sh
    gul_pltcalc_1_output_20_partition.7.sh
    gul_pltcalc_1_output_20_partition.8.sh
    gul_pltcalc_1_output_20_partition.9.sh
    gul_pltcalc_1_output_20_partition.output.sh
    gul_pltcalc_1_output_20_partition.sh
    gul_summarycalc_1_output_1_partition.0.sh
    gul_summarycalc_1_output_1_partition.output.sh
    gul_summarycalc_1_output_1_partition.sh
    gul_summarycalc_1_output_20_partition.0.sh
    gul_summarycalc_1_output_20_partition.10.sh
    gul_summarycalc_1_output_20_partition.11.sh
    gul_summarycalc_1_output_20_partition.12.sh
    gul_summarycalc_1_output_20_partition.13.sh
    gul_summarycalc_1_output_20_partition.14.sh
    gul_summarycalc_1_output_20_partition.15.sh
    gul_summarycalc_1_output_20_partition.16.sh
    gul_summarycalc_1_output_20_partition.17.sh
    gul_summarycalc_1_output_20_partition.18.sh
    gul_summarycalc_1_output_20_partition.19.sh
    gul_summarycalc_1_output_20_partition.1.sh
    gul_summarycalc_1_output_20_partition.2.sh
    gul_summarycalc_1_output_20_partition.3.sh
    gul_summarycalc_1_output_20_partition.4.sh
    gul_summarycalc_1_output_20_partition.5.sh
    gul_summarycalc_1_output_20_partition.6.sh
    gul_summarycalc_1_output_20_partition.7.sh
    gul_summarycalc_1_output_20_partition.8.sh
    gul_summarycalc_1_output_20_partition.9.sh
    gul_summarycalc_1_output_20_partition.output.sh
    gul_summarycalc_1_output_20_partition.sh
    il_aalcalc_1_output_1_partition.0.sh
    il_aalcalc_1_output_1_partition.output.sh
    il_aalcalc_1_output_1_partition.sh
    il_aalcalc_1_output_20_partition.0.sh
    il_aalcalc_1_output_20_partition.10.sh
    il_aalcalc_1_output_20_partition.11.sh
    il_aalcalc_1_output_20_partition.12.sh
    il_aalcalc_1_output_20_partition.13.sh
    il_aalcalc_1_output_20_partition.14.sh
    il_aalcalc_1_output_20_partition.15.sh
    il_aalcalc_1_output_20_partition.16.sh
    il_aalcalc_1_output_20_partition.17.sh
    il_aalcalc_1_output_20_partition.18.sh
    il_aalcalc_1_output_20_partition.19.sh
    il_aalcalc_1_output_20_partition.1.sh
    il_aalcalc_1_output_20_partition.2.sh
    il_aalcalc_1_output_20_partition.3.sh
    il_aalcalc_1_output_20_partition.4.sh
    il_aalcalc_1_output_20_partition.5.sh
    il_aalcalc_1_output_20_partition.6.sh
    il_aalcalc_1_output_20_partition.7.sh
    il_aalcalc_1_output_20_partition.8.sh
    il_aalcalc_1_output_20_partition.9.sh
    il_aalcalc_1_output_20_partition.output.sh
    il_aalcalc_1_output_20_partition.sh
    il_agg_fu_lec_1_output_1_partition.0.sh
    il_agg_fu_lec_1_output_1_partition.output.sh
    il_agg_fu_lec_1_output_1_partition.sh
    il_agg_fu_lec_1_output_20_partition.0.sh
    il_agg_fu_lec_1_output_20_partition.10.sh
    il_agg_fu_lec_1_output_20_partition.11.sh
    il_agg_fu_lec_1_output_20_partition.12.sh
    il_agg_fu_lec_1_output_20_partition.13.sh
    il_agg_fu_lec_1_output_20_partition.14.sh
    il_agg_fu_lec_1_output_20_partition.15.sh
    il_agg_fu_lec_1_output_20_partition.16.sh
    il_agg_fu_lec_1_output_20_partition.17.sh
    il_agg_fu_lec_1_output_20_partition.18.sh
    il_agg_fu_lec_1_output_20_partition.19.sh
    il_agg_fu_lec_1_output_20_partition.1.sh
    il_agg_fu_lec_1_output_20_partition.2.sh
    il_agg_fu_lec_1_output_20_partition.3.sh
    il_agg_fu_lec_1_output_20_partition.4.sh
    il_agg_fu_lec_1_output_20_partition.5.sh
    il_agg_fu_lec_1_output_20_partition.6.sh
    il_agg_fu_lec_1_output_20_partition.7.sh
    il_agg_fu_lec_1_output_20_partition.8.sh
    il_agg_fu_lec_1_output_20_partition.9.sh
    il_agg_fu_lec_1_output_20_partition.output.sh
    il_agg_fu_lec_1_output_20_partition.sh
    il_agg_sample_mean_lec_1_output_1_partition.0.sh
    il_agg_sample_mean_lec_1_output_1_partition.output.sh
    il_agg_sample_mean_lec_1_output_1_partition.sh
    il_agg_sample_mean_lec_1_output_20_partition.0.sh
    il_agg_sample_mean_lec_1_output_20_partition.10.sh
    il_agg_sample_mean_lec_1_output_20_partition.11.sh
    il_agg_sample_mean_lec_1_output_20_partition.12.sh
    il_agg_sample_mean_lec_1_output_20_partition.13.sh
    il_agg_sample_mean_lec_1_output_20_partition.14.sh
    il_agg_sample_mean_lec_1_output_20_partition.15.sh
    il_agg_sample_mean_lec_1_output_20_partition.16.sh
    il_agg_sample_mean_lec_1_output_20_partition.17.sh
    il_agg_sample_mean_lec_1_output_20_partition.18.sh
    il_agg_sample_mean_lec_1_output_20_partition.19.sh
    il_agg_sample_mean_lec_1_output_20_partition.1.sh
    il_agg_sample_mean_lec_1_output_20_partition.2.sh
    il_agg_sample_mean_lec_1_output_20_partition.3.sh
    il_agg_sample_mean_lec_1_output_20_partition.4.sh
    il_agg_sample_mean_lec_1_output_20_partition.5.sh
    il_agg_sample_mean_lec_1_output_20_partition.6.sh
    il_agg_sample_mean_lec_1_output_20_partition.7.sh
    il_agg_sample_mean_lec_1_output_20_partition.8.sh
    il_agg_sample_mean_lec_1_output_20_partition.9.sh
    il_agg_sample_mean_lec_1_output_20_partition.output.sh
    il_agg_sample_mean_lec_1_output_20_partition.sh
    il_agg_ws_lec_1_output_1_partition.0.sh
    il_agg_ws_lec_1_output_1_partition.output.sh
    il_agg_ws_lec_1_output_1_partition.sh
    il_agg_ws_lec_1_output_20_partition.0.sh
    il_agg_ws_lec_1_output_20_partition.10.sh
    il_agg_ws_lec_1_output_20_partition.11.sh
    il_agg_ws_lec_1_output_20_partition.12.sh
    il_agg_ws_lec_1_output_20_partition.13.sh
    il_agg_ws_lec_1_output_20_partition.14.sh
    il_agg_ws_lec_1_output_20_partition.15.sh
    il_agg_ws_lec_1_output_20_partition.16.sh
    il_agg_ws_lec_1_output_20_partition.17.sh
    il_agg_ws_lec_1_output_20_partition.18.sh
    il_agg_ws_lec_1_output_20_partition.19.sh
    il_agg_ws_lec_1_output_20_partition.1.sh
    il_agg_ws_lec_1_output_20_partition.2.sh
    il_agg_ws_lec_1_output_20_partition.3.sh
    il_agg_ws_lec_1_output_20_partition.4.sh
    il_agg_ws_lec_1_output_20_partition.5.sh
    il_agg_ws_lec_1_output_20_partition.6.sh
    il_agg_ws_lec_1_output_20_partition.7.sh
    il_agg_ws_lec_1_output_20_partition.8.sh
    il_agg_ws_lec_1_output_20_partition.9.sh
    il_agg_ws_lec_1_output_20_partition.output.sh
    il_agg_ws_lec_1_output_20_partition.sh
    il_agg_ws_mean_lec_1_output_1_partition.0.sh
    il_agg_ws_mean_lec_1_output_1_partition.output.sh
    il_agg_ws_mean_lec_1_output_1_partition.sh
    il_agg_ws_mean_lec_1_output_20_partition.0.sh
    il_agg_ws_mean_lec_1_output_20_partition.10.sh
    il_agg_ws_mean_lec_1_output_20_partition.11.sh
    il_agg_ws_mean_lec_1_output_20_partition.12.sh
    il_agg_ws_mean_lec_1_output_20_partition.13.sh
    il_agg_ws_mean_lec_1_output_20_partition.14.sh
    il_agg_ws_mean_lec_1_output_20_partition.15.sh
    il_agg_ws_mean_lec_1_output_20_partition.16.sh
    il_agg_ws_mean_lec_1_output_20_partition.17.sh
    il_agg_ws_mean_lec_1_output_20_partition.18.sh
    il_agg_ws_mean_lec_1_output_20_partition.19.sh
    il_agg_ws_mean_lec_1_output_20_partition.1.sh
    il_agg_ws_mean_lec_1_output_20_partition.2.sh
    il_agg_ws_mean_lec_1_output_20_partition.3.sh
    il_agg_ws_mean_lec_1_output_20_partition.4.sh
    il_agg_ws_mean_lec_1_output_20_partition.5.sh
    il_agg_ws_mean_lec_1_output_20_partition.6.sh
    il_agg_ws_mean_lec_1_output_20_partition.7.sh
    il_agg_ws_mean_lec_1_output_20_partition.8.sh
    il_agg_ws_mean_lec_1_output_20_partition.9.sh
    il_agg_ws_mean_lec_1_output_20_partition.output.sh
    il_agg_ws_mean_lec_1_output_20_partition.sh
    il_eltcalc_1_output_1_partition.0.sh
    il_eltcalc_1_output_1_partition.output.sh
    il_eltcalc_1_output_1_partition.sh
    il_eltcalc_1_output_20_partition.0.sh
    il_eltcalc_1_output_20_partition.10.sh
    il_eltcalc_1_output_20_partition.11.sh
    il_eltcalc_1_output_20_partition.12.sh
    il_eltcalc_1_output_20_partition.13.sh
    il_eltcalc_1_output_20_partition.14.sh
    il_eltcalc_1_output_20_partition.15.sh
    il_eltcalc_1_output_20_partition.16.sh
    il_eltcalc_1_output_20_partition.17.sh
    il_eltcalc_1_output_20_partition.18.sh
    il_eltcalc_1_output_20_partition.19.sh
    il_eltcalc_1_output_20_partition.1.sh
    il_eltcalc_1_output_20_partition.2.sh
    il_eltcalc_1_output_20_partition.3.sh
    il_eltcalc_1_output_20_partition.4.sh
    il_eltcalc_1_output_20_partition.5.sh
    il_eltcalc_1_output_20_partition.6.sh
    il_eltcalc_1_output_20_partition.7.sh
    il_eltcalc_1_output_20_partition.8.sh
    il_eltcalc_1_output_20_partition.9.sh
    il_eltcalc_1_output_20_partition.output.sh
    il_eltcalc_1_output_20_partition.sh
    il_lec_1_output_1_partition.0.sh
    il_lec_1_output_1_partition.output.sh
    il_lec_1_output_1_partition.sh
    il_lec_1_output_2_partition.0.sh
    il_lec_1_output_2_partition.1.sh
    il_lec_1_output_2_partition.output.sh
    il_lec_1_output_2_partition.sh
    il_lec_2_output_1_partition.0.sh
    il_lec_2_output_1_partition.output.sh
    il_lec_2_output_1_partition.sh
    il_lec_2_output_2_partition.0.sh
    il_lec_2_output_2_partition.1.sh
    il_lec_2_output_2_partition.output.sh
    il_lec_2_output_2_partition.sh
    il_no_lec_1_output_1_partition.0.sh
    il_no_lec_1_output_1_partition.output.sh
    il_no_lec_1_output_1_partition.sh
    il_no_lec_1_output_2_partition.0.sh
    il_no_lec_1_output_2_partition.1.sh
    il_no_lec_1_output_2_partition.output.sh
    il_no_lec_1_output_2_partition.sh
    il_no_lec_2_output_1_partition.0.sh
    il_no_lec_2_output_1_partition.output.sh
    il_no_lec_2_output_1_partition.sh
    il_no_lec_2_output_2_partition.0.sh
    il_no_lec_2_output_2_partition.1.sh
    il_no_lec_2_output_2_partition.output.sh
    il_no_lec_2_output_2_partition.sh
    il_occ_fu_lec_1_output_1_partition.0.sh
    il_occ_fu_lec_1_output_1_partition.output.sh
    il_occ_fu_lec_1_output_1_partition.sh
    il_occ_fu_lec_1_output_20_partition.0.sh
    il_occ_fu_lec_1_output_20_partition.10.sh
    il_occ_fu_lec_1_output_20_partition.11.sh
    il_occ_fu_lec_1_output_20_partition.12.sh
    il_occ_fu_lec_1_output_20_partition.13.sh
    il_occ_fu_lec_1_output_20_partition.14.sh
    il_occ_fu_lec_1_output_20_partition.15.sh
    il_occ_fu_lec_1_output_20_partition.16.sh
    il_occ_fu_lec_1_output_20_partition.17.sh
    il_occ_fu_lec_1_output_20_partition.18.sh
    il_occ_fu_lec_1_output_20_partition.19.sh
    il_occ_fu_lec_1_output_20_partition.1.sh
    il_occ_fu_lec_1_output_20_partition.2.sh
    il_occ_fu_lec_1_output_20_partition.3.sh
    il_occ_fu_lec_1_output_20_partition.4.sh
    il_occ_fu_lec_1_output_20_partition.5.sh
    il_occ_fu_lec_1_output_20_partition.6.sh
    il_occ_fu_lec_1_output_20_partition.7.sh
    il_occ_fu_lec_1_output_20_partition.8.sh
    il_occ_fu_lec_1_output_20_partition.9.sh
    il_occ_fu_lec_1_output_20_partition.output.sh
    il_occ_fu_lec_1_output_20_partition.sh
    il_occ_sample_mean_lec_1_output_1_partition.0.sh
    il_occ_sample_mean_lec_1_output_1_partition.output.sh
    il_occ_sample_mean_lec_1_output_1_partition.sh
    il_occ_sample_mean_lec_1_output_20_partition.0.sh
    il_occ_sample_mean_lec_1_output_20_partition.10.sh
    il_occ_sample_mean_lec_1_output_20_partition.11.sh
    il_occ_sample_mean_lec_1_output_20_partition.12.sh
    il_occ_sample_mean_lec_1_output_20_partition.13.sh
    il_occ_sample_mean_lec_1_output_20_partition.14.sh
    il_occ_sample_mean_lec_1_output_20_partition.15.sh
    il_occ_sample_mean_lec_1_output_20_partition.16.sh
    il_occ_sample_mean_lec_1_output_20_partition.17.sh
    il_occ_sample_mean_lec_1_output_20_partition.18.sh
    il_occ_sample_mean_lec_1_output_20_partition.19.sh
    il_occ_sample_mean_lec_1_output_20_partition.1.sh
    il_occ_sample_mean_lec_1_output_20_partition.2.sh
    il_occ_sample_mean_lec_1_output_20_partition.3.sh
    il_occ_sample_mean_lec_1_output_20_partition.4.sh
    il_occ_sample_mean_lec_1_output_20_partition.5.sh
    il_occ_sample_mean_lec_1_output_20_partition.6.sh
    il_occ_sample_mean_lec_1_output_20_partition.7.sh
    il_occ_sample_mean_lec_1_output_20_partition.8.sh
    il_occ_sample_mean_lec_1_output_20_partition.9.sh
    il_occ_sample_mean_lec_1_output_20_partition.output.sh
    il_occ_sample_mean_lec_1_output_20_partition.sh
    il_occ_ws_lec_1_output_1_partition.0.sh
    il_occ_ws_lec_1_output_1_partition.output.sh
    il_occ_ws_lec_1_output_1_partition.sh
    il_occ_ws_lec_1_output_20_partition.0.sh
    il_occ_ws_lec_1_output_20_partition.10.sh
    il_occ_ws_lec_1_output_20_partition.11.sh
    il_occ_ws_lec_1_output_20_partition.12.sh
    il_occ_ws_lec_1_output_20_partition.13.sh
    il_occ_ws_lec_1_output_20_partition.14.sh
    il_occ_ws_lec_1_output_20_partition.15.sh
    il_occ_ws_lec_1_output_20_partition.16.sh
    il_occ_ws_lec_1_output_20_partition.17.sh
    il_occ_ws_lec_1_output_20_partition.18.sh
    il_occ_ws_lec_1_output_20_partition.19.sh
    il_occ_ws_lec_1_output_20_partition.1.sh
    il_occ_ws_lec_1_output_20_partition.2.sh
    il_occ_ws_lec_1_output_20_partition.3.sh
    il_occ_ws_lec_1_output_20_partition.4.sh
    il_occ_ws_lec_1_output_20_partition.5.sh
    il_occ_ws_lec_1_output_20_partition.6.sh
    il_occ_ws_lec_1_output_20_partition.7.sh
    il_occ_ws_lec_1_output_20_partition.8.sh
    il_occ_ws_lec_1_output_20_partition.9.sh
    il_occ_ws_lec_1_output_20_partition.output.sh
    il_occ_ws_lec_1_output_20_partition.sh
    il_occ_ws_mean_lec_1_output_1_partition.0.sh
    il_occ_ws_mean_lec_1_output_1_partition.output.sh
    il_occ_ws_mean_lec_1_output_1_partition.sh
    il_occ_ws_mean_lec_1_output_20_partition.0.sh
    il_occ_ws_mean_lec_1_output_20_partition.10.sh
    il_occ_ws_mean_lec_1_output_20_partition.11.sh
    il_occ_ws_mean_lec_1_output_20_partition.12.sh
    il_occ_ws_mean_lec_1_output_20_partition.13.sh
    il_occ_ws_mean_lec_1_output_20_partition.14.sh
    il_occ_ws_mean_lec_1_output_20_partition.15.sh
    il_occ_ws_mean_lec_1_output_20_partition.16.sh
    il_occ_ws_mean_lec_1_output_20_partition.17.sh
    il_occ_ws_mean_lec_1_output_20_partition.18.sh
    il_occ_ws_mean_lec_1_output_20_partition.19.sh
    il_occ_ws_mean_lec_1_output_20_partition.1.sh
    il_occ_ws_mean_lec_1_output_20_partition.2.sh
    il_occ_ws_mean_lec_1_output_20_partition.3.sh
    il_occ_ws_mean_lec_1_output_20_partition.4.sh
    il_occ_ws_mean_lec_1_output_20_partition.5.sh
    il_occ_ws_mean_lec_1_output_20_partition.6.sh
    il_occ_ws_mean_lec_1_output_20_partition.7.sh
    il_occ_ws_mean_lec_1_output_20_partition.8.sh
    il_occ_ws_mean_lec_1_output_20_partition.9.sh
    il_occ_ws_mean_lec_1_output_20_partition.output.sh
    il_occ_ws_mean_lec_1_output_20_partition.sh
    il_pltcalc_1_output_1_partition.0.sh
    il_pltcalc_1_output_1_partition.output.sh
    il_pltcalc_1_output_1_partition.sh
    il_pltcalc_1_output_20_partition.0.sh
    il_pltcalc_1_output_20_partition.10.sh
    il_pltcalc_1_output_20_partition.11.sh
    il_pltcalc_1_output_20_partition.12.sh
    il_pltcalc_1_output_20_partition.13.sh
    il_pltcalc_1_output_20_partition.14.sh
    il_pltcalc_1_output_20_partition.15.sh
    il_pltcalc_1_output_20_partition.16.sh
    il_pltcalc_1_output_20_partition.17.sh
    il_pltcalc_1_output_20_partition.18.sh
    il_pltcalc_1_output_20_partition.19.sh
    il_pltcalc_1_output_20_partition.1.sh
    il_pltcalc_1_output_20_partition.2.sh
    il_pltcalc_1_output_20_partition.3.sh
    il_pltcalc_1_output_20_partition.4.sh
    il_pltcalc_1_output_20_partition.5.sh
    il_pltcalc_1_output_20_partition.6.sh
    il_pltcalc_1_output_20_partition.7.sh
    il_pltcalc_1_output_20_partition.8.sh
    il_pltcalc_1_output_20_partition.9.sh
    il_pltcalc_1_output_20_partition.output.sh
    il_pltcalc_1_output_20_partition.sh
    il_summarycalc_1_output_1_partition.0.sh
    il_summarycalc_1_output_1_partition.output.sh
    il_summarycalc_1_output_1_partition.sh
    il_summarycalc_1_output_20_partition.0.sh
    il_summarycalc_1_output_20_partition.10.sh
    il_summarycalc_1_output_20_partition.11.sh
    il_summarycalc_1_output_20_partition.12.sh
    il_summarycalc_1_output_20_partition.13.sh
    il_summarycalc_1_output_20_partition.14.sh
    il_summarycalc_1_output_20_partition.15.sh
    il_summarycalc_1_output_20_partition.16.sh
    il_summarycalc_1_output_20_partition.17.sh
    il_summarycalc_1_output_20_partition.18.sh
    il_summarycalc_1_output_20_partition.19.sh
    il_summarycalc_1_output_20_partition.1.sh
    il_summarycalc_1_output_20_partition.2.sh
    il_summarycalc_1_output_20_partition.3.sh
    il_summarycalc_1_output_20_partition.4.sh
    il_summarycalc_1_output_20_partition.5.sh
    il_summarycalc_1_output_20_partition.6.sh
    il_summarycalc_1_output_20_partition.7.sh
    il_summarycalc_1_output_20_partition.8.sh
    il_summarycalc_1_output_20_partition.9.sh
    il_summarycalc_1_output_20_partition.output.sh
    il_summarycalc_1_output_20_partition.sh
    analysis_settings_5_1_reins_layer_1_partition.sh
	gul_il_ord_ept_psept_2_output_10_partition.sh
	gul_il_ord_psept_lec_1_output_10_partition.sh
	gul_ord_ept_1_output_1_partition.sh
	gul_ord_ept_1_output_20_partition.sh
	gul_ord_ept_psept_lec_2_output_10_partition.sh
	gul_ord_psept_2_output_10_partition.sh
    gul_ord_palt_output_10_partition.sh
    gul_il_ord_palt_output_10_partition.sh
)

for f in "${all_files[@]}"; do 
    echo $f
    sed -i 's|/tmp/[a-zA-Z0-9]*/|/tmp/%FIFO_DIR%/|g' $f
done 
