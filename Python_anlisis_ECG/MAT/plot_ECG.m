%% function for plotting ECG
function plot_ECG(time, ECG, stimulation, label, initial_time, end_time)
        figure('Units','normalized','OuterPosition',[0 0 1 1]);
        plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
        hold on
        yyaxis right;        
        plot(time, ECG, "Color", [0 0.4470 0.7410])
        xlim([initial_time, end_time])

        legend('Stimulation', 'ECG');
        hold off
        title(label)
end