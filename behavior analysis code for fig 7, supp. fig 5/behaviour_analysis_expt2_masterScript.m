%% Analysis of C2 and C3 silencing data to plot the figures for Henning et al 2023: Fig 7e, 7f, 7i
% Expt 2: (C2) response recovery between paired ON edges
% Pls specify path details on the lines 6-7 and genotype on line 14.
%% specify paths
clearvars
addpath(genpath(['your path','\behavior analysis code'])) % code path
rawDataPath=['your path','\Raw data\']; %this is not part of the github repository. pls contact authors
pDataPath=['your path','\Data\Behavior data for figure 7, supp.fig 5\'];

%% Primary analysis (requires raw data from authors)
% Use this section to analyse the raw data and plot time traces (panels 7e,h) of one genotype 
% and stimulus duration at a time.
% Further analysis below loads pre-stored pdata.
genotype='Shi[ts]_control'; % Shi[ts]_control,C2split-shi[ts],C2split Gal4 control
%identical to the folder names in the raw data folder
edgeDur='500ms'; %750ms or 500ms
dirPath=[rawDataPath, genotype, '\'];

if strcmp(genotype,'Shi[ts]_control') && strcmp(edgeDur,'750ms')
   flies={'210218mk_fly2e','210219mk_fly1d','210222mk_fly1c','210222mk_fly2b','210301mk_fly1f',...
          '210301mk_fly3c','210520mk_fly4f','210526mk_fly2c','210527mk_fly1c','210529mk_fly1c'}; %UAS-shi[ts], 750 ms
         %discarded:{'210218mk_fly3(flat)','210219mk_fly3f(late)'};
elseif strcmp(genotype,'Shi[ts]_control') && strcmp(edgeDur,'500ms')
   flies={'210222mk_fly1d','210301mk_fly1d','210301mk_fly3b','210520mk_fly4b','210526mk_fly2b',...
          '210527mk_fly1','210529mk_fly1f','210603mk_fly2d','210630mk_fly4','210630mk_fly5c'}; %UAS-shi[ts], 500 ms
elseif strcmp(genotype,'C2split-shi[ts]')&& strcmp(edgeDur,'750ms')
   flies={'210220mk_fly1d','210220mk_fly2c','210221mk_fly1h','210301mk_fly4','210329mk_fly1b',...
          '210330mk_fly1','210515mk_fly1d','210515mk_fly2e','210520mk_fly1','210526mk_fly1e'}; %c2split-shi[ts],750 ms
         %discarded: {'210309mk_fly4(contam)','210329mk_fly3c(contam)','210330mk_fly2(slow)'}
elseif strcmp(genotype,'C2split-shi[ts]')&& strcmp(edgeDur,'500ms')
   flies={'210220mk_fly1e','210220mk_fly2','210221mk_fly1f','210301mk_fly4c','210329mk_fly1e',...
          '210330mk_fly1c','210515mk_fly1c','210515mk_fly2b','210520mk_fly1b','210526mk_fly1c'}; %c2split-shi[ts],500 ms
         %discarded: {'210309mk_fly4d(contam)','210326mk_fly4d(contam)','210329mk_fly3e(contam)',...
                     %'210330mk_fly2b/c(no settling)','210515mk_fly3c(slow)'};
elseif strcmp(genotype,'C2split Gal4 control') && strcmp(edgeDur,'750ms')
   flies={'210308mk_fly4','210308mk_fly5b','210309mk_fly2b','210309mk_fly3','210519mk_fly1e',...
          '210519mk_fly2b','210520mk_fly2c','210520mk_fly3c','210530mk_fly1c','210530mk_fly3'}; %C2split Gal4 control,750 ms
         %discarded: {'210331mk_fly1(possibly contam)'};
elseif strcmp(genotype,'C2split Gal4 control') && strcmp(edgeDur,'500ms')
   flies={'210308mk_fly4c','210308mk_fly5c','210309mk_fly3d','210519mk_fly1d','210519mk_fly2c',...
          '210520mk_fly2b','210520mk_fly3d','210530mk_fly1d','210530mk_fly3e','210530mk_fly4b'}; %C2split Gal4 control,500 ms
         %discarded: {'210331mk_fly1b(contam)','210530mk_fly2(neg turn)'};
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
timing = [0.2 2.5]; %0.2s before onset, 2.5 after onset (to cut the traces around stim)

% patterns-functions pairs (later used for metadata processing)
patterns={({'Pattern_onEdges_r_96_0to1.mat','Pattern_onEdges_l_96_0to1.mat'})};
posfuncs={({'amp96_ang240','amp96_ang240'})};

% process data and metadata together and plot
pdata=process_stimuli_mk(data,timing,patterns,posfuncs,dirPath,metaFlies);
%this is pre-saved in the processed data folder.

if strcmp(edgeDur,'750ms')
    plot_pdata_traces_2xEdge_750ms(pdata,genotype,{'ON 2x, 750ms'});
elseif strcmp(edgeDur,'500ms')
    plot_pdata_traces_2xEdge_500ms(pdata,genotype,{'ON 2x, 500ms'});
end
% Figures show either mean+SEM over flies (used in final figure),
% or mean+SEM over all stimulus instances, or average for each fly.

%% calculate percentage recovery for 750ms edges (Fig 7f) (data included in this repository)
% load data 
load([pDataPath,'UAS_shi_ON_singleEdge2x_0to1_ND0.9_750ms.mat'])
shi=pdata;
load([pDataPath,'C2split_Gal4_ON_singleEdge2x_0to1_ND0.9_750ms.mat'])
Gal4=pdata;
load([pDataPath,'C2split_shi_ON_singleEdge2x_0to1_ND0.9_750ms.mat'])
C2=pdata;

% extract the highest speed in the first dur and lowest speed between 0.75 and 1 s. 
% Avg 8 speeds for each.
% since each genotype has same #flies, unique matrices would work. Order: shi, Gal4, C2.
dataset={shi,Gal4,C2};
peakVelsperFly=zeros(size(shi,2),3);
lowestVelsperFly=zeros(size(shi,2),3);
for iGeno=1:3
    data=dataset{iGeno};
    for iFly=1:length(data)
        meanTrace=mean(data(iFly).pdata.acc_dtheta{1},1);
        dataSorted1=sort(meanTrace(round((0.7)*120):round((0.75+0.7)*120)),2,'descend');
        peakVelsperFly(iFly,iGeno)=mean(dataSorted1(:,1:8),2);
        dataSorted2=sort(meanTrace(round((0.75+0.7)*120):round((1+0.7)*120)),2,'descend');
        lowestVelsperFly(iFly,iGeno)=mean(dataSorted2(:,end-7:end),2);
    end
end
recovery=(peakVelsperFly-lowestVelsperFly)*100./peakVelsperFly;
meanRecovery09_750=mean(recovery,1)';
semRecovery09_750=std(recovery)/sqrt(size(recovery,1))';

%statistics
[hShi,pShi]=ttest2(recovery(:,1),recovery(:,3));
[hGal4,pGal4]=ttest2(recovery(:,2),recovery(:,3));
% pShi=0.0060, pGal4=0.0033 (<0.01)

% plot
figure; hold on
bar([1,2,3],mean(recovery,1))
errorbar([1,2,3],mean(recovery,1),std(recovery)/sqrt(size(recovery,1)),'.')
xticks(1:3);
yticks(0:50:150);
xticklabels({'UAS-shi/+', 'C2-Gal4/+', 'C2>>shi'});
ylabel('recovery (%)')
title('Recovery from the first response: 750 ms')
% ylim([-3 0.5])
text(3,100,'**')

%% calculate percentage recovery for 500ms edges (Fig 7i) (data included in this repository)
% load data 
load([pDataPath,'UAS_shi_ON_singleEdge2x_0to1_ND0.9_500ms.mat'])
shi=pdata;
load([pDataPath,'C2split_Gal4_ON_singleEdge2x_0to1_ND0.9_500ms.mat'])
Gal4=pdata;
load([pDataPath,'C2split_shi_ON_singleEdge2x_0to1_ND0.9_500ms.mat'])
C2=pdata;

% extract the highest speed in the first dur and lowest speed between 0.5 and 1 s. 
% Avg 8 speeds for each.
% since each genotype has same #flies, unique matrices would work. Order: shi, Gal4, C2.
dataset={shi,Gal4,C2};
peakVelsperFly=zeros(size(shi,2),3);
lowestVelsperFly=zeros(size(shi,2),3);
for iGeno=1:3
    data=dataset{iGeno};
    for iFly=1:length(data)
        meanTrace=mean(data(iFly).pdata.acc_dtheta{1},1);
        dataSorted1=sort(meanTrace(round((0.7)*120):round((0.5+0.7)*120)),2,'descend');
        peakVelsperFly(iFly,iGeno)=mean(dataSorted1(:,1:8),2);
        dataSorted2=sort(meanTrace(round((0.5+0.7)*120):round((1+0.7)*120)),2,'descend');
        lowestVelsperFly(iFly,iGeno)=mean(dataSorted2(:,end-7:end),2);
    end
end
recovery=(peakVelsperFly-lowestVelsperFly)*100./peakVelsperFly;
meanRecovery09_500=mean(recovery,1)';
semRecovery09_500=std(recovery)/sqrt(size(recovery,1))';

% statistics
[hShi,pShi]=ttest2(recovery(:,1),recovery(:,3));
[hGal4,pGal4]=ttest2(recovery(:,2),recovery(:,3));
% pShi=0.0079, pGal4=5.0755e-06 (<0.01)

% plot
figure; hold on
bar([1,2,3],mean(recovery,1))
errorbar([1,2,3],mean(recovery,1),std(recovery)/sqrt(size(recovery,1)),'.')
% scatter([ones(size(recovery,1),1); 2*ones(size(recovery,1),1); 3*ones(size(recovery,1),1)],...
%     reshape(recovery,[size(recovery,1)*size(recovery,2),1]));
xticks(1:3);
% yticks(-3:0);
xticklabels({'UAS-shi/+', 'C2-Gal4/+', 'C2>>shi'});
ylabel('recovery (%)')
title('Recovery from the first response:500ms')
% ylim([-3 0.5])
text(3,50,'**')