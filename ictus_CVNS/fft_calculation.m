function [fft_result, f_figure] = fft_calculation(signal, fs)
    %%fft calculation
    N = length(signal);
    
    % Calculate FFT
    X = fft(signal); % Calculate spectrum magnitude
    fft_result = abs(X)/N;     % Normalization
    fft_result = fft_result(1:N/2+1); % positive half spectrum
    fft_result(2:end-1) = 2*fft_result(2:end-1); % Compensate deleted energy
    f_figure = (0:N/2)*fs/N; % Frequency vector
end