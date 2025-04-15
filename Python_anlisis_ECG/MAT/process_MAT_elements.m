%%
clc
clear
close all

%%
EXP_sel = 3.1;
for RODENT_sel = 1:5
    save_option = 0;
    
    if EXP_sel == 1
        folder = "EXP001";
        threshold = 0.25;
    
    elseif EXP_sel == 2
        folder = "EXP002";
        if RODENT_sel == 1
            file = "raton1_est_anestesia.mat";
            threshold = 0.6;
    
        elseif RODENT_sel == 2
            file = "raton2_no_est_anestesia.mat";
        else
            break;
        end
    elseif EXP_sel == 3.1
        folder = "EXP003/inhalada";
        if RODENT_sel == 1
            file = "RATON1-AN+EST.mat";
            threshold = 0.4;
    
        elseif RODENT_sel == 2
            file = "RATON2-EST-AN.mat";
            threshold = 0.5;
    
        
        elseif RODENT_sel == 3
            file = "RATON3-EST-AN.mat";
            threshold = 0.6;
    
    
        elseif RODENT_sel == 4
            file = "RATON4-CONTROL-FALSAEST-AN.mat";
            threshold = 0.6;
    
    
        elseif RODENT_sel == 5
            file = "RATON5-CONTROL-AN-FALSAEST.mat";
            threshold = 0.6;
    
    
        end
    elseif EXP_sel == 3.2
        folder = "EXP003/no_inhalada";
        if RODENT_sel == 1
            file = "RATON1-30+EST.mat";
            threshold = 0.6;
    
        elseif RODENT_sel == 2
            file = "RATON2-EST+30.mat";
            threshold = 0.6;
    
        elseif RODENT_sel == 3
            file = 'RATON3-EST+15 (1PARTE).mat';
            threshold = 0.6;
         
        elseif RODENT_sel == 4
        file = 'RATON3-POST EST-(2PARTE).mat';
        threshold = 0.6;
    
    
        elseif RODENT_sel == 5
        file = 'RATON4-30+EST.mat';
        threshold = 0.6;
    
        
        
        end
    elseif EXP_sel == 4
        folder = "EXP004";
        if RODENT_sel == 1
            file = "RATON1_30AN_30EST_30AN.mat";
            threshold = 0.6;
    
        elseif RODENT_sel == 2
            file = "RATON2_30AN_30EST_15AN.mat";
            threshold = 0.6;
    
        elseif RODENT_sel == 3
            file = 'RATON3_EST_40AN.mat';
            threshold = 0.6;
    
        elseif RODENT_sel == 4
            file = 'RATON4_EST_40AN.mat';
            threshold = 0.6;
    
    
        elseif RODENT_sel == 5
            file = 'RATON5_CONTROL_FALSAEST_40AN.mat';
            threshold = 0.6;

        elseif RODENT_sel == 6
            file = 'RATON6_CONTROL_FALSAEST_40MINAN.mat';
            threshold = 0.6;    
    
        end
    end
    
    process_file(folder, file, threshold, save_option);
    fprintf(folder+file+" Done\r\n")
end


