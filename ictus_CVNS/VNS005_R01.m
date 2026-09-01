Experiments(rodent).ID= "VNS005_R1";

% Experiment number 1 in rodent R01 for VNS011
    %%------ Flor fill in ------%%
    Experiment_number = 1;
    day_of_experiment = '30-03-2025';
    folder = "../../raw_data/CTB/matlab_archivos/VNS005";
    file = "R001";

    Experimental_type = "Auricular";

    stim_time =  "30 seconds";
    rest_time =  "5 minutes";
    freq_stim =  "20 Hz";
    current_stim =  "500 mA";
    stim_polarity = "Bipolar";
    n_stims = 4;
    notation = "raton1_est_40minANVNS005";


    %%------ Alimu fill in ------%%
    f_max = 500;
    f_low_pass = 250;
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 5; 
    th_ECG_inf = 80;
    th_ECG_sup = 500;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0.01; %*fs
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
