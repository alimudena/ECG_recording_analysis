clc
clear
close all

Experimental_days = datetime(['03-03-2025'; '10-03-2025'; '18-03-2025'], 'InputFormat', 'dd-MM-yyyy');
Experimental_VNS_id = (["VNS-010"; "VNS-011"]);

Experimental_types =  ["Aricular", "Cervical", "Control"];

Experimental_polarity = ["Unipolar", "Bipolar"];

Experiments = struct();

rodent = 1;
R1;


% %%
% save('Experiments.mat', 'Experiments');
% clc
% clear
% load("Experiments.mat");

%%
rodent = 1;
plot_with_peaks_VNS(Experiments, rodent, 1);
%%
plot_ECG_and_HRV(Experiments, rodent, 1);
%%
plot_stim_ON_OFF(Experiments, rodent, 1);
%%
experiment_number = 2;
% Todas las estimulaciones del experimento
plot_ppm_Ns(Experiments, rodent, experiment_number);
%%
% Solo la estimulación 2
plot_ppm_Ns(Experiments, rodent, experiment_number, 2);


%%
% Plot de los parametros de HRV cada 5 segundos
plot_hrv_small_time_sequence(Experiments, 1, 1);
%%
plot_hrv_small_time_sequence(Experiments, 1, 2);




%%
rodent = 2;
R2;


plot_with_peaks_VNS(Experiments, rodent, 2);
plot_ECG_and_HRV(Experiments, rodent, 2);
plot_stim_ON_OFF(Experiments, rodent, 2);


%%
% close all
bar_graph_plot_all_experiments


%% Calculate P values for all experiments
[HRV_parameters, TablaComparativa] = HRV_pvalues_extraction(Experiments);

disp(TablaComparativa);

