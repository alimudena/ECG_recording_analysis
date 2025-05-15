clc
clear
close all


fs = 10000;
Ts = 1/fs;
use_filter = 0;
PLOT_ECGS = 0;
SUBPLOTTED = 0;
segment_duration = 60; %seconds
delta_time = 50; %seconds


EXP_folder = "EXP005/";
%% 
%%%%%%%%%%%%%%%%%%%%%%%%% R0
data = load(EXP_folder+'raton0_control_anestesia.mat');
[ECG, stim_reference, ~, fs, time] = extract_data(data);
leg                      = "RATON0 control anestesia - EXP005";
th = 0.2;

if (use_filter == 1)
    ECG = filter_ECG(ECG, fs);
end

[locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, R_intervals] = functions_ECG_PQRST(ECG, th, fs, leg, segment_duration, delta_time);
functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)

leg_0                       = leg;
time_0                      = time;
stim_ref_0                  = stim_reference;
ECG_0                       = ECG;
locs_P_0                    = locs_P;
locs_Q_0                    = locs_Q;
locs_R_0                    = locs_R;
locs_S_0                    = locs_S;
locs_T_0                    = locs_T;
PR_0                        = PR;
PS_0                        = PS;
RS_0                        = RS;
RT_0                        = RT;
QRS_0                       = QRS;
QT_0                        = QT;
ST_0                        = ST;
RT_voltage_0                = RT_voltage;
time_intervals_bpm_0        = time_intervals_bpm;
BPM_0                       = BPM;


%% 
%%%%%%%%%%%%%%%%%%%%%%%%% R1
data = load(EXP_folder+'raton1_est_40minAN.mat');
[ECG, stim_reference, ~, fs, time] = extract_data(data);
leg                       = "RATON1 est 40minAN - EXP005";
th = 0.6;

if (use_filter == 1)
    ECG = filter_ECG(ECG, fs);
end

[locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, R_intervals] = functions_ECG_PQRST(ECG, th, fs, leg, segment_duration, delta_time);
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

%%


%%%%%%%%%%%%%%%%%%%%%%%%% R2
data = load(EXP_folder+'raton2_30minAN_est.mat');
[ECG, stim_reference, ~, fs, time] = extract_data(data);  
leg                      = "RATON2 30minAN est - EXP005";
th = 0.1;

if (use_filter == 1)
ECG = filter_ECG(ECG, fs);
end


[locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, R_intervals] = functions_ECG_PQRST(ECG, th, fs, leg, segment_duration, delta_time);

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


%%
%%%%%%%%%%%%%%%%%%%%%%%%% R3
data = load(EXP_folder+'raton3_falsa_est_40minAN.mat');
[ECG, stim_reference, ~, fs, time] = extract_data(data);
leg                      = "RATON3 falsa est 40minAN - EXP005";
th = 0.6;

if (use_filter == 1)
    ECG = filter_ECG(ECG, fs);
end

[locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, R_intervals] = functions_ECG_PQRST(ECG, th, fs, leg, segment_duration, delta_time);

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

%%
%%%%%%%%%%%%%%%%%%%%%%%%% R4
data = load(EXP_folder+'raton4_30minAN_falsa_est.mat');
[ECG, stim_reference, ~, fs, time] = extract_data(data);
leg                      = "RATON4 falsa 30min est - EXP005";
th = 0.2;

if (use_filter == 1)
    ECG = filter_ECG(ECG, fs);
end

[locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, R_intervals] = functions_ECG_PQRST(ECG, th, fs, leg, segment_duration, delta_time);

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

%%
close all
plot(ECG_0)
hold on

figure
