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
    Experiments(rodent).experiment_number(Experiment_number).Date = Experimental_days(Day_of_experiment);
    Experiments(rodent).experiment_number(Experiment_number).VNS_ID = Experimental_VNS_id(Day_of_experiment);
    Experiments(rodent).experiment_number(Experiment_number).stimulation_type = Experimental_types(1);
    Experiments(rodent).experiment_number(Experiment_number).Experiment_number=Experiment_number;
    
    % Stimulation parameters
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.Stim_time = "30 seconds";
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.rest_time = "5 minutes";
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.frequency = "20 Hz";
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.current = "500 mA";
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.polarity = Experimental_polarity(1);
    Experiments(rodent).experiment_number(Experiment_number).stimulation_parameters.number_of_stimulations = 4;
    
    
    % Signals obtained for the experiment
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.ECG = ECG;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.ECG_filtered = ECG_filtered;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.mwi_signal = mwi_signal;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.Stimulation = stim;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.sampling_frequency = fs;
    Experiments(rodent).experiment_number(Experiment_number).obtained_signals.time = t;
    
    % Parameters used for the extraction of the ECG marquers
    Experiments(rodent).experiment_number(Experiment_number).function_parameters.threshold = th_ECG_inf;
    
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