Experiments(rodent).ID= "aVNS_PCM_R01";
% Experiment number 1 in rodent R01
    %------ Flor fill in ------%%
    Experiment_number = 1;
    day_of_experiment = '17-06-2026'; %Day-month-year
    folder = "../../raw_data/PCM/matlab_archivos/aVNS_stroke_1";
    file = "R01_01";

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
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 10; 
    th_ECG_inf = 7;
    th_ECG_sup = 40;
    th_inf_HRV = 0.05;
    th_sup_HRV = 0.15;

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




% Experiment number 2 in rodent R01
    %%------ Flor fill in ------%%
    Experiment_number = 2;
    day_of_experiment = '18-06-2026'; %Day-month-year
    % folder = "Exp_aVNS_stroke_1/R01";
    file = "R01_02";

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
    window_ms = 10; 
    th_ECG_inf = 15;
    th_ECG_sup = 45;
    th_inf_HRV = 0.05;
    th_sup_HRV = 0.15;
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

% Experiment number 3 in rodent R01
    %%------ Flor fill in ------%%
    Experiment_number = 3;
    day_of_experiment = '18-06-2026'; %Day-month-year
    file = "R01_03";

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
    Q = 100;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 20;
    th_ECG_sup = 80;
    th_inf_HRV = 0.05;
    th_sup_HRV = 0.15;    f0 = 20.325;     % Frequency of the noise
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