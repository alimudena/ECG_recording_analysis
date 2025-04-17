function ECG = filter_ECG(ECG, fs)
    %filtrado paso alto equivalente al analogico
    %highpass(ECG,0.159,fs);

    %filtrado paso bajo equivalente al analogico
    f0 = 70; % Frecuencia de corte (Hz)
    w0 = 2 * pi * f0; % Frecuencia angular
    
    % Q de cada etapa
    Q1 = 0.54;
    Q2 = 1.29;
    
    % Función de transferencia de cada etapa (dominio s)
    s = tf('s');
    
    H1 = w0^2 / (s^2 + (w0/Q1)*s + w0^2);
    H2 = w0^2 / (s^2 + (w0/Q2)*s + w0^2);
    
    % Filtro total como cascada
    H_total = H1 * H2;
    
    % Conversión a digital con Tustin
    Hd = c2d(H_total, 1/fs, 'tustin');

    % Obtener coeficientes
    [b, a] = tfdata(Hd, 'v');

    % Filtrado sin fase
    ECG = filtfilt(b, a, ECG);


    %Eliminar artefactos de la señal

    threshold = mean(ECG) + 5*std(ECG); 
    % Detectar los índices donde el valor es un artefacto
    artefactos = abs(ECG) > threshold;
    
    % Opcional: reemplazar con interpolación
    ECG(artefactos) = interp1(find(~artefactos), ECG(~artefactos), find(artefactos), 'linear');


end

