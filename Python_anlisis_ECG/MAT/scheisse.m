clc
clear
close all
use_filter = 1;

EXP_folder = "EXP004/";
fs_interp = 4; % Hz, frecuencia de interpolación

%%%%%%%%%%%%%%%%%%%%%%%%% R1
data = load(EXP_folder+'RATON1_30AN_30EST_30AN.mat');
[ECG, stim_reference, d3, fs, time] = extract_data(data);

if (use_filter == 1)
    ECG = filter_ECG(ECG, fs);
end


leg                         = "R1-30AN-30EST-30AN - EXP004";
th                          = 0.1;

[locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, leg);
[time_intervals_bpm, BPM] = BPM_calculation_overlap(60, 30, fs, ECG, locs_R);
functions_plotting(time, ECG, stim_reference, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_T_init, locs_T_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, leg)

leg_1                       = leg;
time_1                      = time;
stim_ref_1                  = stim_reference;
ECG_1                       = ECG;
P_locs_1                    = locs_P;
Q_locs_1                    = locs_Q;
R_locs_1                    = locs_R;
S_locs_1                    = locs_S;
T_locs_1                    = locs_T;
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

%% analisis de HRV en ventanas espaciadas en el tiempo
t_interp = linspace(0, sum(RR), length(RR));
tq = 0:1/fs_interp:t_interp(end);
RR_interp = interp1(t_interp, RR, tq, 'spline');

% Asumiendo RR y fs_interp definidos
window_duration = 60; % segundos
n_windows = floor(tq(end) / window_duration);
HF_power_series = zeros(1, n_windows);
LF_power_series = zeros(1, n_windows);
LF_HF_ratio_series = zeros(1, n_windows);

for i = 1:n_windows
    idx_start = round((i-1)*window_duration*fs_interp) + 1;
    idx_end   = round(i*window_duration*fs_interp);
    
    if idx_end > length(RR_interp)
        break
    end
    
    segment = RR_interp(idx_start:idx_end);
    
    [pxx, f] = pwelch(segment, [], [], [], fs_interp);
    pxx_multiple(i, :) = pxx;
    LF = bandpower(pxx, f, [0.15 1.5], 'psd');
    HF = bandpower(pxx, f, [2 10], 'psd');
    
    HF_power_series(i) = HF;
    LF_power_series(i) = LF;
    LF_HF_ratio_series(i) = LF / HF;
end
%% visualización de cuándo ocurre la estimulación
time_axis = (1:n_windows) * window_duration / 60; % en minutos

figure;
subplot(4,1,1);
plot(time_axis, HF_power_series, '-o');
xlabel('Tiempo (min)'); ylabel('Potencia HF');
title('Actividad vagal (HF) por ventana de 1 minuto');
grid on;

subplot(4,1,2);
plot(time_axis, LF_power_series, '-o');
xlabel('Tiempo (min)'); ylabel('Potencia LF');
title('Actividad de baja frecuencia (LF) por ventana de 1 minuto');
grid on;

subplot(4, 1, 3)
plot(time_axis, LF_HF_ratio_series, '-o');
xlabel('Tiempo (min)'); ylabel('Relación LF/HF');
title('Relación Simpático/Parasimpático');
grid on;

subplot(4, 1, 4)
plot(time/60, stim_reference, '-');
xlabel('Tiempo (min)'); ylabel('Relación LF/HF');
title('Relación Simpático/Parasimpático');
grid on;


%%
clc
close all
functions_ECG_spectral_analysis(RR, fs_interp, ECG, fs)
