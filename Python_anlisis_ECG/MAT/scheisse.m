clc
clear
close all


EXP_folder = "EXP004/";

%%%%%%%%%%%%%%%%%%%%%%%%% R1
data = load(EXP_folder+'RATON1_30AN_30EST_30AN.mat');
[ECG, stim_reference, d3, fs, time] = extract_data(data);



leg                         = "R1-30AN-30EST-30AN - EXP004";
th                          = 0.6;

[P_locs, Q_locs, R_locs, S_locs, T_locs, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
[time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 30, fs, ECG, R_locs);

leg_1                       = leg;
time_1                      = time;
stim_ref_1                  = stim_reference;
ECG_1                       = ECG;
P_locs_1                    = P_locs;
Q_locs_1                    = Q_locs;
R_locs_1                    = R_locs;
S_locs_1                    = S_locs;
T_locs_1                    = T_locs;
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

functions_plotting(time, ECG, stim_reference, P_locs, Q_locs, R_locs, S_locs, T_locs, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)
