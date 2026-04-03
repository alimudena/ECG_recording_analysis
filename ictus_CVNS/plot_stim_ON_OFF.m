function [] = plot_stim_ON_OFF(Experiments, rodent, experiment_number)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    Experiments
    rodent
    experiment_number
end

arguments (Output)

end
    experiment = Experiments(rodent).experiment_number(experiment_number);
    ECG = experiment.obtained_signals.ECG;
    t = experiment.obtained_signals.time;
    env_smooth = experiment.obtained_signals.env_SMOOTH;
    threshold_stim = experiment.obtained_signals.threshold_Stim;
    stim_array = experiment.obtained_signals.stim_ON_OFF;
    start_times = experiment.obtained_signals.start_stim_positions;
    end_times = experiment.obtained_signals.end_stim_positions;


    figure;
    
    subplot(3,1,1)
    plot(t, ECG);
    title('ECG original');
    xlabel('Tiempo (s)');
    
    subplot(3,1,2)
    plot(t, env_smooth); hold on;
    yline(threshold_stim, 'r--', 'Umbral');
    title('Envolvente del ruido (20 Hz)');
    xlabel('Tiempo (s)');

    subplot(3,1,3)
    plot(t, stim_array, 'k'); 
    hold on
    ylim([-0.2 1.2]);
    title('Detección de estimulación (1=sí, 0=no)');
    xlabel('Tiempo (s)');
    
    % Líneas de inicio (verde)
    for i = 1:length(start_times)
        xline(t(start_times(i)), 'g--', 'LineWidth', 1.5);
    end
    
    % Líneas de fin (rojo)
    for i = 1:length(end_times)
        xline(t(end_times(i)), 'r--', 'LineWidth', 1.5);
    end
    
    hold off
end