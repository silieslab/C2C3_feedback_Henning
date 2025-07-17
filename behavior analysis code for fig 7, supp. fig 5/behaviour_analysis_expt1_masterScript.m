%% Analysis of C2 and C3 silencing data to plot the figures for Henning et al 2023: Fig 7b, 7c, supp. Fig 5b, 5c
% Expt 1: dynamics of turning response to a single ON edge
% Pls specify path details on the lines 6-8 and specify genotype on line 13.
%% specify paths
clearvars
addpath(genpath(['your path','\behavior analysis code'])) % code path
rawDataPath=['your path','\Raw data\']; %this is not part of the github repository. pls contact authors
pDataPath=['your path','\Data\Behavior data for figure 7, supp.fig 5\'];

%% Primary analysis (requires raw data from authors)
% Use this section to analyse the raw data and plot time traces (figure 7b or supp. fig 5b) of one genotype at a time.
% Further analysis below loads pre-stored pdata.
genotype='Shi[ts]_control'; % Shi[ts]_control,C2split-shi[ts],C3slit-shi[ts],C2split Gal4 control,C3split Gal4 control
%identical to the folder names in the raw data folder

dirPath=[rawDataPath, genotype, '\'];

if strcmp(genotype,'Shi[ts]_control')
   flies={'200120mk_Fly3f','200121mk_Fly3e','200121mk_Fly4e','200121mk_Fly5d','200122mk_Fly1c',...
          '200122mk_Fly2b','200130mk_Fly1f','200130mk_Fly3d','200211mk_Fly1c','200211mk_Fly2',...
          '200211mk_Fly3b','200420mk_Fly2','200421mk_Fly1','200421mk_Fly2b','200426mk_Fly1f'}; %UAS-shi[ts]
         %discarded:{'200422mk_Fly1d/f/g(all negTurn)','200426mk_Fly2d(negTurn)','200426mk_Fly3f (negTurn)'}
elseif strcmp(genotype,'C2split-shi[ts]')
   flies={'200124mk_Fly1','200124mk_Fly2c','200124mk_Fly3','200126mk_Fly1b','200206mk_Fly2d',...
          '200206mk_Fly3','200206mk_Fly5','200214mk_Fly1','200417mk_Fly1b','200417mk_Fly1f',...
          '200420mk_Fly3f','200427mk_Fly4b'};%c2split-shi[ts],positive corr
         %discarded for negative corr: {'200126mk_Fly2b','200206mk_Fly1b','200206mk_Fly4c',...
           %'200207mk_Fly1','200417mk_Fly2/2b','200427mk_Fly3f','200427mk_Fly5d'}
elseif strcmp(genotype,'C2split Gal4 control')
   flies={'200203mk_Fly2','200204mk_Fly1d','200218mk_Fly2b','200218mk_Fly4c','200218mk_Fly5b',...
          '200218mk_Fly6d','200218mk_Fly7c','200219mk_Fly3b','200220mk_Fly3c','200228mk_Fly1',...
          '200228mk_Fly3c','200218mk_Fly1d','200218mk_Fly3','200219mk_Fly1d','200219mk_Fly2d',...
          '200219mk_Fly4c','200220mk_Fly1c','200220mk_Fly2c'}; %C2split Gal4 control,positive corr
         %discarded for negative corr etc.:{'200219mk_Fly1b','200219mk_Fly1c','200219mk_Fly2',...
           %'200220mk_Fly1b','200228mk_Fly2'}; 
elseif strcmp(genotype,'C3split-shi[ts]')
    flies={'200127mk_Fly1','200127mk_Fly2b','200210mk_Fly1c','200210mk_Fly2b','200210mk_Fly3b',...
           '200210mk_Fly4','200210mk_Fly5b','200305mk_Fly3','200306mk_Fly1','200306mk_Fly2d','200306mk_Fly3c',...
           '200306mk_Fly5c','200309mk_Fly1c','200309mk_Fly2c','200309mk_Fly4d','200312mk_Fly1b'}; %c3split-shi[ts]
          %discarded:{'200127mk_Fly3 (started %flying)','200309mk_Fly3b/d(low speed)'}
elseif strcmp(genotype,'C3split Gal4 control')
    flies={'200228mk_Fly4b','200228mk_Fly5','200228mk_Fly6b','200302mk_Fly1b','200302mk_Fly2c',...
           '200303mk_Fly1','200303mk_Fly2d','200303mk_Fly3b','200303mk_Fly4c','200303mk_Fly5c',...
           '200305mk_Fly1d','200305mk_Fly2','200310mk_Fly1d'}; %c3split Gal4 control
          %discarded:{'200303mk_Fly6b (low speed)'};
end

% load and read raw data
cd(dirPath)
% read main datafiles
for iFly=1:length(flies)
    data(iFly)=read_data_files_new_mk([flies{iFly},'.txt']);
end
% make a metadata file structure
metaFlies=dir([flies{1},'.mat']);
for i=2:length(flies)
    metaFlies=[metaFlies;dir([flies{i},'.mat'])];
end

% specify time points with respect to the static stimulus onset. Motion starts at 0.5s
timing = [0.2 2.3]; %0.2s before onset, 2.3 after onset (to cut the traces around stim)

% patterns-functions pairs (later used for metadata processing)
patterns={({'Pattern_onEdges_r_96_0to1.mat','Pattern_onEdges_l_96_0to1.mat'})};
posfuncs={({'amp96_ang192','amp96_ang192'})};

%the fllowing pair was tested in the same experiment but the single ON was more informative
% patterns={({'Pattern_onEdges_r_24_complete_0to1.mat','Pattern_onEdges_l_24_complete_0to1.mat'})};
% posfuncs={({'amp24_ang160','amp24_ang160'})};

% process data and metadata together and plot
pdata=process_stimuli_mk(data,timing,patterns,posfuncs,dirPath,metaFlies);
%this is pre-saved in the processed data folder.

plot_pdata_traces(pdata,genotype,{'ON single edge'});
% Figures show either mean+SEM over flies (used in the final figure),
% or mean+SEM over all stimulus instances, or average for each fly.

%% calculate turning deceleration aka slopes for C2 (Fig. 7c) (data included in this repository)
% load pdata
load([pDataPath,'UAS_shi_ON_single_0to1_ND0.9.mat'])
shi=pdata;
load([pDataPath,'C2split_Gal4_ON_singleEdge_0to1_ND0.9_positiveCorr.mat'])
Gal4=pdata;
load([pDataPath,'C2split_shi_ON_singleEdge_0to1_ND0.9_positiveCorr.mat'])
C2=pdata;

% fit straight lines to the decaying phases of individual fly mean traces
% in the interval 0.45(peak happens between 0.4-0.43) to 0.75
shiSlopes=[];
% fig1=figure;
for iFly=1:length(shi)
    dataToFit=shi(iFly).pdata.acc_dtheta{1}(:,round((0.45+0.7)*120):round((0.75+0.7)*120));
    y=mean(dataToFit,1);
    x=[1:length(y)]/120;
    f=fit(x',y','poly1');
    shiSlopes=[shiSlopes; f.p1];
    
    %quality control
%     figure(fig1); subplot(3,length(shi)/3,iFly);
%     plot(f,x,y);
%     legend off
end

Gal4Slopes=[];
% fig2=figure;
for iFly=1:length(Gal4)
    dataToFit=Gal4(iFly).pdata.acc_dtheta{1}(:,round((0.45+0.7)*120):round((0.75+0.7)*120));
    y=mean(dataToFit,1);
    x=[1:length(y)]/120;
    f=fit(x',y','poly1');
    Gal4Slopes=[Gal4Slopes; f.p1];
    
    %quality control
%     figure(fig2); subplot(3,length(Gal4)/3,iFly);
%     plot(f,x,y);
%     legend off
end

C2Slopes=[];
% fig3=figure;
for iFly=1:length(C2)
    dataToFit=C2(iFly).pdata.acc_dtheta{1}(:,round((0.45+0.7)*120):round((0.75+0.7)*120));
    y=mean(dataToFit,1);
    x=[1:length(y)]/120;
    f=fit(x',y','poly1');
    C2Slopes=[C2Slopes; f.p1];
    
    %quality control
%     figure(fig3); subplot(3,length(C2)/3,iFly);
%     plot(f,x,y);
%     legend off
end

% statistics on the slopes
[hShi,pShi]=ttest2(shiSlopes,C2Slopes);
[hGal4,pGal4]=ttest2(Gal4Slopes,C2Slopes);

%% bar plot of the slopes
figure; hold on
bar([1,2,3],[mean(shiSlopes), mean(Gal4Slopes), mean(C2Slopes)])
errorbar([1,2,3],[mean(shiSlopes), mean(Gal4Slopes), mean(C2Slopes)],...
    [std(shiSlopes)/sqrt(length(shi)), std(Gal4Slopes)/sqrt(length(Gal4)), std(C2Slopes)/sqrt(length(C2))],'.')
xticks(1:3);
yticks(-3:0);
xticklabels({'UAS-shi/+', 'C2-Gal4/+', 'C2>>shi'});
ylabel('turning decelration (rad/s^2)')
title('Decay slopes')
ylim([-3 0.5])
text(3,-1,'*')

%% calculate turning deceleration aka slopes for C3 (supp. Fig 7c) (data included in this repository)
% load pdata
load([pDataPath,'UAS_shi_ON_single_0to1_ND0.9.mat'])
shi=pdata;
load([pDataPath,'C3split_Gal4_ON_singleEdge_0to1_ND0.9.mat'])
Gal4=pdata;
load([pDataPath,'C3split_shi_ON_singleEdge_0to1_ND0.9.mat'])
C3=pdata;

% fit straight lines to the decaying phases of individual fly mean traces
% in the interval 0.45(peak happens between 0.4-0.43) to 0.75
shiSlopes=[];
for iFly=1:length(shi)
    dataToFit=shi(iFly).pdata.acc_dtheta{1}(:,round((0.45+0.7)*120):round((0.75+0.7)*120));
    y=mean(dataToFit,1);
    x=[1:length(y)]/120;
    f=fit(x',y','poly1');
    shiSlopes=[shiSlopes; f.p1];
    
end

Gal4Slopes=[];
for iFly=1:length(Gal4)
    dataToFit=Gal4(iFly).pdata.acc_dtheta{1}(:,round((0.45+0.7)*120):round((0.75+0.7)*120));
    y=mean(dataToFit,1);
    x=[1:length(y)]/120;
    f=fit(x',y','poly1');
    Gal4Slopes=[Gal4Slopes; f.p1];
    
end

C3Slopes=[];
for iFly=1:length(C3)
    dataToFit=C3(iFly).pdata.acc_dtheta{1}(:,round((0.45+0.7)*120):round((0.75+0.7)*120));
    y=mean(dataToFit,1);
    x=[1:length(y)]/120;
    f=fit(x',y','poly1');
    C3Slopes=[C3Slopes; f.p1];
    
end

% statistics on the slopes
[hShi,pShi]=ttest2(shiSlopes,C3Slopes);
[hGal4,pGal4]=ttest2(Gal4Slopes,C3Slopes);

%% bar plot of the slopes
figure; hold on
bar([1,2,3],[mean(shiSlopes), mean(Gal4Slopes), mean(C3Slopes)])
errorbar([1,2,3],[mean(shiSlopes), mean(Gal4Slopes), mean(C3Slopes)],...
    [std(shiSlopes)/sqrt(length(shi)), std(Gal4Slopes)/sqrt(length(Gal4)), std(C3Slopes)/sqrt(length(C2))],'.')
xticks(1:3);
yticks(-3:0);
xticklabels({'UAS-shi/+', 'C3-Gal4/+', 'C3>>shi'});
ylabel('turning decelration (rad/s^2)')
title('Decay slopes')
ylim([-3 0.5])