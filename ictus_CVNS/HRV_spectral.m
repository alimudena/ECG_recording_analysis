function [LF_power, HF_power, LF_HF_ratio, f, pxx, TP_power] = HRV_spectral(t_beats, t_start, t_end)
% HRV_SPECTRAL - Análisis espectral de HRV en ratón
%
% INPUTS:
%   t_beats : vector con tiempos de latidos (en segundos)
%   t_start : inicio de la ventana de análisis
%   t_end   : fin de la ventana de análisis
%
% OUTPUTS:
%   LF_power     : potencia en banda LF (0.1–1 Hz)
%   HF_power     : potencia en banda HF (1–4 Hz)
%   LF_HF_ratio  : ratio LF/HF
%   f            : vector de frecuencias
%   pxx          : densidad espectral de potencia
%   TP_power     : potencia total integrada para f < 0.4 Hz

%%--- 1. Seleccionar latidos en la ventana ---
idx = t_beats >= t_start & t_beats <= t_end;
t_sel = t_beats(idx);

% Comprobar suficientes latidos
if length(t_sel) < 10
    warning('Muy pocos latidos en la ventana');
    LF_power = NaN;
    HF_power = NaN;
    LF_HF_ratio = NaN;
    f = [];
    pxx = [];
    TP_power = NaN;
    return;
end

%%--- 2. Calcular intervalos RR ---
RR = diff(t_sel);
t_RR = t_sel(1:end-1);

%%--- 3. Interpolación a señal uniforme ---
fs_interp = 20; % Hz (válido para ratón)

t_uniform = t_RR(1):1/fs_interp:t_RR(end);

RR_interp = interp1(t_RR, RR, t_uniform, 'spline');

% Eliminar tendencia
RR_interp = detrend(RR_interp);

%%--- 4. PSD con Welch ---
window = round(5 * fs_interp); % ventana de 5 s
noverlap = round(window / 2);
window = min(window, length(RR_interp));

[pxx, f] = pwelch(RR_interp, window, noverlap, [], fs_interp);

%%--- 5. Bandas LF y HF (ratón) ---
LF_band = [0.1 1.0];
HF_band = [1.0 4.0];

LF_idx = f >= LF_band(1) & f < LF_band(2);
HF_idx = f >= HF_band(1) & f < HF_band(2);

%%--- 6. Integrar potencia ---
LF_power = trapz(f(LF_idx), pxx(LF_idx));
HF_power = trapz(f(HF_idx), pxx(HF_idx));

%%--- 7. Ratio LF/HF ---
LF_HF_ratio = LF_power / HF_power;

%%--- 8. Total Power (f < 0.4 Hz) ---
TP_idx = f < 0.4;
TP_power = trapz(f(TP_idx), pxx(TP_idx));


% Conversión de s^2 a ms^2
LF_power = LF_power * 1e6;
HF_power = HF_power * 1e6;
TP_power = TP_power * 1e6;

end