    data = load(folder+"/"+file+".mat");
    signal = data.signal;
    fs = data.sampling_rate;
    ECG = -double(signal(:, 1));
    stim = signal(:, 2);    
    N = length(ECG);
    t = (0:N-1)'/fs;
    % ECG filtering : 50 Hz, stimulation frequency and harmonics, low pass
    % filter
    ECG_filtered = filtering_ECG(ECG, fs, Q, f_low_pass, f_high_pass, f0, f_max);
    window_samples = round(window_ms * 1e-3 * fs);  
    mwi_signal = PanHopkings(ECG_filtered, fs, window_samples);
    [R, R_T]  = findpeaks(mwi_signal, 'MinPeakHeight', th_ECG_inf, 'MinPeakDistance', peak_distance*fs);
    
    
    %%Calculation of bpm with MWI signal beat by beat
    HRV = diff(R_T) / fs;  % en segundos
    t_R = R_T / fs;    % tiempos de los picos R
    HRV_t = t_R(2:end);    % tiempos correspondientes a cada RR


    % General characteristics of the experiment
    Experiments(rodent).experiment_number(Experiment_number).Date = day_of_experiment;
    % Experiments(rodent).experiment_number(Experiment_number).VNS_ID = Experimental_VNS_id(Day_of_experiment);
    Experiments(rodent).experiment_number(Experiment_number).stimulation_type = Experimental_type;
    Experiments(rodent).experiment_number(Experiment_number).Experiment_number=Experiment_number;
    
    % Stimulation parameters
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.Stim_time = stim_time;
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.rest_time = rest_time;
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.frequency = freq_stim;
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.current = current_stim;
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.polarity = stim_polarity;
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.number_of_stimulations = n_stims;
    
    
    % Signals obtained for the experiment
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.ECG = ECG;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.ECG_filtered = ECG_filtered;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.mwi_signal = mwi_signal;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.Stimulation = stim;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.sampling_frequency = fs;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.time = t;
    
    % Parameters used for the extraction of the ECG marquers
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.Threshold = th_ECG_inf;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.F_max = f_max;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.F_low_pass = f_low_pass;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.Qual_factor = Q;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.F_high_pass = f_high_pass;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.Window_ms = window_ms;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.F_0= f0;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.Peak_distance = peak_distance;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.F_max_plot= f_max_plot;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.F_max_plot_small = f_max_plot_small;


    Experiments(rodent).experiment_number(Experiment_number).function_parameters.Low_cut = low_cut;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.High_cut = high_cut;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.Window_smooth = window_smooth;
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.N = n;   % orden optimizado para velocidad


    % Obtained marquers
    Experiments(rodent).experiment_number(Experiment_number).marquers.P = [];
    Experiments(rodent).experiment_number(Experiment_number).marquers.Q = [];
    Experiments(rodent).experiment_number(Experiment_number).marquers.R = R;
    Experiments(rodent).experiment_number(Experiment_number).marquers.R_T = R_T;
    Experiments(rodent).experiment_number(Experiment_number).marquers.S = [];
    Experiments(rodent).experiment_number(Experiment_number).marquers.J = [];
    Experiments(rodent).experiment_number(Experiment_number).marquers.PPM = [];
    Experiments(rodent).experiment_number(Experiment_number).marquers.HRV = HRV;
    Experiments(rodent).experiment_number(Experiment_number).marquers.HRV_t = HRV_t;



    %Extraction of the times it is ON and OFF the stimulation
    [stim_on_off, env_smooth, threshold_stim, start_idx, end_idx] = extract_stim_times(low_cut, high_cut, window_smooth, n, stim, fs, max_gap_sec, min_dur_sec);

    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.stim_ON_OFF = stim_on_off;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.env_SMOOTH = env_smooth;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.threshold_Stim = threshold_stim;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.start_stim_positions = start_idx;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.end_stim_positions = end_idx;

    