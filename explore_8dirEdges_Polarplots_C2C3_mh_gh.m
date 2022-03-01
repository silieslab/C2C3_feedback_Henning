% explore_Edges_Polarplots
% with data from manually drawn ROIs
% loads data saved before using the explore_Edges.m function 
% plots the polar plots for responses to 4dir edge stimulus 

close all
clear all
clc

addpath(genpath('subscripts'))


Conditions={'C2','C3'};



C2=load('Data/DSData/processed_Data_manualROIs_C2');
C3=load('Data/DSData/processed_Data_manualROIs_C3');

%%

Color=[0.75 0 0.75;0 .5 0];    


onedeg=2*pi/360; %in rad 
% theta=[90, 0,  270,  180,  90];
theta=[90, 45, 0, 315, 270, 225, 180, 135, 90];

theta=theta*onedeg;

%% Extract response peaks to every direction for the OFF and ON edge 
NFl=[];
nDir=8; %Number of directions of movement 
% NCon=2; %Number of Contrasts (here Only ON and OFF) 

for NCon=1:length(Conditions)
    COND=eval(Conditions{NCon}); 
    
        C2C3=COND.C2C3_Me1_agg.MeanOF_Cells;
  
        OFF=max(C2C3(:,:,1:40),[],3);
        ON=max(C2C3(:,:,41:80),[],3);

   % Polar Plot-responses to ON Edge     
  
       F1= figure(1);
       set(F1,'Color', [1 1 1],'Position', [400 400 800 400]);
        subplot(1,2,1)
        P = polar(theta, 1 * ones(size(theta)));
        set(P, 'Visible', 'off')
        hold on 

        tuningPdirPFly=ON; %tuning (strength of response) per direction and per fly
        mtuningPdir=nanmean(tuningPdirPFly,1);
        stuningPdir=nanstd(tuningPdirPFly)/sqrt(length(tuningPdirPFly));
        rho=[mtuningPdir,mtuningPdir(1)]';
        PPp=polar(theta,rho');
        PPp.Color=Color(NCon,:);
        hold on ; i=1;
        PolarPlot_std_new
     
        [PPp.LineWidth] = deal(1.5);

        set(gca,'YTickLabel','')
        set(gca,'FontSize',13)


        
        
         % Polar Plot-responses to OFF Edge     
       
        subplot(1,2,2)
        P = polar(theta, 1 * ones(size(theta)));
        set(P, 'Visible', 'off')
        hold on 

        tuningPdirPFly=OFF; %tuning (strength of response) per direction and per fly
        mtuningPdir=nanmean(tuningPdirPFly,1);
        stuningPdir=nanstd(tuningPdirPFly)/sqrt(length(tuningPdirPFly));
        rho=[mtuningPdir,mtuningPdir(1)]';
        PPp=polar(theta,rho');
        PPp.Color=Color(NCon,:)
        hold on 
        
        
        for ii=1:length(theta)-1
            e=stuningPdir(ii);
            m=mtuningPdir(ii);
            angle2=theta(ii);
            P=polar([angle2 angle2], [m-e, m+e]);
            P.Color=Color(NCon,:);
        end 
        
 
        [PPp.LineWidth] = deal(1.5)

        set(gca,'YTickLabel','')
        set(gca,'FontSize',13)


        NFl(NCon)=size(C2C3,1);

end

subplot(1,2,1)
title(['Responses to OFF Edge']);
hold on
text(1, 1.2,['C2 ( N= ', num2str(NFl(1)),')'], 'Color', [0.75 0 0.75],'FontSize',15)
text(1, 1, ['C3 ( N= ', num2str(NFl(2)),')'], 'Color', [0 .5 0],'FontSize',15)


subplot(1,2,2)
title(['Responses to ON Edge']);


