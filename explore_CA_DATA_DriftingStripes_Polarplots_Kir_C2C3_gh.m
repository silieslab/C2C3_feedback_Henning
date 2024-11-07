% explore_CA_DATA_DriftingStripes_Polarplots

%%%%%%%%%%
% Play one after another!!
%%%%%%%%%%


close all
clear all
clc

% You want to save figures??
SAVE=0;   %Put 1 if you want to save!!  

addpath(genpath('subscripts'));


% Load the data of the different conditions
Conditions.Control.OFF=load('Data/DSData/processed_Data_SIMA_CS5_Control_OFF.mat');
Conditions.Control.ON=load('Data/DSData/processed_Data_SIMA_CS5_Control_ON.mat');

Conditions.C2Silence.OFF=load('Data/DSData/processed_Data_SIMA_CS5_C2Sil_OFF.mat');
Conditions.C2Silence.ON=load('Data/DSData/processed_Data_SIMA_CS5_C2Sil_ON.mat');

Conditions.C3Silence.OFF=load('Data/DSData/processed_Data_SIMA_CS5_C3Sil_OFF.mat');
Conditions.C3Silence.ON=load('Data/DSData/processed_Data_SIMA_CS5_C3Sil_ON.mat');

Conditions.C2C3Silence.OFF=load('Data/DSData/processed_Data_SIMA_CS5_C2C3Sil_OFF.mat');
Conditions.C2C3Silence.ON=load('Data/DSData/processed_Data_SIMA_CS5_C2C3Sil_ON.mat');



CON=fields(Conditions);
Ncon=length(CON);
%% Polar Plots 
% For comparison between conditions I have to reduce the N of the control
% condition to 7 (between C2 and C3 silencing) 

Conditions_Cmp=Conditions; 
%rand gave me [2;6;5;10;7;11;4]
R=[2;6;5;10;7;11;4];
Conditions_Cmp.Control.OFF.ALL_Flies.T5A=Conditions.Control.OFF.ALL_Flies.T5A(:,:,R);
Conditions_Cmp.Control.OFF.ALL_Flies.T5B=Conditions.Control.OFF.ALL_Flies.T5B(:,:,R);
Conditions_Cmp.Control.OFF.ALL_Flies.T5C=Conditions.Control.OFF.ALL_Flies.T5C(:,:,R);
Conditions_Cmp.Control.OFF.ALL_Flies.T5D=Conditions.Control.OFF.ALL_Flies.T5D(:,:,R);
Conditions_Cmp.Control.OFF.ALL_Flies.T4A=Conditions.Control.OFF.ALL_Flies.T4A(:,:,R);
Conditions_Cmp.Control.OFF.ALL_Flies.T4B=Conditions.Control.OFF.ALL_Flies.T4B(:,:,R);
Conditions_Cmp.Control.OFF.ALL_Flies.T4C=Conditions.Control.OFF.ALL_Flies.T4C(:,:,R);
Conditions_Cmp.Control.OFF.ALL_Flies.T4D=Conditions.Control.OFF.ALL_Flies.T4D(:,:,R);

Conditions_Cmp.Control.ON.ALL_Flies.T5A=Conditions.Control.ON.ALL_Flies.T5A(:,:,R);
Conditions_Cmp.Control.ON.ALL_Flies.T5B=Conditions.Control.ON.ALL_Flies.T5B(:,:,R);
Conditions_Cmp.Control.ON.ALL_Flies.T5C=Conditions.Control.ON.ALL_Flies.T5C(:,:,R);
Conditions_Cmp.Control.ON.ALL_Flies.T5D=Conditions.Control.ON.ALL_Flies.T5D(:,:,R);
Conditions_Cmp.Control.ON.ALL_Flies.T4A=Conditions.Control.ON.ALL_Flies.T4A(:,:,R);
Conditions_Cmp.Control.ON.ALL_Flies.T4B=Conditions.Control.ON.ALL_Flies.T4B(:,:,R);
Conditions_Cmp.Control.ON.ALL_Flies.T4C=Conditions.Control.ON.ALL_Flies.T4C(:,:,R);
Conditions_Cmp.Control.ON.ALL_Flies.T4D=Conditions.Control.ON.ALL_Flies.T4D(:,:,R);

Conditions_Cmp.Control.ON.T4T5_mb=Conditions_Cmp.Control.ON.T4T5_mb(R);
Conditions_Cmp.Control.OFF.T4T5_mb=Conditions_Cmp.Control.OFF.T4T5_mb(R);


Conditions_Cmp.Control.OFF.Z= averageDirectionVectors(Conditions_Cmp.Control.OFF.T4T5_mb);
Conditions_Cmp.Control.ON.Z= averageDirectionVectors(Conditions_Cmp.Control.ON.T4T5_mb);
Conditions_Cmp.C2Silence.OFF.Z= averageDirectionVectors(Conditions_Cmp.C2Silence.OFF.T4T5_mb);
Conditions_Cmp.C2Silence.ON.Z= averageDirectionVectors(Conditions_Cmp.C2Silence.ON.T4T5_mb);
Conditions_Cmp.C3Silence.OFF.Z= averageDirectionVectors(Conditions_Cmp.C3Silence.OFF.T4T5_mb);
Conditions_Cmp.C3Silence.ON.Z= averageDirectionVectors(Conditions_Cmp.C3Silence.ON.T4T5_mb);
Conditions_Cmp.C2C3Silence.OFF.Z= averageDirectionVectors(Conditions_Cmp.C2C3Silence.OFF.T4T5_mb);
Conditions_Cmp.C2C3Silence.ON.Z= averageDirectionVectors(Conditions_Cmp.C2C3Silence.ON.T4T5_mb);

% Since I still have too many ROIs for the Control Condition I need to
% reduce even more! This I can only do for the Z for all Flies! 

% Conditions_Cmp.Control.OFF.Z= reduceSampleSize(Conditions_Cmp.Control.OFF.Z,0.7);
% Conditions_Cmp.Control.ON.Z= reduceSampleSize(Conditions_Cmp.Control.ON.Z,0.5);
% % % 


%% Polar Plots (not in Manuscript)

for N=1:Ncon 
    CONi=CON{N}; 
    ConditionI=eval(['Conditions_Cmp.',CONi]);
F1= Plot_Polar_Plot(ConditionI.ON,ConditionI.OFF,true);
subplot(1,2,1)
title([CONi, ' (NFlies', num2str(size(ConditionI.OFF.ALL_Flies.T5B,3)),') : T5 responses to Dark Stripes']); 
set(F1,'PaperSize', [8 8]) 

end 


%% Compass Plots (Fig. 6a)

for N=1:Ncon 
    CONi=CON{N}; 
    ConditionI=eval(['Conditions_Cmp.',CONi]);
    
Average=false; 
[F1]=CompassPlot_reducedN(ConditionI.ON,ConditionI.OFF,CONi,Average);


end



%% Length of the Vector (DSI)
%Fig. 6b und Suppl. Fig.4 


Average=true;
[F6,F7]=PlotBoxPlots_VS(Conditions_Cmp,Average);



%% Plot ND vs PD 
%Fig. 6c

Plot_allresp_relative(Conditions_Cmp)


