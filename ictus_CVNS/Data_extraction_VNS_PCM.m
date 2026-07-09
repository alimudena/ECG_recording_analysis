clc
clear
close all

Experimental_days = datetime(['17-06-2026'; '18-06-2026'; '18-03-2025'], 'InputFormat', 'dd-MM-yyyy');
Experimental_VNS_id = (["VNS-010"; "VNS-011"]);

Experimental_types =  ["Aricular", "Cervical", "Control"];

Experimental_polarity = ["Unipolar", "Bipolar"];

Experiments = struct();

%% estimulados
% clc
% clear
% close all
rodent = 1;
PCM_aVNS_R01;
% save('STROKE_R01.mat', 'Experiments');

rodent = 4;
PCM_aVNS_R04;
% save('STROKE_R04.mat', 'Experiments');

%%control
rodent = 2;
PCM_aVNS_R02;
% save('STROKE_R02.mat', 'Experiments');

rodent = 3;
PCM_aVNS_R03;
% save('STROKE_R03.mat', 'Experiments');

Name_experiment = 'PCM_before_during_after_statistics_HRV.xlsx';
parameters_excel_creation;

%Mostrar tabla
disp(T)
writetable(T, Name_experiment);


%%GRAFICOS BARRAS
% close all
bar_graph_plot_all_experiments

Name_experiment = 'PCM_SX_PX_grouped_mean_std.xlsx';

% Mostrar tabla
disp(Resultados)
writetable(Resultados, Name_experiment);

%%
rodent = 1;
experiment_number = 1;
plot_ECG_and_HRV(Experiments, rodent, experiment_number);
plot_with_peaks_VNS(Experiments, rodent, experiment_number);
plot_ECG_and_HRV_and_stim(Experiments, rodent, experiment_number);
plot_ECG_and_PPM_and_stim(Experiments, rodent, experiment_number);
plot_with_peaks_discarded(Experiments, rodent, experiment_number);
plot_stim_ON_OFF(Experiments, rodent, experiment_number);








%%

% Todas las estimulaciones del experimento
plot_ppm_Ns(Experiments, rodent, 1);






%%
% Solo la estimulación 2
plot_ppm_Ns(Experiments, rodent, experiment_number, 2);

%%
% Plot de los parametros de HRV cada 5 segundos
plot_hrv_small_time_sequence(Experiments, 1, 1);


%% Calculate P values for all experiments
[HRV_parameters, TablaComparativa] = HRV_pvalues_extraction(Experiments);

disp(TablaComparativa);

