function fft_plot(title_label, f_max_plot, f_max_plot_small, f_figure, fft_value)
    figure;
    plot(f_figure, fft_value);
    xlabel('Frequency (Hz)');
    ylabel('|X(f)|');
    title(title_label);
    xlim([0, f_max_plot])
    grid on;
    
    figure;
    plot(f_figure, fft_value);
    xlabel('Frequency (Hz)');
    ylabel('|X(f)|');
    title(title_label);
    xlim([0, f_max_plot_small])
    grid on;
end