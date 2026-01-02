function plot_with_peaks(mwi_signal, t, A_T, th_ECG_inf, ECG)
    
    figure
    plot(t, mwi_signal);
    title('Moving Average with peaks');
    xlabel('Time [s]');
    ylabel('Amplitude');
    hold on
    plot(t(A_T), mwi_signal(A_T), '*');
    yline(th_ECG_inf, '--r', 'Threshold');
    hold off


    figure
    plot(t, ECG);
    title('ECG with peaks');
    xlabel('Time [s]');
    ylabel('Amplitude');
    hold on
    plot(t(A_T), ECG(A_T), '*');
    hold off

end
