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
%%
plot_with_peaks_VNS(Experiments, rodent, 1);
plot_ECG_and_HRV(Experiments, rodent, 1);
plot_stim_ON_OFF(Experiments, rodent, 1);


%%
rodent = 2;
R2;


plot_with_peaks_VNS(Experiments, rodent, 2);
plot_ECG_and_HRV(Experiments, rodent, 2);
plot_stim_ON_OFF(Experiments, rodent, 2);


%%
SDNN_RMSSD_plot_all_experiments