Experiments(rodent).ID= "aVNS_PCM_R02";
% Experiment number 1 in rodent R02
    %%------ Flor fill in ------%%
    Experiment_number = 1;
    day_of_experiment = '17-06-2026'; %Day-month-year
    folder = "../../raw_data/PCM/matlab_archivos/aVNS_stroke_1";
    file = "R02_01";

    Experimental_type = "Control";

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
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 12;
    th_ECG_sup = 160;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0; %*fs
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


% Experiment number 2 in rodent R02
    %%------ Flor fill in ------%%
    Experiment_number = 2;
    day_of_experiment = '18-06-2026'; %Day-month-year
    file = "R02_02";
    Experimental_type = "Control";

    stim_time =  "30 seconds";
    rest_time =  "5 minutes";
    freq_stim =  "20 Hz";
    current_stim =  "500 mA";
    stim_polarity = "Bipolar";
    n_stims = 4;
    notation = "in case any anotation wants to be done";


    %Stimulation times on off extraction
    low_cut = 17;
    high_cut = 23;
    window_smooth = 0.0005;
    n = 600;   % orden optimizado para velocidad
    max_gap_sec = 1;                     % <-- AJÃšSTALO (te recomiendo 2s)
    min_dur_sec = 5;                   % mÃ­nimo: 20s
    PPM_window_sec = 5;


    %%------ Alimu fill in ------%%
    f_max = 500;
    f_low_pass = 250;
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 5;
    th_ECG_sup = 160;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0; %*fs
    f_max_plot = 5000;
    f_max_plot_small = 100;
    studied_intervals = 30; %Seconds
    %for extracting the timing parameters during smaller periods of time 
    small_time = 5; % Seconds * fs --> 


    %Stimulation times on off extraction
    low_cut = 10;
    high_cut = 23;
    window_smooth = 0.0005;
    n = 600;   % orden optimizado para velocidad
    max_gap_sec = 1;                     % <-- ajustalo (te recomiendo 2s)
    min_dur_sec = 5;                   % mÃ­nimo: 20s
    PPM_window_sec = 5;


    experiment_fill_in;


% Experiment number 3 in rodent R02
    %%------ Flor fill in ------%%
    Experiment_number = 3;
    day_of_experiment = '18-06-2026'; %Day-month-year
    file = "R02_03";

    Experimental_type = "Control";

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
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 5;
    th_ECG_sup = 160;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0; %*fs
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
    max_gap_sec = 1;                     % <-- ajustalo (te recomiendo 2s)
    min_dur_sec = 5;                   % mÃƒÂ­nimo: 20s
    PPM_window_sec = 5;

    experiment_fill_in;
