
% Supongamos que tienes varios arrays columna
clc
% Crear tabla con nombres personalizados
% datos = table(ECG, t', A, A_T, RR, t_R', ppm_rr, t_ppm', stim_clean, 'VariableNames', {'ECG', 'Time', 'R Peaks', 'R Peaks times', 'BPM-RR', 'BPM-RR times', 'Binary stimulation values'});

% Guardar a CSV
% writetable(datos, "experiment_data_extracted/"+ experiment_folder +"/"+file+'.csv');


writematrix([t' ECG], "experiment_data_extracted/"+ experiment_folder +"/"+file+"_ECG.csv");
writematrix([A_T A], "experiment_data_extracted/"+ experiment_folder +"/"+file+"_R_Peaks.csv");
writematrix([t_ppm ppm_rr], "experiment_data_extracted/"+ experiment_folder +"/"+file+"_BPM.csv");
writematrix(stim_clean, "experiment_data_extracted/"+ experiment_folder +"/"+file+"_stim_clean.csv");
writematrix([f0, Q, highpass_filter_order, th_ECG_inf, peak_distance, max_gap_sec, min_dur_sec, threshold], "experiment_data_extracted/"+ experiment_folder +"/"+file+"_analysis_data.csv");

