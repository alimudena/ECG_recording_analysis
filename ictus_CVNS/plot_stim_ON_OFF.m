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
    ylim([-0.2 1.2]);
    title('Detección de estimulación (1=sí, 0=no)');
    xlabel('Tiempo (s)');
end