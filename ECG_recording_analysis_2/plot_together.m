function plot_together(title_label, f_max_plot_small, f_figure, fft_value, signal, t)
    figure;
    grafico_general = tiledlayout(2, 1, "TileSpacing", "compact", "Padding", "compact");

    % --- Fila 1: gráfico horizontal (ocupa 2 columnas) ---
    ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
    plot(t, signal);
    title(ax1, title_label, 'Interpreter','none');
    xlabel(ax1, 'Time (s)'); 
    ylabel(ax1, 'Amplitud');
    xlim(ax1, [0, max(t)])

    ax2 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
    plot(f_figure, fft_value);
    xlabel(ax2, 'Frequency (Hz)');
    ylabel(ax2, '|X(f)|');
    title(ax2, title_label + " " + "FFT", 'Interpreter','none');
    xlim(ax2, [0, f_max_plot_small])
    grid on;
end