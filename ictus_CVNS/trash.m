%PPM cálculo de intervalos

% start_idx y end_idx deben estar ya calculados
% R_T = índices de muestra donde ocurre cada latido
% t = vector de tiempos

nStim = length(start_idx);

BPM_before  = zeros(nStim,1);
BPM_during  = zeros(nStim,1);
BPM_after   = zeros(nStim,1);
for k = 1:nStim
    
    % Intervalos de muestra (30 s antes, durante, 30 s después)
    t_start = t(start_idx(k));
    t_end   = t(end_idx(k));
    
    % --- 30 SEGUNDOS ANTES ---
    t1 = t_start - 30;
    idx_before = find(t >= t1 & t < t_start);
    % latidos que caen en ese intervalo
    beats_before = R_T(R_T >= idx_before(1) & R_T <= idx_before(end));
    BPM_before(k) = numel(beats_before) / (t_start - t1) * 60;

    % --- DURANTE LA ESTIMULACIÓN ---
    idx_during = start_idx(k) : end_idx(k);
    beats_during = R_T(R_T >= idx_during(1) & R_T <= idx_during(end));
    BPM_during(k) = numel(beats_during) / (t_end - t_start) * 60;

    % --- 30 SEGUNDOS DESPUÉS ---
    t2 = t_end + 30;
    idx_after = find(t > t_end & t <= t2);
    beats_after = R_T(R_T >= idx_after(1) & R_T <= idx_after(end));
    BPM_after(k) = numel(beats_after) / (t2 - t_end) * 60;

end



%%
% Mostrar resultados

mu = [mean(BPM_before), mean(BPM_during), mean(BPM_after)];
sigma = [std(BPM_before), std(BPM_during), std(BPM_after)];

figure
errorbar(1:3, mu, sigma, 'o', 'LineWidth', 1.5)
xlim([0.5 3.5])
xticks(1:3)
xticklabels({'Before', 'During', 'After', 'Between'})
ylabel('BPM')
grid on
title('Media y desviación típica del BPM')



%%

%% PPM + HRV cálculo de intervalos
% Requisitos previos:
% start_idx, end_idx : índices de inicio y fin de cada estímulo
% R_T                : índices de muestra de los latidos (picos R)
% t                  : vector de tiempo (s)

nStim = length(start_idx);

%%Inicialización BPM
BPM_before  = zeros(nStim,1);
BPM_during  = zeros(nStim,1);
BPM_after   = zeros(nStim,1);

%%Inicialización HRV
MNN_before   = zeros(nStim,1);
SDNN_before  = zeros(nStim,1);
RMSSD_before = zeros(nStim,1);
SDANN_before = zeros(nStim,1);

MNN_during   = zeros(nStim,1);
SDNN_during  = zeros(nStim,1);
RMSSD_during = zeros(nStim,1);
SDANN_during = zeros(nStim,1);

MNN_after    = zeros(nStim,1);
SDNN_after   = zeros(nStim,1);
RMSSD_after  = zeros(nStim,1);
SDANN_after  = zeros(nStim,1);

%%Bucle principal
for k = 1:nStim

    t_start = t(start_idx(k));
    t_end   = t(end_idx(k));

    %%=======================
    % 30 s BEFORE
    %%=======================
    t1 = t_start - 30;
    idx_before = find(t >= t1 & t < t_start);
    if numel(idx_before) > 1
        beats_before = R_T(R_T >= idx_before(1) & R_T <= idx_before(end));

        % BPM
        BPM_before(k) = numel(beats_before) / (t_start - t1) * 60;

        % HRV
        if numel(beats_before) > 2
            RR = diff(t(beats_before));

            MNN_before(k)   = mean(RR);
            SDNN_before(k)  = std(RR);
            RMSSD_before(k)= sqrt(mean(diff(RR).^2));

            % SDANN (segmentos de 10 s)
            seg_edges = t1:10:t_start;
            mRR = [];
            for s = 1:length(seg_edges)-1
                seg_beats = beats_before( ...
                    t(beats_before) >= seg_edges(s) & ...
                    t(beats_before) <  seg_edges(s+1));
                if numel(seg_beats) > 1
                    mRR(end+1) = mean(diff(t(seg_beats))); %#ok<SAGROW>
                end
            end
            SDANN_before(k) = std(mRR);
        end
    end

    %%=======================
    % DURING estímulo
    %%=======================
    idx_during = start_idx(k):end_idx(k);
    beats_during = R_T(R_T >= idx_during(1) & R_T <= idx_during(end));

    % BPM
    BPM_during(k) = numel(beats_during) / (t_end - t_start) * 60;

    % HRV
    if numel(beats_during) > 2
        RR = diff(t(beats_during));

        MNN_during(k)   = mean(RR);
        SDNN_during(k)  = std(RR);
        RMSSD_during(k)= sqrt(mean(diff(RR).^2));

        % SDANN (segmentos de 30 s)
        seg_edges = t_start:30:t_end;
        mRR = [];
        for s = 1:length(seg_edges)-1
            seg_beats = beats_during( ...
                t(beats_during) >= seg_edges(s) & ...
                t(beats_during) <  seg_edges(s+1));
            if numel(seg_beats) > 1
                mRR(end+1) = mean(diff(t(seg_beats))); %#ok<SAGROW>
            end
        end
        SDANN_during(k) = std(mRR);
    end

    %%=======================
    % 30 s AFTER
    %%=======================
    t2 = t_end + 30;
    idx_after = find(t > t_end & t <= t2);
    if numel(idx_after) > 1
        beats_after = R_T(R_T >= idx_after(1) & R_T <= idx_after(end));

        % BPM
        BPM_after(k) = numel(beats_after) / (t2 - t_end) * 60;

        % HRV
        if numel(beats_after) > 2
            RR = diff(t(beats_after));

            MNN_after(k)   = mean(RR);
            SDNN_after(k)  = std(RR);
            RMSSD_after(k)= sqrt(mean(diff(RR).^2));

            % SDANN (segmentos de 10 s)
            seg_edges = t_end:10:t2;
            mRR = [];
            for s = 1:length(seg_edges)-1
                seg_beats = beats_after( ...
                    t(beats_after) >= seg_edges(s) & ...
                    t(beats_after) <  seg_edges(s+1));
                if numel(seg_beats) > 1
                    mRR(end+1) = mean(diff(t(seg_beats))); %#ok<SAGROW>
                end
            end
            SDANN_after(k) = std(mRR);
        end
    end
end

%% =======================
% Estadísticos BPM
%%=======================
mu_BPM    = [mean(BPM_before), mean(BPM_during), mean(BPM_after)];
sigma_BPM = [std(BPM_before),  std(BPM_during),  std(BPM_after)];

figure
errorbar(1:3, mu_BPM, sigma_BPM, 'o','LineWidth',1.5)
xlim([0.5 3.5])
xticks(1:3)
xticklabels({'Before','During','After'})
ylabel('BPM')
grid on
title('Media y desviación típica del BPM')

%% =======================
% Estadísticos HRV (ejemplo MNN)
%%=======================
mu_MNN    = [mean(MNN_before), mean(MNN_during), mean(MNN_after)];
sigma_MNN = [std(MNN_before),  std(MNN_during),  std(MNN_after)];

figure
errorbar(1:3, mu_MNN, sigma_MNN, 'o','LineWidth',1.5)
xlim([0.5 3.5])
xticks(1:3)
xticklabels({'Before','During','After'})
ylabel('MNN (s)')
grid on
title('MNN – Media y desviación típica')


%% =======================
% Estadísticos HRV (ejemplo RMSSD)
%%=======================
mu_RMSSD    = [mean(RMSSD_before), mean(RMSSD_during), mean(RMSSD_after)];
sigma_RMSSD = [std(RMSSD_before),  std(RMSSD_during),  std(RMSSD_after)];

figure
errorbar(1:3, mu_RMSSD, sigma_RMSSD, 'o','LineWidth',1.5)
xlim([0.5 3.5])
xticks(1:3)
xticklabels({'Before','During','After'})
ylabel('RMSSD (s)')
grid on
title('RMSSD – Media y desviación típica')




%% =======================
% Estadísticos HRV (ejemplo SDANN)
%%=======================
mu_SDANN    = [mean(SDANN_before), mean(SDANN_during), mean(SDANN_after)];
sigma_SDANN = [std(SDANN_before),  std(SDANN_during),  std(SDANN_after)];

figure
errorbar(1:3, mu_SDANN, sigma_SDANN, 'o','LineWidth',1.5)
xlim([0.5 3.5])
xticks(1:3)
xticklabels({'Before','During','After'})
ylabel('SDANN (s)')
grid on
title('SDANN – Media y desviación típica')

