clc
clear
close all
EXP = 5;

fs = 10000;
Ts = 1/fs;
use_filter = 0;
PLOT_ECGS = 0;
SUBPLOTTED = 0;


if EXP == 2
    EXP_folder = "EXP002/";
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R1
    data = load(EXP_folder+'raton1_est_anestesia.mat');
    [ECG, stim_reference, d3, fs, time] = extract_data(data);
    leg                         = "R1-EST-AN - EXP002";
    th                          = 0.4;
    
    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end
    
    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
  
    leg_1                       = leg;
    time_1                      = time;
    stim_ref_1                  = stim_reference;
    ECG_1                       = ECG;
    locs_P_1                    = locs_P;
    locs_Q_1                    = locs_Q;
    locs_R_1                    = locs_R;
    locs_S_1                    = locs_S;
    locs_T_1                    = locs_T;
    PR_1                        = PR;
    PS_1                        = PS;
    RS_1                        = RS;
    RT_1                        = RT;
    QRS_1                       = QRS;
    QT_1                        = QT;
    ST_1                        = ST;
    RT_voltage_1                = RT_voltage;
    time_intervals_bpm_1        = time_intervals_bpm;
    BPM_1                       = BPM;
  

    %%%%%%%%%%%%%%%%%%%%%%%%% R2
    data = load(EXP_folder+'raton2_no_est_anestesia.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);   
    leg                          = "R2-FAKE - EXP002";
    th = 0.6;

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_2                       = leg;
    time_2                      = time;
    stim_ref_2                  = stim_reference;
    ECG_2                       = ECG;
    locs_P_2                    = locs_P;
    locs_Q_2                    = locs_Q;
    locs_R_2                    = locs_R;
    locs_S_2                    = locs_S;
    locs_T_2                    = locs_T;
    PR_2                        = PR;
    PS_2                        = PS;
    RS_2                        = RS;
    RT_2                        = RT;
    QRS_2                       = QRS;
    QT_2                        = QT;
    ST_2                        = ST;
    RT_voltage_2                = RT_voltage;
    time_intervals_bpm_2        = time_intervals_bpm;
    BPM_2                       = BPM;

elseif EXP == 3
    EXP_folder = "EXP003/inhaled/";
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R1
    data = load(EXP_folder+'RATON1-AN+EST.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);  
    leg                          = "R1-AN-EST - EXP003";
    th = 0.6;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end
    
    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_1                       = leg;
    time_1                      = time;
    stim_ref_1                  = stim_reference;
    ECG_1                       = ECG;
    locs_P_1                    = locs_P;
    locs_Q_1                    = locs_Q;
    locs_R_1                    = locs_R;
    locs_S_1                    = locs_S;
    locs_T_1                    = locs_T;
    PR_1                        = PR;
    PS_1                        = PS;
    RS_1                        = RS;
    RT_1                        = RT;
    QRS_1                       = QRS;
    QT_1                        = QT;
    ST_1                        = ST;
    RT_voltage_1                = RT_voltage;
    time_intervals_bpm_1        = time_intervals_bpm;
    BPM_1                       = BPM;

    
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R2
    data = load(EXP_folder+'RATON2-EST-AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);  
    leg                          = "R2-EST-AN - EXP003";
    th = 0.6;
    
    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_2                       = leg;
    time_2                      = time;
    stim_ref_2                  = stim_reference;
    ECG_2                       = ECG;
    locs_P_2                    = locs_P;
    locs_Q_2                    = locs_Q;
    locs_R_2                    = locs_R;
    locs_S_2                    = locs_S;
    locs_T_2                    = locs_T;
    PR_2                        = PR;
    PS_2                        = PS;
    RS_2                        = RS;
    RT_2                        = RT;
    QRS_2                       = QRS;
    QT_2                        = QT;
    ST_2                        = ST;
    RT_voltage_2                = RT_voltage;
    time_intervals_bpm_2        = time_intervals_bpm;
    BPM_2                       = BPM;

    
    %%%%%%%%%%%%%%%%%%%%%%%%% R3
    data = load(EXP_folder+'RATON3-EST-AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                        = "R3-EST-40AN - EXP004";
    th = 0.6;
    
    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_3                       = leg;
    time_3                      = time;
    stim_ref_3                  = stim_reference;
    ECG_3                       = ECG;
    locs_P_3                    = locs_P;
    locs_Q_3                    = locs_Q;
    locs_R_3                    = locs_R;
    locs_S_3                    = locs_S;
    locs_T_3                    = locs_T;
    PR_3                        = PR;
    PS_3                        = PS;
    RS_3                        = RS;
    RT_3                        = RT;
    QRS_3                       = QRS;
    QT_3                        = QT;
    ST_3                        = ST;
    RT_voltage_3                = RT_voltage;
    time_intervals_bpm_3        = time_intervals_bpm;
    BPM_3                       = BPM;

    %%%%%%%%%%%%%%%%%%%%%%%%% R4
    data = load(EXP_folder+'RATON4-CONTROL-FALSAEST-AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);    
    leg                      = "R4-EST-40AN - EXP004";
    th = 0.6;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_4                       = leg;
    time_4                      = time;
    stim_ref_4                  = stim_reference;
    ECG_4                       = ECG;
    locs_P_4                    = locs_P;
    locs_Q_4                    = locs_Q;
    locs_R_4                    = locs_R;
    locs_S_4                    = locs_S;
    locs_T_4                    = locs_T;
    PR_4                        = PR;
    PS_4                        = PS;
    RS_4                        = RS;
    RT_4                        = RT;
    QRS_4                       = QRS;
    QT_4                        = QT;
    ST_4                        = ST;
    RT_voltage_4                = RT_voltage;
    time_intervals_bpm_4        = time_intervals_bpm;
    BPM_4                       = BPM;
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R5
    data = load(EXP_folder+'RATON5-CONTROL-AN-FALSAEST.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                      = "R5-FAKE - EXP004";
    th = 0.6;
    
    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_5                       = leg;
    time_5                      = time;
    stim_ref_5                  = stim_reference;
    ECG_5                       = ECG;
    locs_P_5                    = locs_P;
    locs_Q_5                    = locs_Q;
    locs_R_5                    = locs_R;
    locs_S_5                    = locs_S;
    locs_T_5                    = locs_T;
    PR_5                        = PR;
    PS_5                        = PS;
    RS_5                        = RS;
    RT_5                        = RT;
    QRS_5                       = QRS;
    QT_5                        = QT;
    ST_5                        = ST;
    RT_voltage_5                = RT_voltage;
    time_intervals_bpm_5        = time_intervals_bpm;
    BPM_5                       = BPM;

elseif EXP == 3.2
    EXP_folder = "EXP003/no_inhaled/";
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R1
    data = load(EXP_folder+'RATON1-30+EST.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                          = "R1-AN-EST - EXP003";
    th = 0.6;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_1                       = leg;
    time_1                      = time;
    stim_ref_1                  = stim_reference;
    ECG_1                       = ECG;
    locs_P_1                    = locs_P;
    locs_Q_1                    = locs_Q;
    locs_R_1                    = locs_R;
    locs_S_1                    = locs_S;
    locs_T_1                    = locs_T;
    PR_1                        = PR;
    PS_1                        = PS;
    RS_1                        = RS;
    RT_1                        = RT;
    QRS_1                       = QRS;
    QT_1                        = QT;
    ST_1                        = ST;
    RT_voltage_1                = RT_voltage;
    time_intervals_bpm_1        = time_intervals_bpm;
    BPM_1                       = BPM;


    %%%%%%%%%%%%%%%%%%%%%%%%% R2
    data = load(EXP_folder+'RATON2-EST+30.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                          = "R2-EST-AN - EXP003";
    th = 0.6;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_2                       = leg;
    time_2                      = time;
    stim_ref_2                  = stim_reference;
    ECG_2                       = ECG;
    locs_P_2                    = locs_P;
    locs_Q_2                    = locs_Q;
    locs_R_2                    = locs_R;
    locs_S_2                    = locs_S;
    locs_T_2                    = locs_T;
    PR_2                        = PR;
    PS_2                        = PS;
    RS_2                        = RS;
    RT_2                        = RT;
    QRS_2                       = QRS;
    QT_2                        = QT;
    ST_2                        = ST;
    RT_voltage_2                = RT_voltage;
    time_intervals_bpm_2        = time_intervals_bpm;
    BPM_2                       = BPM;




    %%%%%%%%%%%%%%%%%%%%%%%%% R3-1
    data = load(EXP_folder+'RATON3-EST+15 (1PARTE).mat');
    [ECG, stim_reference, ~, ~, time] = extract_data(data);
    th = 0.6;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    stim_ref_31  = stim_reference;
    ECG_31       = ECG;   

    time_31      = time;
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R3-2
    data = load(EXP_folder+'RATON3-POST EST-(2PARTE).mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);

    stim_ref_3                  = [stim_reference; stim_ref_31];
    ECG_3                       = [ECG_31; ECG];
    time_3                      = [time_31, time];
    leg_3                       = "R3-EST-AN - EXP003";
    locs_R_3                    = R_extract(ECG_3, 0.6, fs);
    [BPM_3, interval_3]         = BMP_calculation(locs_R_3, Ts);
    fprintf(leg_3+"\r\n")    
    if PLOT_ECGS == 1
        plot_ECG(time_3, ECG_3, locs_R_3, leg_3)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%% R4
    data = load(EXP_folder+'RATON4-30+EST.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);

    stim_ref_4                  = stim_reference;
    ECG_4                       = ECG; 
    leg_4                       = "R4-FAKE - EXP003";
    time_4                      = time;
    locs_R_4                    = R_extract(ECG_4, 0.6, fs);
    [BPM_4, interval_4]         = BMP_calculation(locs_R_4, Ts);
    fprintf(leg_4+"\r\n")    
elseif EXP == 4
    EXP_folder = "EXP004/";
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R1
    data = load(EXP_folder+'RATON1_30AN_30EST_30AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                       = "R1-30AN-30EST-30AN - EXP004";
    th = 0.6;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end
    
    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_1                       = leg;
    time_1                      = time;
    stim_ref_1                  = stim_reference;
    ECG_1                       = ECG;
    locs_P_1                    = locs_P;
    locs_Q_1                    = locs_Q;
    locs_R_1                    = locs_R;
    locs_S_1                    = locs_S;
    locs_T_1                    = locs_T;
    PR_1                        = PR;
    PS_1                        = PS;
    RS_1                        = RS;
    RT_1                        = RT;
    QRS_1                       = QRS;
    QT_1                        = QT;
    ST_1                        = ST;
    RT_voltage_1                = RT_voltage;
    time_intervals_bpm_1        = time_intervals_bpm;
    BPM_1                       = BPM;


    %%%%%%%%%%%%%%%%%%%%%%%%% R2
    data = load(EXP_folder+'RATON2_30AN_30EST_15AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);  
    leg                      = "R2-30AN-30EST-30AN - EXP004";
    th = 0.1;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    
    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_2                       = leg;
    time_2                      = time;
    stim_ref_2                  = stim_reference;
    ECG_2                       = ECG;
    locs_P_2                    = locs_P;
    locs_Q_2                    = locs_Q;
    locs_R_2                    = locs_R;
    locs_S_2                    = locs_S;
    locs_T_2                    = locs_T;
    PR_2                        = PR;
    PS_2                        = PS;
    RS_2                        = RS;
    RT_2                        = RT;
    QRS_2                       = QRS;
    QT_2                        = QT;
    ST_2                        = ST;
    RT_voltage_2                = RT_voltage;
    time_intervals_bpm_2        = time_intervals_bpm;
    BPM_2                       = BPM;


    %%%%%%%%%%%%%%%%%%%%%%%%% R3
    data = load(EXP_folder+'RATON3_EST_40AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                      = "R3-EST-40AN - EXP004";
    th = 0.6;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_3                       = leg;
    time_3                      = time;
    stim_ref_3                  = stim_reference;
    ECG_3                       = ECG;
    locs_P_3                    = locs_P;
    locs_Q_3                    = locs_Q;
    locs_R_3                    = locs_R;
    locs_S_3                    = locs_S;
    locs_T_3                    = locs_T;
    PR_3                        = PR;
    PS_3                        = PS;
    RS_3                        = RS;
    RT_3                        = RT;
    QRS_3                       = QRS;
    QT_3                        = QT;
    ST_3                        = ST;
    RT_voltage_3                = RT_voltage;
    time_intervals_bpm_3        = time_intervals_bpm;
    BPM_3                       = BPM;


    %%%%%%%%%%%%%%%%%%%%%%%%% R4
    data = load(EXP_folder+'RATON4_EST_40AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                      = "R4-EST-40AN - EXP004";
    th = 0.1;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_4                       = leg;
    time_4                      = time;
    stim_ref_4                  = stim_reference;
    ECG_4                       = ECG;
    locs_P_4                    = locs_P;
    locs_Q_4                    = locs_Q;
    locs_R_4                    = locs_R;
    locs_S_4                    = locs_S;
    locs_T_4                    = locs_T;
    PR_4                        = PR;
    PS_4                        = PS;
    RS_4                        = RS;
    RT_4                        = RT;
    QRS_4                       = QRS;
    QT_4                        = QT;
    ST_4                        = ST;
    RT_voltage_4                = RT_voltage;
    time_intervals_bpm_4        = time_intervals_bpm;
    BPM_4                       = BPM;





    %%%%%%%%%%%%%%%%%%%%%%%%% R5
    data = load(EXP_folder+'RATON5_CONTROL_FALSAEST_40AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                       = "R5-FAKE - EXP004";
    th = 0.4;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_5                       = leg;
    time_5                      = time;
    stim_ref_5                  = stim_reference;
    ECG_5                       = ECG;
    locs_P_5                    = locs_P;
    locs_Q_5                    = locs_Q;
    locs_R_5                    = locs_R;
    locs_S_5                    = locs_S;
    locs_T_5                    = locs_T;
    PR_5                        = PR;
    PS_5                        = PS;
    RS_5                        = RS;
    RT_5                        = RT;
    QRS_5                       = QRS;
    QT_5                        = QT;
    ST_5                        = ST;
    RT_voltage_5                = RT_voltage;
    time_intervals_bpm_5        = time_intervals_bpm;
    BPM_5                       = BPM;



    %%%%%%%%%%%%%%%%%%%%%%%%% R6
    data = load(EXP_folder+'RATON6_CONTROL_FALSAEST_40MINAN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                     = "R6-FAKE - EXP004";
    th = 0.1;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_6                       = leg;
    time_6                      = time;
    stim_ref_6                  = stim_reference;
    ECG_6                       = ECG;
    locs_P_6                    = locs_P;
    locs_Q_6                    = locs_Q;
    locs_R_6                    = locs_R;
    locs_S_6                    = locs_S;
    locs_T_6                    = locs_T;
    PR_6                        = PR;
    PS_6                        = PS;
    RS_6                        = RS;
    RT_6                        = RT;
    QRS_6                       = QRS;
    QT_6                        = QT;
    ST_6                        = ST;
    RT_voltage_6                = RT_voltage;
    time_intervals_bpm_6        = time_intervals_bpm;
    BPM_6                       = BPM;

elseif EXP == 5
    EXP_folder = "EXP005/";
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R1
    data = load(EXP_folder+'raton1_est_40minAN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                       = "RATON1_est_40minAN - EXP005";
    th = 0.6;
    % if (use_filter == 1)
    %     ECG = filter_ECG(ECG, fs);
    % end
    
    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_1                       = leg;
    time_1                      = time;
    stim_ref_1                  = stim_reference;
    ECG_1                       = ECG;
    locs_P_1                    = locs_P;
    locs_Q_1                    = locs_Q;
    locs_R_1                    = locs_R;
    locs_S_1                    = locs_S;
    locs_T_1                    = locs_T;
    PR_1                        = PR;
    PS_1                        = PS;
    RS_1                        = RS;
    RT_1                        = RT;
    QRS_1                       = QRS;
    QT_1                        = QT;
    ST_1                        = ST;
    RT_voltage_1                = RT_voltage;
    time_intervals_bpm_1        = time_intervals_bpm;
    BPM_1                       = BPM;


    %%%%%%%%%%%%%%%%%%%%%%%%% R2
    data = load(EXP_folder+'raton2_30minAN_est.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);  
    leg                      = "RATON2_30minAN_est - EXP005";
    th = 0.1;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    
    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_2                       = leg;
    time_2                      = time;
    stim_ref_2                  = stim_reference;
    ECG_2                       = ECG;
    locs_P_2                    = locs_P;
    locs_Q_2                    = locs_Q;
    locs_R_2                    = locs_R;
    locs_S_2                    = locs_S;
    locs_T_2                    = locs_T;
    PR_2                        = PR;
    PS_2                        = PS;
    RS_2                        = RS;
    RT_2                        = RT;
    QRS_2                       = QRS;
    QT_2                        = QT;
    ST_2                        = ST;
    RT_voltage_2                = RT_voltage;
    time_intervals_bpm_2        = time_intervals_bpm;
    BPM_2                       = BPM;


    %%%%%%%%%%%%%%%%%%%%%%%%% R3
    data = load(EXP_folder+'raton3_falsa_est_40minAN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                      = "RATON3_falsa_est_40minAN - EXP005";
    th = 0.6;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_3                       = leg;
    time_3                      = time;
    stim_ref_3                  = stim_reference;
    ECG_3                       = ECG;
    locs_P_3                    = locs_P;
    locs_Q_3                    = locs_Q;
    locs_R_3                    = locs_R;
    locs_S_3                    = locs_S;
    locs_T_3                    = locs_T;
    PR_3                        = PR;
    PS_3                        = PS;
    RS_3                        = RS;
    RT_3                        = RT;
    QRS_3                       = QRS;
    QT_3                        = QT;
    ST_3                        = ST;
    RT_voltage_3                = RT_voltage;
    time_intervals_bpm_3        = time_intervals_bpm;
    BPM_3                       = BPM;


    %%%%%%%%%%%%%%%%%%%%%%%%% R4
    data = load(EXP_folder+'RATON4_EST_40AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                      = "R4-EST-40AN - EXP004";
    th = 0.1;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_4                       = leg;
    time_4                      = time;
    stim_ref_4                  = stim_reference;
    ECG_4                       = ECG;
    locs_P_4                    = locs_P;
    locs_Q_4                    = locs_Q;
    locs_R_4                    = locs_R;
    locs_S_4                    = locs_S;
    locs_T_4                    = locs_T;
    PR_4                        = PR;
    PS_4                        = PS;
    RS_4                        = RS;
    RT_4                        = RT;
    QRS_4                       = QRS;
    QT_4                        = QT;
    ST_4                        = ST;
    RT_voltage_4                = RT_voltage;
    time_intervals_bpm_4        = time_intervals_bpm;
    BPM_4                       = BPM;





    %%%%%%%%%%%%%%%%%%%%%%%%% R5
    data = load(EXP_folder+'RATON5_CONTROL_FALSAEST_40AN.mat');
    [ECG, stim_reference, ~, fs, time] = extract_data(data);
    leg                       = "R5-FAKE - EXP004";
    th = 0.4;

    if (use_filter == 1)
        ECG = filter_ECG(ECG, fs);
    end

    [locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
    [time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 50, fs, ECG, locs_R);
    functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
    
    leg_5                       = leg;
    time_5                      = time;
    stim_ref_5                  = stim_reference;
    ECG_5                       = ECG;
    locs_P_5                    = locs_P;
    locs_Q_5                    = locs_Q;
    locs_R_5                    = locs_R;
    locs_S_5                    = locs_S;
    locs_T_5                    = locs_T;
    PR_5                        = PR;
    PS_5                        = PS;
    RS_5                        = RS;
    RT_5                        = RT;
    QRS_5                       = QRS;
    QT_5                        = QT;
    ST_5                        = ST;
    RT_voltage_5                = RT_voltage;
    time_intervals_bpm_5        = time_intervals_bpm;
    BPM_5                       = BPM;





end

%% 
if (EXP == 2)||(EXP == 3)||(EXP == 3.2)||(EXP == 4)
%%%%%%%%%%%%%%%%%%%%%%%%% R1
plot_ECG_BPM_STIM(time_1, ECG_1, stim_ref_1, time_intervals_bpm_1, BPM_1, leg_1, locs_R_1)
fprintf("plot" + leg_1 + "\r\n")    
%%%%%%%%%%%%%%%%%%%%%%%%% R2
plot_ECG_BPM_STIM(time_2, ECG_2, stim_ref_2, time_intervals_bpm_2, BPM_2, leg_2, locs_R_2)
fprintf("plot" + leg_2 + "\r\n")    
    if (EXP == 3)||(EXP == 3.2)||(EXP == 4)
        %%%%%%%%%%%%%%%%%%%%%%%%% R3
        plot_ECG_BPM_STIM(time_3, ECG_3, stim_ref_3, time_intervals_bpm_3, BPM_3, leg_3, locs_R_3)
        fprintf("plot" + leg_3 + "\r\n")    
        
        %%%%%%%%%%%%%%%%%%%%%%%%% R4
        plot_ECG_BPM_STIM(time_4, ECG_4, stim_ref_4, time_intervals_bpm_4, BPM_4, leg_4, locs_R_4)
        fprintf("plot" + leg_4 + "\r\n")    
        if (EXP == 3)||(EXP == 4)
            %%%%%%%%%%%%%%%%%%%%%%%%% R5
            plot_ECG_BPM_STIM(time_5, ECG_5, stim_ref_5, time_intervals_bpm_5, BPM_5, leg_5, locs_R_5)
            fprintf("plot" + leg_5 + "\r\n")    
            if (EXP == 4)
                %%%%%%%%%%%%%%%%%%%%%%%%% R6
                plot_ECG_BPM_STIM(time_6, ECG_6, stim_ref_6, time_intervals_bpm_6, BPM_6, leg_6, locs_R_6)
                fprintf("plot" + leg_6 + "\r\n") 
            end
        end 
    end
end
%%
time = {time_1; time_2; time_3; time_4};
ECG = {ECG_1; ECG_2; ECG_3; ECG_4};
stim_ref = {stim_ref_1; stim_ref_2; stim_ref_3; stim_ref_4};
interval = {interval_1; interval_2; interval_3; interval_4};
BPM = {BPM_1; BPM_2; BPM_3; BPM_4};
leg = {leg_1; leg_2; leg_3; leg_4};
locs_R = {locs_R_1; locs_R_2; locs_R_3; locs_R_4};

plot_together(time, ECG, stim_ref, interval, BPM, leg, locs_R)


%% Function for plotting ECG + stimulation + BMP
function plot_ECG_BPM_STIM(time, ECG, stim_ref, interval, BPM, legend_id, locs_R)
    figure;
    % Color de fondo (hex -> RGB normalizado)
    fondoRGB = [38, 38, 38]/255;
    lineaRGB = [121, 202, 39]/255;

    
    % Primer eje Y (ECG_1)
    yyaxis left;
    plot(time, ECG);
    ylabel('ECG');
    ylim([-3, 3]);
    hold on
    plot(time, stim_ref, 'Color', 'w');
    plot(time(locs_R), ECG(locs_R), 'r*')
    
    % Segundo eje Y (BPM)
    yyaxis right;
    plot(interval(2:end), BPM, '-o', 'Color', lineaRGB,"LineWidth",2); 
    ylabel('BPM','Color', lineaRGB);
    ylim([90, 550])
    xlabel('Tiempo', 'Color', 'w');
    title(legend_id, 'Color', 'w');
    grid on;
    ax = gca;
    ax.YColor = lineaRGB;                         % Color del eje derecho
    ylabel('BPM', 'Color', lineaRGB);            % Color de la etiqueta del eje derecho

    
    % Estética de la figura
    ax = gca; % Obtener el objeto de ejes
    % Cambiar colores de fondo
    set(gcf, 'Color', fondoRGB);    % Fondo de la figura
    set(ax, 'Color', fondoRGB);     % Fondo del área del gráfico
    % Fuente en blanco
    ax.FontSize = 22;
    ax.FontWeight = 'bold';
    ax.FontName = 'Roboto Light';
end 

%% Function for plotting ECG + stimulation + BMP for all rodents in the experiment
function plot_together(time, ECG, stim_ref, interval, BPM, legend_id, locs_R)
    figure;
    hold on;
    colours = {'r', 'b', 'g', 'k', 'y', 'm'};
    for i = 1:4

        plot(interval{i}(2:end), BPM{i}, colours{i}, "LineWidth",2, 'DisplayName', legend_id{i}); % Gráfica en rojo
        ylabel('BPM');
        ylim([90, 550])
        xlabel('Tiempo (s)');
        
        grid on;
    end
    legend(legend_id, 'Location', 'best');    
    hold off

    
    figure;
    hold on;
    colours = {'r', 'b', 'g', 'k', 'y', 'm'};
    for i = 1:4

        plot(time{i}, stim_ref{i}, colours{i}, "LineWidth",2, 'DisplayName', legend_id{i}); % Gráfica en rojo
        ylabel('BPM');
        xlabel('Tiempo (s)');
        
        grid on;
    end
    legend(legend_id, 'Location', 'best');    
    hold off
end 
