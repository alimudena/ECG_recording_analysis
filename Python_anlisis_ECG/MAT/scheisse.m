clc
clear

folder = "EXP004";

file = "RATON1_30AN_30EST_30AN.mat";
threshold = 0.6;
save_option = 0;

process_file(folder, file, threshold, save_option);
fprintf(folder+"\"+file+" Done\r\n")

%%
EXP_folder = "EXP004/data_extracted/";
load(EXP_folder+'RATON1_30AN_30EST_30AN.mat')
fs = 10000;
stim_ref_1                  = stim_reference;
ECG_1                       = ECG;
time_1                      = time;

leg_1                       = "R1-30AN-30EST-30AN - EXP004";
R_locs_1                    = peak_detection(ECG_1, 0.6, fs);
[BPM_1, interval_1]         = BMP_calculation(R_locs_1, Ts);
fprintf(leg_1+"\r\n")
if PLOT_ECGS == 1
    plot_ECG(time_1, ECG_1, R_locs_1, leg_1)
end