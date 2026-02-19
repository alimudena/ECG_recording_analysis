function show_with_without_stim(ECG, f0, fs, t, t_no_stim, t_stim)
    %%Cálculo de FFT y primera fila de gráficos
    [fft_value, f_figure] = fft_calculation(ECG([1: 100000]), fs);
    
    figure;
    tiledlayout(2, 2, "TileSpacing", "compact", "Padding", "compact");
    
    % --- Fila 1: señal original ---
    ax1 = nexttile([1 1]);

    plot(t(t_no_stim), ECG(t_no_stim));
    title(ax1, 'Original ECG');
    xlabel(ax1, 'Time [s]');
    ylabel(ax1, 'Amplitude');
    
    % --- Fila 1: FFT ---
    ax2 = nexttile([1 1]);
    plot(f_figure, fft_value);
    title(ax2, 'FFT');
    xlabel(ax2, 'Frequency [Hz]');
    ylabel(ax2, 'Power');
    xlim(ax2, [0, 500]);  % límite de visualización
    
    % --- Marcador vertical en 50 Hz para la primera FFT ---
    hold(ax2, 'on');
    xline(ax2, 50, ':r', '50 Hz', 'LabelOrientation', 'horizontal', ...
          'LabelVerticalAlignment', 'middle', 'LineWidth', 0.8);
    hold(ax2, 'off');
    
    %%Nueva ventana temporal y su FFT
    [fft_value, f_figure] = fft_calculation(ECG(t_stim), fs);
    
    % --- Fila 2: señal con estimulación ---
    ax3 = nexttile([1 1]);
    plot(t(t_stim), ECG(t_stim));
    title(ax3, 'ECG with stimulation');
    xlabel(ax3, 'Time [s]');
    ylabel(ax3, 'Amplitude');
    xlim([401, 411])
    
    % --- Fila 2: FFT con estimulación ---
    ax4 = nexttile([1 1]);
    plot(f_figure, fft_value);
    title(ax4, 'FFT with stimulation');
    xlabel(ax4, 'Frequency [Hz]');
    ylabel(ax4, 'Power');
    xlim(ax4, [0, 500]);  % límite de visualización
    
    % --- Marcadores: 50 Hz + todos los armónicos de 20 Hz (20,40,60,...) ---
    hold(ax4, 'on');
    
    % 50 Hz (mismo estilo que arriba)
    xline(ax4, 50, ':r', '50 Hz', 'LabelOrientation', 'horizontal', ...
          'LabelVerticalAlignment', 'middle', 'LineWidth', 0.8);
    
    % Armónicos de 20 Hz dentro del rango visible/datos
    maxFreqVisible = min(0, max(f_figure));        % asegúrate de no salirte de los datos
    harmonics20 = f0:f0:500;              % 20, 40, 60, ...
    % (opcional) evita duplicar la etiqueta de 50 si coincide con un armónico
    % pero se permite mantener 50 también como armónico si lo quieres ver doble.
    % Aquí optamos por NO etiquetar cada armónico para no saturar:
    xline(ax4, 20.2998, ':k', '20 Hz', 'LabelOrientation', 'horizontal', ...
          'LabelVerticalAlignment', 'top', 'LineWidth', 0.8);  % líneas punteadas negras
    for h = harmonics20
        % usa un estilo distinto a 50 Hz para diferenciarlos
        if h == 50
            % ya está marcado arriba; si quieres que también se pinte como armónico, comenta el 'continue'
            continue;
        end
        xline(ax4, h, ':k', 'LineWidth', 0.8);  % líneas punteadas negras
    end
    
end