
%% This skript unpacks and loads the rezeptive field python(npz) data
% For Mi1 Figure 4b
%  Plots the receptive fields


% predictions = response prediction based on RF
%   pred1 = for first epoch
%   pred2= for second epoch , ... predictions can slightly vary because of
%                   frames in stim that might be skipped...
% stas = receptive fields
% corrcoefs= correlation of the predicted response and real response



clear all
close all

addpath(genpath('subscripts'))
% ___________


Rel_thres=0.1;
Predicition_thres=0.26;

Conditions={'Control','C2shi'};
filesource='Data/STRFs';


%____________

load('Data/colormap_RF.mat')

%% Load DATA

RF_DATA=load([filesource,'/RF_DATA_Mi1.mat']);
RF_DATA=RF_DATA.RF_DATA; 
    

%% Run average function

Weighted=true;
NCon=1; %Control Condition
[Av_STRF,SpEx_Az_Max,SpEx_El_Max]=Average_STRFsMi1(RF_DATA,NCon,Predicition_thres,Rel_thres,Weighted);

FWHM_Con=Gaussian_Fit_Mi1(SpEx_El_Max);

NCon=2; %C2 Silenced Condition
[Av_STRF,SpEx_Az_Max,SpEx_El_Max]=Average_STRFsMi1(RF_DATA,NCon,Predicition_thres,Rel_thres,Weighted);

FWHM_C2B=Gaussian_Fit_Mi1(SpEx_El_Max);

[p,h] = ranksum(FWHM_Con,FWHM_C2B)


%% quantify pos and negative lobe

NCON=1; %Control Condition
[TimingC2,timeElC2]=Plot_timeSectionSTRFMi1(RF_DATA, NCON,Predicition_thres,Rel_thres)

NCON=2; %C2 Silenced Condition
[TimingC3,timeElC3]=Plot_timeSectionSTRFMi1(RF_DATA, NCON,Predicition_thres,Rel_thres)
%

Timing_All_El=nan(2,100);
Timing_All_Az=nan(2,100);

Timing_All_El(1,1:length(timeElC2))=timeElC2; 
Timing_All_El(2,1:length(timeElC3))=timeElC3; 


boxplot(Timing_All_El','notch', 'on', 'labels', {'Control','C2>>shi'})
set(gca, 'YLim' , [-0.3 0.04])
ylabel('Timing of highest correlation')
title('El')


[p,h] = ranksum(timeElC2,timeElC3)




