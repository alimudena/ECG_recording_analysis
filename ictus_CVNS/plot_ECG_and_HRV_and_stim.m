function [] = plot_ECG_and_HRV_and_stim(Experiments, rodent, experiment_number)
% plot_ECG_and_HRV_and_stim Grafica ECG, HRV y calcula pendientes segmentadas.
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
    HRV = experiment.marquers.HRV;
    t_HRV = experiment.marquers.HRV_t;
    start_times = experiment.obtained_signals.start_stim_positions;
    end_times = experiment.obtained_signals.end_stim_positions;
    
    figure;
    % --- ECG left axis---
    plot(t, ECG);
    xlabel('Time (s)');
    ylabel('ECG (mV)');
    grid on
    hold on
    title('ECG with HRV beat by beat (RR) and stimulation start and end');

    % --- BPM right axis---
    yyaxis right
    plot(t_HRV, HRV, 'MarkerSize', 12);
    ylabel('HRV');

    % Líneas de inicio (verde)
    for i = 1:length(start_times)
        xline(t(start_times(i)), 'g--', 'LineWidth', 1.5);
    end
    
    % Líneas de fin (rojo)
    for i = 1:length(end_times)
        xline(t(end_times(i)), 'r--', 'LineWidth', 1.5);
    end
    
    % =========================================================================
    % NUEVAS MEDIDAS Y REPRESENTACIÓN DE PARÁMETROS PARA HRV
    % =========================================================================
    yyaxis right % Asegura que operamos en el eje de la derecha

    % Creamos un vector de tiempos críticos ordenados para delimitar todos los intervalos
    tiempos_hitos = [t_HRV(1); t(start_times); t(end_times); t_HRV(end)];
    tiempos_hitos = sort(tiempos_hitos); % Ordenar cronológicamente
    tiempos_hitos = unique(tiempos_hitos); % Eliminar duplicados
    
    % Definimos el tamaño de la subventana para el post-estímulo (30 segundos)
    % y el umbral para identificar el bloque largo (ej. mayor a 240 segundos / 4 minutos)
    duracion_subventana = 10; 
    umbral_bloque_largo = 10; 

    % Iteramos sobre cada intervalo detectado
    for idx = 1:(length(tiempos_hitos)-1)
        t_inicio_int = tiempos_hitos(idx);
        t_fin_int = tiempos_hitos(idx+1);
        duracion_intervalo = t_fin_int - t_inicio_int;
        
        % Comprobamos si es un bloque largo (post-estimulación de ~5 min)
        if duracion_intervalo > umbral_bloque_largo
            % Subdividimos el bloque en ventanas consecutivas de 30 segundos
            t_sub_inicios = t_inicio_int : duracion_subventana : (t_fin_int - 1);
            
            for s = 1:length(t_sub_inicios)
                sub_inicio = t_sub_inicios(s);
                % Aseguramos que la última subventana no se pase del límite del bloque
                sub_fin = min(sub_inicio + duracion_subventana, t_fin_int);
                
                % Ejecutar el ajuste lineal para esta subventana
                calcular_y_graficar_pendiente(t_HRV, HRV, sub_inicio, sub_fin);
            end
        else
            % Si es el intervalo de estimulación (30s) o de control inicial, se procesa entero
            calcular_y_graficar_pendiente(t_HRV, HRV, t_inicio_int, t_fin_int);
        end
    end
end

% Subfunción auxiliar para evitar repetir código de cálculo y graficado
function [] = calcular_y_graficar_pendiente(t_HRV, HRV, t_start, t_end)
    indices_int = (t_HRV >= t_start) & (t_HRV <= t_end);
    
    % Solo calculamos si hay datos suficientes en la ventana
    if sum(indices_int) > 1
        hrv_segmento = HRV(indices_int);
        t_segmento = t_HRV(indices_int);
        
        % Calcular métricas locales
        p = polyfit(t_segmento, hrv_segmento, 1); 
        pendiente = p(1);
        hrv_ajuste_lineal = polyval(p, t_segmento);
        
        % Definir colores según el signo de la pendiente
        if (pendiente < 0)
            color_linea = 'k-'; % Negro para pendientes negativas
        else
            color_linea = 'g-'; % Verde para pendientes positivas
        end
        
        % Graficar la línea de tendencia
        plot(t_segmento, hrv_ajuste_lineal, color_linea, 'LineWidth', 1);
    end
end
