clc
clear
close all

Experimental_days = datetime(['17-06-2026'; '18-06-2026'; '18-03-2025'], 'InputFormat', 'dd-MM-yyyy');
Experimental_VNS_id = (["VNS-010"; "VNS-011"]);

Experimental_types =  ["Aricular", "Cervical", "Control"];

Experimental_polarity = ["Unipolar", "Bipolar"];

Experiments = struct();


%% PRUEBAS 
clc
clear
%Repetir R14 - 3
rodent = 16;
PCM_aVNS_R16;
%%
% rodent = 12;
close all
experiment_number = 3;
plot_ECG_and_HRV(Experiments, rodent, experiment_number);

plot_with_peaks_VNS(Experiments, rodent, experiment_number);
plot_ECG_and_HRV_and_stim(Experiments, rodent, experiment_number);
plot_ECG_and_PPM_and_stim(Experiments, rodent, experiment_number);
plot_with_peaks_discarded(Experiments, rodent, experiment_number);
plot_stim_ON_OFF(Experiments, rodent, experiment_number);



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


rodent = 10;
PCM_aVNS_R10;
% save('STROKE_R10.mat', 'Experiments');

rodent = 11;
PCM_aVNS_R11;
% save('STROKE_R11.mat', 'Experiments');

rodent = 12;
PCM_aVNS_R12;
% save('STROKE_R12.mat', 'Experiments');

rodent = 14;
PCM_aVNS_R14;
%% control
rodent = 2;
PCM_aVNS_R02;
% save('STROKE_R02.mat', 'Experiments');

rodent = 3;
PCM_aVNS_R03;
% save('STROKE_R03.mat', 'Experiments');

rodent = 7;
PCM_aVNS_R07;
% save('STROKE_R07.mat', 'Experiments');

rodent = 13;
PCM_aVNS_R13;
% save('STROKE_R13.mat', 'Experiments');

rodent = 15;
PCM_aVNS_R15;
% save('STROKE_R15.mat', 'Experiments');
%%
Name_experiment = 'PCM_before_during_after_statistics_HRV.xlsx';
parameters_excel_creation;

%Mostrar tabla
disp(T)
writetable(T, Name_experiment);


%%GRAFICOS BARRAS
% close all
bar_graph_plot_all_experiments

Name_experiment = 'PCM_SX_PX_grouped_mean_std_only_stimulations.xlsx';

% Mostrar tabla
disp(Resultados)
writetable(Resultados, Name_experiment);





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

