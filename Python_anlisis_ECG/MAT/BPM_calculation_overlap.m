function [R_time_intervals, BPM, R_intervals] = BPM_calculation_overlap(segment_duration, delta_time, fs, ecg_signal, R_locs)
    segment_samples = segment_duration*fs;
    delta_samples = delta_time*fs;
    % Contar el número de segmentos que se van a estudiar
    number_of_segments = ceil(length(ecg_signal)/segment_samples);
    BPM = zeros(1, number_of_segments);
    R_time_intervals = zeros(1, number_of_segments);
    R_intervals = zeros(1, number_of_segments);
    for i = 1:number_of_segments
        
        % Definir el inicio y el final del segmento 
        segment_start = (i-1)*delta_samples+1;
        segment_end = segment_start + segment_samples - 1;
        
        % contar los R que están en el intervalo de muestras que se ha
        % definido
        R_counted_segment = sum(R_locs >= segment_start & R_locs<= segment_end);

        % Guardar en el array de picos R contados en el segmento
        R_intervals(i) = R_counted_segment;
        
        
        % Guardar el instante en el que se está midiendo el inicio del
        % intervalo
        R_time_intervals(i) = (segment_start-1)/fs;
    
        % Calcular BPM
        BPM(i) = (R_counted_segment / segment_duration) * 60;
        
    end
    
end
