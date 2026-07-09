Experiments(rodent).ID= "VNS009_R5";

% Experiment number 1 in rodent R01 for VNS011
    %%------ Flor fill in ------%%
    Experiment_number = 1;
    day_of_experiment = '30-03-2025';
    folder = "../../raw_data/CTB/matlab_archivos/VNS009";
    file = "R005";

    Experimental_type = "Auricular";

    stim_time =  "30 seconds";
    rest_time =  "5 minutes";
    freq_stim =  "20 Hz";
    current_stim =  "500 mA";
    stim_polarity = "Bipolar";
    n_stims = 4;
    notation = "in case any anotation wants to be done";


    %%------ Alimu fill in ------%%
    f_max = 500;
    f_low_pass = 250;
    Q = 50;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 30;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 1; %*fs
    f_max_plot = 5000;
    f_max_plot_small = 100;
    studied_intervals = 30; %Seconds
    %for extracting the timing parameters during smaller periods of time 
    small_time = 5; % Seconds * fs --> 


    %Stimulation times on off extraction
    low_cut = 17;
    high_cut = 23;
    window_smooth = 0.0005;
    n = 600;   % orden optimizado para velocidad
    max_gap_sec = 1;                     % <-- AJÚSTALO (te recomiendo 2s)
    min_dur_sec = 5;                   % mínimo: 20s
    PPM_window_sec = 5;

    
    experiment_fill_in;

%%
plot_with_peaks_VNS(Experiments, rodent, 1);
plot_ECG_and_HRV(Experiments, rodent, 1);
plot_stim_ON_OFF(Experiments, rodent, 1);

%%
RMSSD_1 = Experiments(rodent).experiment_number(1).marquers.before_RMSSD;
