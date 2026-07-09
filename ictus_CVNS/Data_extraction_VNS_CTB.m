clc
clear
close all

Experimental_days = datetime(['03-03-2025'; '10-03-2025'; '18-03-2025'], 'InputFormat', 'dd-MM-yyyy');
Experimental_VNS_id = (["VNS-010"; "VNS-011"]);

Experimental_types =  ["Aricular", "Cervical", "Control"];

Experimental_polarity = ["Unipolar", "Bipolar"];

Experiments = struct();

%%
clc
clear
close all
rodent = 4;
VNS009_R04;

%%
clc
clear
close all
rodent = 4;
VNS005_R04;



%% VNS005
rodent = 1;
VNS005_R01;
%%
rodent = 2;
VNS005_R02;

rodent = 3;
VNS005_R03;

% rodent = 4;
% VNS005_R04;

%% VNS008
rodent = 1;
VNS008_R02_I;

rodent = 2;
VNS008_R03_I;

rodent = 3;
VNS008_R03_D;

rodent = 4;
VNS008_R04_I;

%% VNS009
rodent = 1;
VNS009_R01;

rodent = 2;
VNS009_R02;


rodent = 3;
VNS009_R03;

rodent = 4;
VNS009_R04;

rodent = 5;
VNS009_R05;

%% VNS010
rodent = 1;
VNS010_R01A;

rodent = 2;
VNS010_R01B;

rodent = 3;
VNS010_R02A;

rodent = 4;
VNS010_R02B;

rodent = 5;
VNS010_R03;

rodent = 6;
VNS010_R04;

rodent = 7;
VNS010_R05;
%% VNS011
rodent = 1;
VNS011_R01;

rodent = 2;
VNS011_R02;

rodent = 3;
VNS011_R03;

rodent = 4;
VNS011_R04;

%%
save('Experiments_VNS011.mat', 'Experiments');
clc
clear
load("Experiments.mat");

%%
rodent = 3;
experiment_number = 1;
%%
plot_with_peaks_VNS(Experiments, rodent, experiment_number);
%%
plot_ECG_and_HRV(Experiments, rodent, experiment_number);
%%
plot_stim_ON_OFF(Experiments, rodent, experiment_number);
%%

% Todas las estimulaciones del experimento
plot_ppm_Ns(Experiments, rodent, experiment_number);
%%
% Solo la estimulación 2
plot_ppm_Ns(Experiments, rodent, experiment_number, 2);


%%
% Plot de los parametros de HRV cada 5 segundos
clc
plot_hrv_small_time_sequence(Experiments, rodent, 1);
%%
plot_hrv_small_time_sequence(Experiments, 1, 2);






%%
% close all
bar_graph_plot_all_experiments

writetable(Resultados,'Resultados_HRV.xlsx');

%% Calculate P values for all experiments
[HRV_parameters, TablaComparativa] = HRV_pvalues_extraction(Experiments);

disp(TablaComparativa);

