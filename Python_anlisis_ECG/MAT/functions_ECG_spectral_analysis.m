function functions_ECG_spectral_analysis(RR, fs_interp, ECG, fs)
    HRV(RR, fs_interp)
    simple_spectrogram(ECG, fs)
    continuous_wavelet_transform(ECG, fs)
end

function HRV(RR, fs_interp)
    t_interp = linspace(0, sum(RR), length(RR));
    tq = 0:1/fs_interp:t_interp(end);
    RR_interp = interp1(t_interp, RR, tq, 'spline');
    
    % Espectro de potencia
    [pxx,f] = pwelch(RR_interp, [], [], [], fs_interp);
    
    figure
    plot(f,10*log10(pxx));
    xlabel('Hz'); ylabel('dB'); title('HRV - espectro de potencia');
    
    % --- Cálculo de bandas específicas ---
    % Bandas típicas en ratones
    LF_band = [0.15 1.5];   % Baja frecuencia
    HF_band = [2 10];       % Alta frecuencia (actividad vagal)
    
    % Potencia en bandas
    LF_power = bandpower(pxx, f, LF_band, 'psd');
    HF_power = bandpower(pxx, f, HF_band, 'psd');
    LF_HF_ratio = LF_power / HF_power;
    
    % Imprimir resultados
    fprintf('\n--- Análisis espectral HRV ---\n');
    fprintf('Potencia LF (%.2f–%.2f Hz): %.4f\n', LF_band(1), LF_band(2), LF_power);
    fprintf('Potencia HF (%.2f–%.2f Hz): %.4f\n', HF_band(1), HF_band(2), HF_power);
    fprintf('Relación LF/HF: %.4f\n', LF_HF_ratio);
end

function simple_spectrogram(ECG, fs)
    figure
    % Spectrograma simple
    spectrogram(ECG, 256, 200, 512, fs, 'yaxis');
    title('Spectrograma de ECG');
end

function continuous_wavelet_transform(ECG, fs)
    figure
    % Asegurar tipo de dato correcto
    ECG = double(ECG);
    
    % Submuestrear a 250 Hz si fs original es más alto
    target_fs = 250;
    if fs > target_fs
        ECG = resample(ECG, target_fs, fs);
        fs = target_fs;
    end

    % Continuous wavelet transform
    cwt(ECG, 'amor', fs);
    title('Wavelet Transform');
end