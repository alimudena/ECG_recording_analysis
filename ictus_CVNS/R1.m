Experiments(rodent).ID= "R1";


% Experiment number 1
    Experiment_number = 1;
    Day_of_experiment = 1;
    folder = "../ECG_recording_analysis_2/experiments/VNS-010";
    file = "r1_der_invasivo_electrodo_grande_1mA";

    f_max = 500;
    f_low_pass = 250;
    Q = 200;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 12;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0.1; %*fs
    f_max_plot = 5000;
    f_max_plot_small = 100;


    experiment_fill_in;
    

% Experiment number 2
    Experiment_number = 2;
    Day_of_experiment = 2;
    folder = "../ECG_recording_analysis_2/experiments/VNS-011";
    file = "r1_VNSc_agujas_01.12.25";

    f_max = 500;
    f_low_pass = 250;
    Q = 200;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 50;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0.01; %*fs
    f_max_plot = 5000;
    f_max_plot_small = 100;

    experiment_fill_in;


% Experiment number 3
    Experiment_number = 3;
    Day_of_experiment = 3;
    folder = "../ECG_recording_analysis_2/experiments/VNS-011";
    file = "r1_VNSc_agujas_01.12.25";

    f_max = 500;
    f_low_pass = 250;
    Q = 200;          % Quality factor (higher = thiner)
    f_high_pass = 1;
    window_ms = 15; 
    th_ECG_inf = 50;
    f0 = 20.325;     % Frequency of the noise
    peak_distance = 0.01; %*fs
    f_max_plot = 5000;
    f_max_plot_small = 100;

    experiment_fill_in;