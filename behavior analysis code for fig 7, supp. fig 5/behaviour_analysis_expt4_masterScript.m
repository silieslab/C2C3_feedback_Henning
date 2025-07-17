%% Analysis of C2 and C3 silencing data to plot the figures for Henning et al 2023: Fig 7f-k
% Expt 4: (C2) response recovery as a function of absolute luminance alone.
% Pls specify path details on the lines 6-8 and genotype on line 14.
%% specify paths
clearvars
addpath(genpath(['your path','\behavior analysis code'])) % code path
rawDataPath=['your path','\Raw data\']; %this is not part of the github repository. pls contact authors
pDataPath=['your path','\Data\Behavior data for figure 7, supp.fig 5\'];

%% Primary analysis (requires raw data from authors)
% Use this section to analyse the raw data and plot time traces (panels of supp. 7) of one genotype, 
% one ND filter and one stimulus duration at a time.
% Further analysis below loads pre-stored pdata.
genotype='Shi[ts]_control'; % Shi[ts]_control,C2split-shi[ts],C2split Gal4 control
%identical to the folder names in the raw data folder
edgeDur='750ms'; %750ms or 500ms
filter='ND1.8'; % ND1.8 or ND2.7
dirPath=[rawDataPath, genotype, '\'];

if strcmp(genotype,'Shi[ts]_control') && strcmp(edgeDur,'750ms') && strcmp(filter,'ND1.8')
   flies={'221111mk_fly1e','221111mk_fly2c','221111mk_fly3g','221117mk_fly1c','221117mk_fly2',...
          '221119mk_fly2','221122mk_fly4g','221122mk_fly5b'}; %UAS-shi[ts], 750 ms
elseif strcmp(genotype,'Shi[ts]_control') && strcmp(edgeDur,'500ms') && strcmp(filter,'ND1.8')
   flies={'221111mk_fly1k','221111mk_fly2d','221111mk_fly3b','221117mk_fly1b','221117mk_fly2b',...
          '221122mk_fly4h','221122mk_fly5f'}; %UAS-shi[ts], 500 ms
         %discarded: {'221119mk_fly2b(slow)'};
elseif strcmp(genotype,'C2split-shi[ts]')&& strcmp(edgeDur,'750ms') && strcmp(filter,'ND1.8')
   flies={'221110mk_fly2g','221110mk_fly3','221110mk_fly4c','221116mk_fly1e','221116mk_fly2',...
          '221117mk_fly3e','221122mk_fly1d','221122mk_fly3'}; %c2split-shi[ts],750 ms
         %discarded: {'221122mk_fly2f(slow)'};
elseif strcmp(genotype,'C2split-shi[ts]')&& strcmp(edgeDur,'500ms') && strcmp(filter,'ND1.8')
   flies={'221110mk_fly2f','221110mk_fly3b','221110mk_fly4b','221116mk_fly1','221116mk_fly2b',...
          '221117mk_fly3b','221122mk_fly1e','221122mk_fly2b','221122mk_fly3b'}; %c2split-shi[ts],500 ms
elseif strcmp(genotype,'C2split Gal4 control') && strcmp(edgeDur,'750ms') && strcmp(filter,'ND1.8')
   flies={'221109mk_fly1','221109mk_fly2c','221109mk_fly3','221109mk_fly4d','221109mk_fly5',...
          '221116mk_fly3c','221116mk_fly4','221116mk_fly5','221124mk_fly1d'}; %C2split Gal4 control,750 ms
elseif strcmp(genotype,'C2split Gal4 control') && strcmp(edgeDur,'500ms') && strcmp(filter,'ND1.8')
   flies={'221109mk_fly1b','221109mk_fly2d','221109mk_fly3b','221109mk_fly4c','221109mk_fly5b',...
          '221116mk_fly3d','221116mk_fly4h','221116mk_fly5b','221124mk_fly1e'}; %C2split Gal4 control,500 ms
         %discarded: {'221124mk_fly2e(slow)'};
elseif strcmp(genotype,'Shi[ts]_control') && strcmp(edgeDur,'750ms') && strcmp(filter,'ND2.7')
   flies={'221111mk_fly1d','221111mk_fly2f','221111mk_fly3f','221117mk_fly1d','221117mk_fly2d',...
          '221122mk_fly4d','221122mk_fly5e'}; %no fly ran positively for this condition for some reason
elseif strcmp(genotype,'Shi[ts]_control') && strcmp(edgeDur,'500ms') && strcmp(filter,'ND2.7')
   flies={'221111mk_fly1g','221111mk_fly2e','221111mk_fly3e','221117mk_fly1g','221117mk_fly2e',...
          '221122mk_fly4e','221122mk_fly5d'}; %UAS-shi[ts], 500 ms
elseif strcmp(genotype,'C2split-shi[ts]')&& strcmp(edgeDur,'750ms') && strcmp(filter,'ND2.7')
   flies={'221110mk_fly2d','221110mk_fly3d','221110mk_fly4d','221116mk_fly1g','221116mk_fly2d',...
          '221117mk_fly3f','221122mk_fly1g','221122mk_fly2c','221122mk_fly3e'}; %c2split-shi[ts],750 ms
elseif strcmp(genotype,'C2split-shi[ts]')&& strcmp(edgeDur,'500ms') && strcmp(filter,'ND2.7')
   flies={'221110mk_fly2c','221110mk_fly3e','221110mk_fly4e','221116mk_fly1h','221116mk_fly2c',...
        '221117mk_fly3c','221122mk_fly1c','221122mk_fly2d','221122mk_fly3c'}; %c2split-shi[ts],500 ms
elseif strcmp(genotype,'C2split Gal4 control') && strcmp(edgeDur,'750ms') && strcmp(filter,'ND2.7')
   flies={'221109mk_fly1e','221109mk_fly2f','221109mk_fly3d','221109mk_fly5d','221116mk_fly3f',...
          '221116mk_fly5d','221124mk_fly1f','221124mk_fly2c','221208mk_fly1b'}; %C2split Gal4 control,750 ms
         %discarded: {'221116mk_fly4e(flat)'};
elseif strcmp(genotype,'C2split Gal4 control') && strcmp(edgeDur,'500ms') && strcmp(filter,'ND2.7')
   flies={'221109mk_fly1c','221109mk_fly2','221109mk_fly3c','221109mk_fly5c','221116mk_fly3e',...
          '221116mk_fly5c','221124mk_fly1b','221124mk_fly2d','221208mk_fly1f'}; %C2split Gal4 control,500 ms
         %discarded: {'221116mk_fly4d/f(flat)'};
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

%% calculate percentage recovery (Fig 7f,i; 7j,k left) (data included in this repository)
% for ND 0.9 data that was recorded before as well as for new NDs
%% first for 750 ms, then for 500 ms in the same loop
allFilters={'ND0.9','ND1.8','ND2.7'};
meanRecovery750=zeros(3,length(allFilters));
semRecovery750=zeros(3,length(allFilters));
meanRecovery500=zeros(3,length(allFilters));
semRecovery500=zeros(3,length(allFilters));
for iND=1:length(allFilters)
    % load data
    load([pDataPath,'UAS_shi_ON_singleEdge2x_0to1_',allFilters{iND},'_750ms.mat'])
    shi=pdata;
    load([pDataPath,'C2split_Gal4_ON_singleEdge2x_0to1_',allFilters{iND},'_750ms.mat'])
    Gal4=pdata;
    load([pDataPath,'C2split_shi_ON_singleEdge2x_0to1_',allFilters{iND},'_750ms.mat'])
    C2=pdata;

    % extract the highest speed in the first dur and lowest speed between 0.75 and 1 s. 
    % Avg 8 speeds for each.
    % since different genotypes have different #flies, use cell. Order: shi, Gal4, C2.
    dataset={shi,Gal4,C2};
    peakVelsperFly=cell(1,3);
    lowestVelsperFly=cell(1,3);
    recoveryperFly=cell(1,3);
    for iGeno=1:3
        data=dataset{iGeno};
        peakVelsperFly{iGeno}=zeros(size(data,2),1);
        lowestVelsperFly{iGeno}=zeros(size(data,2),1);
        recoveryperFly{iGeno}=zeros(size(data,2),1);
        for iFly=1:length(data)
            meanTrace=mean(data(iFly).pdata.acc_dtheta{1},1);
            dataSorted1=sort(meanTrace(round((0.7)*120):round((0.75+0.7)*120)),2,'descend');
            peakVelsperFly{iGeno}(iFly)=mean(dataSorted1(:,1:8),2);
            dataSorted2=sort(meanTrace(round((0.75+0.7)*120):round((1+0.7)*120)),2,'descend');
            lowestVelsperFly{iGeno}(iFly)=mean(dataSorted2(:,end-7:end),2);
        end
        recoveryperFly{iGeno}=(peakVelsperFly{iGeno}-lowestVelsperFly{iGeno})*100./peakVelsperFly{iGeno};
        meanRecovery750(iGeno,iND)=mean(recoveryperFly{iGeno});
        semRecovery750(iGeno,iND)=std(recoveryperFly{iGeno})/sqrt(length(recoveryperFly{iGeno}));
    end

    %statistics (only for manual observaion)
    [hShi,pShi]=ttest2(recoveryperFly{1},recoveryperFly{3})
    [hGal4,pGal4]=ttest2(recoveryperFly{2},recoveryperFly{3})

    % plot
    figure; hold on
    bar([1,2,3],meanRecovery750(:,iND))
    errorbar([1,2,3],meanRecovery750(:,iND),semRecovery750(:,iND),'.')
    xticks(1:3);
    yticks(0:50:150);
    xticklabels({'UAS-shi/+', 'C2-Gal4/+', 'C2>>shi'});
    ylabel('recovery (%)')
    title(['Recovery from the first response: 750 ms, ',allFilters{iND}])
    % ylim([-3 0.5])

    % for 500 ms
    % load data 
    load([pDataPath,'UAS_shi_ON_singleEdge2x_0to1_',allFilters{iND},'_500ms.mat'])
    shi=pdata;
    load([pDataPath,'C2split_Gal4_ON_singleEdge2x_0to1_',allFilters{iND},'_500ms.mat'])
    Gal4=pdata;
    load([pDataPath,'C2split_shi_ON_singleEdge2x_0to1_',allFilters{iND},'_500ms.mat'])
    C2=pdata;

    % extract the highest speed in the first dur and lowest speed between 0.5 and 1 s. 
    % Avg 8 speeds for each.
    % since different genotypes have different #flies, use cell. Order: shi, Gal4, C2.
    dataset={shi,Gal4,C2};
    peakVelsperFly=cell(1,3);
    lowestVelsperFly=cell(1,3);
    recoveryperFly=cell(1,3);
    for iGeno=1:3
        data=dataset{iGeno};
        peakVelsperFly{iGeno}=zeros(size(data,2),1);
        lowestVelsperFly{iGeno}=zeros(size(data,2),1);
        recoveryperFly{iGeno}=zeros(size(data,2),1);
        for iFly=1:length(data)
            meanTrace=mean(data(iFly).pdata.acc_dtheta{1},1);
            dataSorted1=sort(meanTrace(round((0.7)*120):round((0.5+0.7)*120)),2,'descend');
            peakVelsperFly{iGeno}(iFly)=mean(dataSorted1(:,1:8),2);
            dataSorted2=sort(meanTrace(round((0.5+0.7)*120):round((1+0.7)*120)),2,'descend');
            lowestVelsperFly{iGeno}(iFly)=mean(dataSorted2(:,end-7:end),2);
        end
        recoveryperFly{iGeno}=(peakVelsperFly{iGeno}-lowestVelsperFly{iGeno})*100./peakVelsperFly{iGeno};
        meanRecovery500(iGeno,iND)=mean(recoveryperFly{iGeno});
        semRecovery500(iGeno,iND)=std(recoveryperFly{iGeno})/sqrt(length(recoveryperFly{iGeno}));
    end

    % statistics (only for manual observaion)
    [hShi,pShi]=ttest2(recoveryperFly{1},recoveryperFly{3})
    [hGal4,pGal4]=ttest2(recoveryperFly{2},recoveryperFly{3})

    % plot
    figure; hold on
    bar([1,2,3],meanRecovery500(:,iND))
    errorbar([1,2,3],meanRecovery500(:,iND),semRecovery500(:,iND),'.')
    xticks(1:3);
    % yticks(-3:0);
    xticklabels({'UAS-shi/+', 'C2-Gal4/+', 'C2>>shi'});
    ylabel('recovery (%)')
    title(['Recovery from the first response:500ms, ',allFilters{iND}])
    % ylim([-3 0.5])
end 
%% summary plot of recoveries within the three ND filters (Fig 7j,k right)
% edge luminance values for x
maxL=1176758.88/15; %native level 1 without any ND
lumVals=[maxL/8,... %for ND 0.9
    maxL/64,... %for ND 1.8
    maxL/512]; %for ND 2.7
% 750 ms
figure; hold on
for iGeno=1:3
    errorbar(lumVals,meanRecovery750(iGeno,:),semRecovery750(iGeno,:),'o-','linewidth',1)
end
set(gca,'xscale','log')
legend('UAS-shibire/+','C2-Gal4/+','C2>>shibire')
% xlim([0.7 3.3])
ylim([40 150])
title('recovery across ND filters: 750 ms')
xlabel('luminance')
ylabel('recovery(%)')
yticks(0:50:150);
box off
set(gca,'tickdir','in')
set(gca,'ticklength',[0.02 0.025])

% 500 ms
figure; hold on
for iGeno=1:3
    errorbar(lumVals,meanRecovery500(iGeno,:),semRecovery500(iGeno,:),'o-','linewidth',1)
end
set(gca,'xscale','log')
legend('UAS-shibire/+','C2-Gal4/+','C2>>shibire')
% xlim([0.7 3.3])
ylim([5 120])
title('recovery across ND filters: 500 ms')
xlabel('luminance')
ylabel('recovery(%)')
yticks(0:50:150);
box off
set(gca,'tickdir','in')
set(gca,'ticklength',[0.02 0.025])
