%% function for plotting ECG
function plot_ECG_only(time, ECG, label, initial_time, end_time)
        figure('Units','normalized','OuterPosition',[0 0 1 1]);     
        plot(time, ECG, "Color", [0 0.4470 0.7410])
        xlim([initial_time, end_time])
        title(label)
end