%%% Analyse by different regions of the neuron

clc;
clearvars % -EXCEPT slob* contr*;
close all;

GENOTYPE_STRING = 'Mi1 Gal4 >> GCaMP6f, Medulla Layer9';
gen_str = GENOTYPE_STRING;


%% Select Data


datapath='Data/FFFData';
% addpath(datapath);

FFFDATA_Mi1=load([datapath,'/FFFDATA_Mi1.mat']);
FFFDATA_Mi1_C2Sil=load([datapath,'/FFFDATA_Mi1_C2Sil.mat']);


mCsplitGal4_Mi1 = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_Mi1.xCsplitGal4);
mCsplitGal4_Mi1_C2Sil = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_Mi1_C2Sil.xCsplitGal4);

%%

% correlate with stimulus to select normal and inverted ROIs
iRATE = 10; %rate at which data are interpolated
dur = size(mCsplitGal4_Mi1.rats,2);
DURS = 5;


% start with all the data, keep the ones that are positively correlated
% with stimulus (by value Q)
cur_mat = mCsplitGal4_Mi1.rats;
cur_IDs = mCsplitGal4_Mi1.flyID;

cur_mat_C2Sil = mCsplitGal4_Mi1_C2Sil.rats;
cur_IDs_C2Sil = mCsplitGal4_Mi1_C2Sil.flyID;

cur_t = [1:size(cur_mat,2)]/iRATE;


% positive correlation with stimulus
Q = corr(mean(mCsplitGal4_Mi1.stims)',cur_mat');
inds = find(Q>0.5); %finds the cells whose response correlates well with the stimulus 
cur_mat_pos = cur_mat(inds,:); 
cur_IDs_pos = cur_IDs(inds);

Q= corr(mean(mCsplitGal4_Mi1_C2Sil.stims)',cur_mat_C2Sil');
inds_C2Sil = find(Q>0.5); %finds the cells whose response correlates well with the stimulus 
cur_mat_pos_C2Sil = cur_mat_C2Sil(inds_C2Sil,:); 
cur_IDs_pos_C2Sil = cur_IDs_C2Sil(inds_C2Sil);


% negative correlation with stimulus
Q = corr(mean(mCsplitGal4_Mi1.stims)',cur_mat');
inds = find(Q<-0.5);
cur_mat_neg = cur_mat(inds,:);
cur_IDs_neg = cur_IDs(inds);

Q = corr(mean(mCsplitGal4_Mi1_C2Sil.stims)',cur_mat_C2Sil');
inds_C2Sil = find(Q<-0.5);
cur_mat_neg_C2Sil = cur_mat_C2Sil(inds_C2Sil,:);
cur_IDs_neg_C2Sil = cur_IDs_C2Sil(inds_C2Sil);

 
%calculating means across flies

[x_pos,m_pos,e_pos] = mean_cat_full(cur_mat_pos,1,cur_IDs_pos);
[x_pos_C2Sil,m_pos_C2Sil,e_pos_C2Sil] = mean_cat_full(cur_mat_pos_C2Sil,1,cur_IDs_pos_C2Sil);

[x_neg_C2Sil,m_neg_C2Sil,e_neg_C2Sil] = mean_cat_full(cur_mat_neg_C2Sil,1,cur_IDs_neg_C2Sil);
[x_neg,m_neg,e_neg] = mean_cat_full(cur_mat_neg,1,cur_IDs_neg);

[x_all_C2Sil,m_all_C2Sil,e_all_C2Sil] = mean_cat_full(cur_mat_C2Sil,1,cur_IDs_C2Sil);
[x_all,m_all,e_all] = mean_cat_full(cur_mat,1,cur_IDs);



%% Figure
%plot positively correlated cells, mean across ROIs

mROI_pos = mean(cur_mat_pos);
eROI_pos = std(cur_mat_pos,[],1)/sqrt(size(cur_mat_pos,1)); %S.E.M

mROI_pos_C2Sil = mean(cur_mat_pos_C2Sil);
eROI_pos_C2Sil = std(cur_mat_pos_C2Sil,[],1)/sqrt(size(cur_mat_pos_C2Sil,1)); %S.E.M


figure; hold on

cm=colormap('lines');
h1 = plot_err_patch_v2(cur_t,mROI_pos,eROI_pos,[0.5 0.5 0.5],[0.5 0.5 0.5]);
title([gen_str ', pos corr, mean by ROI']);
hold on 
h2 = plot_err_patch_v2(cur_t,mROI_pos_C2Sil,eROI_pos_C2Sil,[0.75 0 0.75],[0.75 0.5 0.75]);

legend([h1,h2],{sprintf(['Mi1 Control N = %d ( %d )'],size(x_pos,1),size(cur_mat_pos,1)),sprintf(['Mi1 shi N = %d ( %d )'],size(x_pos_C2Sil,1),size(cur_mat_pos_C2Sil,1))},...
    'location','northeast');


plot(cur_t, (round(mean(mCsplitGal4_Mi1.stims))*0.3)+0.6)

line([DURS DURS],[-0.6 0.6],'color',[0 0 0],'linestyle','--');
line([0 DURS],[0 0],'color',[0 0 0]);
set(gcf,'Color','w');



