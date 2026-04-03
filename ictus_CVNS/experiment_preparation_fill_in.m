clc
clear
close all
Experiments = struct();
rodent = 1;

Experiments(rodent).ID= "R1";


% Experiment number 1 in rodent R1
    %%------ Flor fill in ------%%
    Experiment_number = 1;
    day_of_experiment = '30-03-2025';
    folder = "../ECG_recording_analysis_2/experiments/VNS-010";
    file = "R001_ES01";

    Experimental_type = "Auricular";

    stim_time =  "30 seconds";
    rest_time =  "5 minutes";
    freq_stim =  "20 Hz";
    current_stim =  "500 mA";
    stim_polarity = "Bipolar";
    n_stims = 4;


    %%------ Alimu fill in ------%%
    f_max = 500;
    f_low_pass = 250;
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 12;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0.1; %*fs
    f_max_plot = 5000;
    f_max_plot_small = 100;


    %Stimulation times on off extraction
    low_cut = 17;
    high_cut = 23;
    window_smooth = 0.0005;
    n = 600;   % orden optimizado para velocidad


    experiment_fill_in;

plot_with_peaks_VNS(Experiments, rodent, 1);
plot_ECG_and_HRV(Experiments, rodent, 1);

%%
plot_stim_ON_OFF(Experiments, rodent, 1);

