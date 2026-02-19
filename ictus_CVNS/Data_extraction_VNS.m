clc
clear
close all

Experimental_days = datetime(['03-03-2025'; '10-03-2025'; '18-03-2025'; '29-04-2025'; '12-05-2025'; '03-06-2025'; '28-10-2025'; '06-11-2025'; '18-11-2025'; '01-11-2025'], 'InputFormat', 'dd-MM-yyyy');
Experimental_VNS_id = (["VNS-002"; "VNS-003"; "VNS-004"; "VNS-005"; "VNS-006"; "VNS-007"; "VNS-008"; "VNS-009"; "VNS-010"; "VNS-011"]);

Experimental_types =  ["Aricular", "Cervical", "Control"];

Experimental_polarity = ["Unipolar", "Bipolar"];

Experiments = struct();
rodent = 1;
R1;
%%
plot_with_peaks_VNS(Experiments, rodent, 1);
plot_ECG_and_HRV(Experiments, rodent, 1);

plot_with_peaks_VNS(Experiments, rodent, 2);
plot_ECG_and_HRV(Experiments, rodent, 2);

%%
rodent = 2;
R2;