clc
clear
close all
Experiments = struct();
rodent = 1;

Experiments(rodent).ID= "R1";


% Experiment number 2 in rodent R1
    %%------ Flor fill in ------%%
    Experiment_number = 2;
    day_of_experiment = '30-03-2025';
    folder = "C:/Users/Alimu/Documents/BIOS/STRIKE/raw_data/CTB/matlab_archivos/VNS002";
    file = "RATON2-EST-ANVNS002";

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
    studied_intervals = 30; %Seconds


    %Stimulation times on off extraction
    low_cut = 17;
    high_cut = 23;
    window_smooth = 0.0005;
    n = 600;   % orden optimizado para velocidad
    max_gap_sec = 1;                     % <-- AJÚSTALO (te recomiendo 2s)
    min_dur_sec = 5;                   % mínimo: 20s

    
    experiment_fill_in;
   
%%
plot_with_peaks_VNS(Experiments, rodent, 2);
plot_ECG_and_HRV(Experiments, rodent, 2);
plot_stim_ON_OFF(Experiments, rodent, 2);

%%
RMSSD_1 = Experiments(rodent).experiment_number(1).marquers.before_RMSSD
RMSSD_2 = Experiments(rodent).experiment_number(2).marquers.before_RMSSD