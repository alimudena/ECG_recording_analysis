Experiments(rodent).ID= "aVNS_PCM_R12";

% Experiment number 1 in rodent R012
    %%------ Flor fill in ------%%
    Experiment_number = 1;
    day_of_experiment = '13-07-2026'; %Day-month-year
    folder = "../../raw_data/PCM/matlab_archivos/aVNS_stroke_2";
    file = "R013_01";

    Experimental_type = "control";

    stim_time =  "30 seconds";
    rest_time =  "5 minutes";
    freq_stim =  "20 Hz";
    current_stim =  "500 mA";
    stim_polarity = "Bipolar";
    n_stims = 4;
    notation = " "


    %%------ Alimu fill in ------%%
    f_max = 500;
    f_low_pass = 250;
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 8;
    th_ECG_sup = 300;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0.1; %*fs
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
    min_dur_sec = 10;                   % mínimo: 20s
    PPM_window_sec = 5;


    experiment_fill_in;

% Experiment number 2 in rodent R012
    %%------ Flor fill in ------%%
    Experiment_number = 2;
    day_of_experiment = '14-07-2026'; %Day-month-year
    file = "R012_02";

    Experimental_type = "aVNS";

    stim_time =  "30 seconds";
    rest_time =  "5 minutes";
    freq_stim =  "20 Hz";
    current_stim =  "500 mA";
    stim_polarity = "Bipolar";
    n_stims = 5;
    notation = "in case any anotation wants to be done";



    %%------ Alimu fill in ------%%
    f_max = 500;
    f_low_pass = 250;
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 5;
    th_ECG_sup = 180;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0.1; %*fs
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
    min_dur_sec = 10;                   % mínimo: 20s
    PPM_window_sec = 10;


    experiment_fill_in;

% Experiment number 3 in rodent R012
    %%------ Flor fill in ------%%
    Experiment_number = 3;
    day_of_experiment = '15-07-2026'; %Day-month-year
    file = "R012_03";

    Experimental_type = "aVNS";

    stim_time =  "30 seconds";
    rest_time =  "5 minutes";
    freq_stim =  "20 Hz";
    current_stim =  "500 mA";
    stim_polarity = "Bipolar";
    n_stims = 5;
    notation = "in case any anotation wants to be done";


    %%------ Alimu fill in ------%%
    f_max = 500;
    f_low_pass = 250;
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 10;
    th_ECG_sup = 250;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0.1; %*fs
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
    min_dur_sec = 10;                   % mínimo: 20s
    PPM_window_sec = 10;


    experiment_fill_in;