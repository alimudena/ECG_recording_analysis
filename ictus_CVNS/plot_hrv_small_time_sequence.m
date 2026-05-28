function plot_hrv_small_time_sequence(Experiments, rodent, Experiment_number)
	arguments
		Experiments
		rodent (1,1) double
		Experiment_number = "all"
	end

	if rodent < 1 || rodent > numel(Experiments)
		error('rodent fuera de rango.');
	end

	if ~isfield(Experiments(rodent), 'experiment_number')
		error('No se encontro el campo experiment_number para el roedor indicado.');
	end

    MNN_N_baseline = Experiments(rodent).experiment_number(Experiment_number).marquers.MNN_N_baseline;
    SDDN_N_baseline = Experiments(rodent).experiment_number(Experiment_number).marquers.SDDN_N_baseline;
    RMSSD_N_baseline = Experiments(rodent).experiment_number(Experiment_number).marquers.RMSSD_N_baseline;
    
    MNN_N_stimulation = Experiments(rodent).experiment_number(Experiment_number).marquers.MNN_N_stimulation;
    SDDN_N_stimulation = Experiments(rodent).experiment_number(Experiment_number).marquers.SDDN_N_stimulation;
    RMSSD_N_stimulation = Experiments(rodent).experiment_number(Experiment_number).marquers.RMSSD_N_stimulation;
    
    MNN_N_rest = Experiments(rodent).experiment_number(Experiment_number).marquers.MNN_N_rest;
    SDDN_N_rest = Experiments(rodent).experiment_number(Experiment_number).marquers.SDDN_N_rest;
    RMSSD_N_rest = Experiments(rodent).experiment_number(Experiment_number).marquers.RMSSD_N_rest;

    stim_init = Experiments(rodent).experiment_number(Experiment_number).obtained_signals.start_stim_positions;
    stim_end = Experiments(rodent).experiment_number(Experiment_number).obtained_signals.end_stim_positions;
    
    fs = Experiments(rodent).experiment_number(Experiment_number).obtained_signals.sampling_frequency;

    time_intervals_small = sort(Experiments(rodent).experiment_number(Experiment_number).marquers.time_intervals_small);
    
    MNN_experiment = [MNN_N_baseline];
    SDDN_experiment = [SDDN_N_baseline];
    RMSSD_experiment = [RMSSD_N_baseline];
    
    for iteration = 1:length(SDDN_N_stimulation(:, 1))
        % MNN_experiment = [MNN_experiment, MNN_N_stimulation(iteration, :), MNN_N_rest(iteration, :)];
        % SDDN_experiment = [SDDN_experiment, SDDN_N_stimulation(iteration, :), SDDN_N_rest(iteration, :)];
        % RMSSD_experiment = [RMSSD_experiment, RMSSD_N_stimulation(iteration, :), RMSSD_N_rest(iteration, :)];
        MNN_experiment = [MNN_experiment, MNN_N_rest(iteration, :), MNN_N_stimulation(iteration, :)];
        SDDN_experiment = [SDDN_experiment,  SDDN_N_rest(iteration, :), SDDN_N_stimulation(iteration, :)];
        RMSSD_experiment = [RMSSD_experiment, RMSSD_N_rest(iteration, :), RMSSD_N_stimulation(iteration, :)];
    end

    MNN_experiment(MNN_experiment==0) = [];
    SDDN_experiment(SDDN_experiment==0) = [];
    RMSSD_experiment(RMSSD_experiment==0) = [];

    figure
    plot(time_intervals_small/fs, MNN_experiment)
    title("MNN values every N seconds")
    hold on
    xline(stim_init/fs, '--r')
    xline(stim_end/fs, '--g') 

    figure
    plot(time_intervals_small/fs, SDDN_experiment)
    title("SDDN values every N seconds")
    hold on
    xline(stim_init/fs, '--r')
    xline(stim_end/fs, '--g') 

    figure
    plot(time_intervals_small/fs, RMSSD_experiment)
    title("RMSSD values every N seconds")
    hold on
    xline(stim_init/fs, '--r')
    xline(stim_end/fs, '--g') 

end