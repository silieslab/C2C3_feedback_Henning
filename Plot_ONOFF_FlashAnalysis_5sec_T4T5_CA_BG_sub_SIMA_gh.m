%%%
% This script analyzes T4T5 responses to full field ON/OFF stimuli for
% control and C2, C3 and C2C3 double silencing conditions (Fig 3a-c, Suppl.Fig. 2)
%%%


clc;
clearvars
close all;


% % % % % 
addpath(genpath('/subscripts'))

datapath='/Data/FFFData';

addpath(datapath);
cd(datapath);


FFFDATA_T4T5_Control=load('FFFDATA_T4T5_Control.mat');
FFFDATA_T4T5_C2Sil=load('FFFDATA_T4T5_C2Sil.mat');
FFFDATA_T4T5_C3Sil=load('FFFDATA_T4T5_C3Sil.mat');
FFFDATA_T4T5_C2C3Sil=load('FFFDATA_T4T5_C2C3Sil.mat');


% Average responses across epoch repetitions
mCsplitGal4 = aggregate_fffall_means10Hz_BleedThruFix_v2_CA(FFFDATA_T4T5_Control.T4T5_Control);
mCsplitGal4_C2Sil = aggregate_fffall_means10Hz_BleedThruFix_v2_CA(FFFDATA_T4T5_C2Sil.T4T5_Control_C2Sil);
mCsplitGal4_C3Sil = aggregate_fffall_means10Hz_BleedThruFix_v2_CA(FFFDATA_T4T5_C3Sil.T4T5_Control_C3Sil);
mCsplitGal4_C2C3Sil = aggregate_fffall_means10Hz_BleedThruFix_v2_CA(FFFDATA_T4T5_C2C3Sil.T4T5_Control_C2C3Sil);


%%
% correlate with stimulus to select normal and inverted ROIs
iRATE = 10; %rate at which data are interpolated
dur = size(mCsplitGal4.rats_T4,2);
DURS = 5;


% start with all the data, keep the ones that are positively correlated
% with stimulus (by value Q)
cur_mat_T4 = mCsplitGal4.rats_T4;
cur_mat_T5 = mCsplitGal4.rats_T5;

cur_mat_T4_L1 = mCsplitGal4.rats_T4_L1;
cur_mat_T5_L1 = mCsplitGal4.rats_T5_L1;
cur_mat_T4_L2 = mCsplitGal4.rats_T4_L2;
cur_mat_T5_L2 = mCsplitGal4.rats_T5_L2;
cur_mat_T4_L3 = mCsplitGal4.rats_T4_L3;
cur_mat_T5_L3 = mCsplitGal4.rats_T5_L3;
cur_mat_T4_L4 = mCsplitGal4.rats_T4_L4;
cur_mat_T5_L4 = mCsplitGal4.rats_T5_L4;


cur_mat_T4_C2Sil = mCsplitGal4_C2Sil.rats_T4;
cur_mat_T5_C2Sil = mCsplitGal4_C2Sil.rats_T5;

cur_mat_T4_C2Sil_L1 = mCsplitGal4_C2Sil.rats_T4_L1;
cur_mat_T5_C2Sil_L1 = mCsplitGal4_C2Sil.rats_T5_L1;
cur_mat_T4_C2Sil_L2 = mCsplitGal4_C2Sil.rats_T4_L2;
cur_mat_T5_C2Sil_L2 = mCsplitGal4_C2Sil.rats_T5_L2;
cur_mat_T4_C2Sil_L3 = mCsplitGal4_C2Sil.rats_T4_L3;
cur_mat_T5_C2Sil_L3 = mCsplitGal4_C2Sil.rats_T5_L3;
cur_mat_T4_C2Sil_L4 = mCsplitGal4_C2Sil.rats_T4_L4;
cur_mat_T5_C2Sil_L4 = mCsplitGal4_C2Sil.rats_T5_L4;




cur_mat_T4_C3Sil = mCsplitGal4_C3Sil.rats_T4;
cur_mat_T5_C3Sil = mCsplitGal4_C3Sil.rats_T5;

cur_mat_T4_C3Sil_L1 = mCsplitGal4_C3Sil.rats_T4_L1;
cur_mat_T5_C3Sil_L1 = mCsplitGal4_C3Sil.rats_T5_L1;
cur_mat_T4_C3Sil_L2 = mCsplitGal4_C3Sil.rats_T4_L2;
cur_mat_T5_C3Sil_L2 = mCsplitGal4_C3Sil.rats_T5_L2;
cur_mat_T4_C3Sil_L3 = mCsplitGal4_C3Sil.rats_T4_L3;
cur_mat_T5_C3Sil_L3 = mCsplitGal4_C3Sil.rats_T5_L3;
cur_mat_T4_C3Sil_L4 = mCsplitGal4_C3Sil.rats_T4_L4;
cur_mat_T5_C3Sil_L4 = mCsplitGal4_C3Sil.rats_T5_L4;



cur_mat_T4_C2C3Sil = mCsplitGal4_C2C3Sil.rats_T4;
cur_mat_T5_C2C3Sil = mCsplitGal4_C2C3Sil.rats_T5;

cur_mat_T4_C2C3Sil_L1 = mCsplitGal4_C2C3Sil.rats_T4_L1;
cur_mat_T5_C2C3Sil_L1 = mCsplitGal4_C2C3Sil.rats_T5_L1;
cur_mat_T4_C2C3Sil_L2 = mCsplitGal4_C2C3Sil.rats_T4_L2;
cur_mat_T5_C2C3Sil_L2 = mCsplitGal4_C2C3Sil.rats_T5_L2;
cur_mat_T4_C2C3Sil_L3 = mCsplitGal4_C2C3Sil.rats_T4_L3;
cur_mat_T5_C2C3Sil_L3 = mCsplitGal4_C2C3Sil.rats_T5_L3;
cur_mat_T4_C2C3Sil_L4 = mCsplitGal4_C2C3Sil.rats_T4_L4;
cur_mat_T5_C2C3Sil_L4 = mCsplitGal4_C2C3Sil.rats_T5_L4;

% 

cur_IDs = mCsplitGal4.flyID;
cur_IDs_C2Sil = mCsplitGal4_C2Sil.flyID;
cur_IDs_C3Sil = mCsplitGal4_C3Sil.flyID;
cur_IDs_C2C3Sil = mCsplitGal4_C2C3Sil.flyID;


cur_t = [1:size(cur_mat_T4,2)]/iRATE;


%calculating means across flies
[x_T4,m_T4,e_T4] = mean_cat_full(cur_mat_T4,1,cur_IDs);
[x_T5,m_T5,e_T5] = mean_cat_full(cur_mat_T5,1,cur_IDs);

[x_T4_L1,m_T4_L1,e_T4_L1] = mean_cat_full(cur_mat_T4_L1,1,cur_IDs);
[x_T5_L1,m_T5_L1,e_T5_L1] = mean_cat_full(cur_mat_T5_L1,1,cur_IDs);
[x_T4_L2,m_T4_L2,e_T4_L2] = mean_cat_full(cur_mat_T4_L2,1,cur_IDs);
[x_T5_L2,m_T5_L2,e_T5_L2] = mean_cat_full(cur_mat_T5_L2,1,cur_IDs);
[x_T4_L3,m_T4_L3,e_T4_L3] = mean_cat_full(cur_mat_T4_L3,1,cur_IDs);
[x_T5_L3,m_T5_L3,e_T5_L3] = mean_cat_full(cur_mat_T5_L3,1,cur_IDs);
[x_T4_L4,m_T4_L4,e_T4_L4] = mean_cat_full(cur_mat_T4_L4,1,cur_IDs);
[x_T5_L4,m_T5_L4,e_T5_L4] = mean_cat_full(cur_mat_T5_L4,1,cur_IDs);


[x_T4_C2Sil,m_T4_C2Sil,e_T4_C2Sil] = mean_cat_full(cur_mat_T4_C2Sil,1,cur_IDs_C2Sil);
[x_T5_C2Sil,m_T5_C2Sil,e_T5_C2Sil] = mean_cat_full(cur_mat_T5_C2Sil,1,cur_IDs_C2Sil);

[x_T4_C2Sil_L1,m_T4_C2Sil_L1,e_T4_C2Sil_L1] = mean_cat_full(cur_mat_T4_C2Sil_L1,1,cur_IDs_C2Sil);
[x_T5_C2Sil_L1,m_T5_C2Sil_L1,e_T5_C2Sil_L1] = mean_cat_full(cur_mat_T5_C2Sil_L1,1,cur_IDs_C2Sil);
[x_T4_C2Sil_L2,m_T4_C2Sil_L2,e_T4_C2Sil_L2] = mean_cat_full(cur_mat_T4_C2Sil_L2,1,cur_IDs_C2Sil);
[x_T5_C2Sil_L2,m_T5_C2Sil_L2,e_T5_C2Sil_L2] = mean_cat_full(cur_mat_T5_C2Sil_L2,1,cur_IDs_C2Sil);
[x_T4_C2Sil_L3,m_T4_C2Sil_L3,e_T4_C2Sil_L3] = mean_cat_full(cur_mat_T4_C2Sil_L3,1,cur_IDs_C2Sil);
[x_T5_C2Sil_L3,m_T5_C2Sil_L3,e_T5_C2Sil_L3] = mean_cat_full(cur_mat_T5_C2Sil_L3,1,cur_IDs_C2Sil);
[x_T4_C2Sil_L4,m_T4_C2Sil_L4,e_T4_C2Sil_L4] = mean_cat_full(cur_mat_T4_C2Sil_L4,1,cur_IDs_C2Sil);
[x_T5_C2Sil_L4,m_T5_C2Sil_L4,e_T5_C2Sil_L4] = mean_cat_full(cur_mat_T5_C2Sil_L4,1,cur_IDs_C2Sil);


[x_T4_C3Sil,m_T4_C3Sil,e_T4_C3Sil] = mean_cat_full(cur_mat_T4_C3Sil,1,cur_IDs_C3Sil);
[x_T5_C3Sil,m_T5_C3Sil,e_T5_C3Sil] = mean_cat_full(cur_mat_T5_C3Sil,1,cur_IDs_C3Sil);

[x_T4_C3Sil_L1,m_T4_C3Sil_L1,e_T4_C3Sil_L1] = mean_cat_full(cur_mat_T4_C3Sil_L1,1,cur_IDs_C3Sil);
[x_T5_C3Sil_L1,m_T5_C3Sil_L1,e_T5_C3Sil_L1] = mean_cat_full(cur_mat_T5_C3Sil_L1,1,cur_IDs_C3Sil);
[x_T4_C3Sil_L2,m_T4_C3Sil_L2,e_T4_C3Sil_L2] = mean_cat_full(cur_mat_T4_C3Sil_L2,1,cur_IDs_C3Sil);
[x_T5_C3Sil_L2,m_T5_C3Sil_L2,e_T5_C3Sil_L2] = mean_cat_full(cur_mat_T5_C3Sil_L2,1,cur_IDs_C3Sil);
[x_T4_C3Sil_L3,m_T4_C3Sil_L3,e_T4_C3Sil_L3] = mean_cat_full(cur_mat_T4_C3Sil_L3,1,cur_IDs_C3Sil);
[x_T5_C3Sil_L3,m_T5_C3Sil_L3,e_T5_C3Sil_L3] = mean_cat_full(cur_mat_T5_C3Sil_L3,1,cur_IDs_C3Sil);
[x_T4_C3Sil_L4,m_T4_C3Sil_L4,e_T4_C3Sil_L4] = mean_cat_full(cur_mat_T4_C3Sil_L4,1,cur_IDs_C3Sil);
[x_T5_C3Sil_L4,m_T5_C3Sil_L4,e_T5_C3Sil_L4] = mean_cat_full(cur_mat_T5_C3Sil_L4,1,cur_IDs_C3Sil);

[x_T4_C2C3Sil,m_T4_C2C3Sil,e_T4_C2C3Sil] = mean_cat_full(cur_mat_T4_C2C3Sil,1,cur_IDs_C2C3Sil);
[x_T5_C2C3Sil,m_T5_C2C3Sil,e_T5_C2C3Sil] = mean_cat_full(cur_mat_T5_C2C3Sil,1,cur_IDs_C2C3Sil);

[x_T4_C2C3Sil_L1,m_T4_C2C3Sil_L1,e_T4_C2C3Sil_L1] = mean_cat_full(cur_mat_T4_C2C3Sil_L1,1,cur_IDs_C2C3Sil);
[x_T5_C2C3Sil_L1,m_T5_C2C3Sil_L1,e_T5_C2C3Sil_L1] = mean_cat_full(cur_mat_T5_C2C3Sil_L1,1,cur_IDs_C2C3Sil);
[x_T4_C2C3Sil_L2,m_T4_C2C3Sil_L2,e_T4_C2C3Sil_L2] = mean_cat_full(cur_mat_T4_C2C3Sil_L2,1,cur_IDs_C2C3Sil);
[x_T5_C2C3Sil_L2,m_T5_C2C3Sil_L2,e_T5_C2C3Sil_L2] = mean_cat_full(cur_mat_T5_C2C3Sil_L2,1,cur_IDs_C2C3Sil);
[x_T4_C2C3Sil_L3,m_T4_C2C3Sil_L3,e_T4_C2C3Sil_L3] = mean_cat_full(cur_mat_T4_C2C3Sil_L3,1,cur_IDs_C2C3Sil);
[x_T5_C2C3Sil_L3,m_T5_C2C3Sil_L3,e_T5_C2C3Sil_L3] = mean_cat_full(cur_mat_T5_C2C3Sil_L3,1,cur_IDs_C2C3Sil);
[x_T4_C2C3Sil_L4,m_T4_C2C3Sil_L4,e_T4_C2C3Sil_L4] = mean_cat_full(cur_mat_T4_C2C3Sil_L4,1,cur_IDs_C2C3Sil);
[x_T5_C2C3Sil_L4,m_T5_C2C3Sil_L4,e_T5_C2C3Sil_L4] = mean_cat_full(cur_mat_T5_C2C3Sil_L4,1,cur_IDs_C2C3Sil);


%% Figure 3a: Plot mean +ste

F1=figure; hold on
set(F1,'Position', [ 400 400 600 600])
t = [1:dur]/10;
% subplot(2,2,1); hold on;
cm=colormap('lines');
subplot(1,2,1)
title(['T4 axon terminals'], 'FontSize', 18);
h1 = plot_err_patch_v2(cur_t,m_T4,e_T4,[0.7 0.7 0.7],[0.8 0.8 0.8]);
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
L=legend([h1],sprintf(['T4 Control- N( %d )'],size(x_T4,1)),'location','northeast');
set(L,'FontSize', 15);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.1]);
ylabel('dF/F','FontSize', 18)
xlabel('time (s)','FontSize', 18);
set(gca,'FontSize',12)

subplot(1,2,2)
patch([0,15,15,0],[-0.2 -0.2 1.2 1.2],[0.8 0.8 0.8])
title(['T5 axon terminals'], 'FontSize', 18);
h2 = plot_err_patch_v2(cur_t,m_T5,e_T5,[0.4 0.4 0.4],[0.5 0.5 0.5]);  
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
L=legend([h2],sprintf(['T5 Control- N( %d )'],size(x_T5,1)),'location','northeast');
set(L,'FontSize', 15);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.1]);
xlabel('time (s)','FontSize', 18);
set(gca,'FontSize',12)


set(gcf,'Color','w');

%Plot C2silenced Data on top 

subplot(1,2,1)
hold on 

h3 = plot_err_patch_v2(cur_t,m_T4_C2Sil,e_T4_C2Sil,[0.75 0 0.75],[0.75 0.5 0.75]);
L=legend([h1,h3],sprintf(['T4 Control- N( %d )'],size(x_T4,1)),...
    sprintf(['T4 C2Silenced- N( %d )'],size(x_T4_C2Sil,1)),'location','northeast');
set(L,'FontSize', 15);


subplot(1,2,2)
h4 = plot_err_patch_v2(cur_t,m_T5_C2Sil,e_T5_C2Sil,[0.75 0 0.75],[0.75 0.5 0.75]); %Green for C3  
L=legend([h2,h4],sprintf(['T5 Control- N( %d )'],size(x_T5,1)),...
    sprintf(['T5 C2Silenced- N( %d )'],size(x_T5_C2Sil,1)),'location','northeast');
set(L,'FontSize', 15);

% saveas(F1, ['/Volumes/ukme06/mhennin2/2p-imaging/Results_T4_T5_Imaging_C2_C3Kir/Responses_to_Flashes/Flash Response T4T5-Control+C2Sil_new-BG.pdf'])    




%C3Silenced
F2=figure; hold on
set(F2,'Position', [ 400 400 600 600])
t = [1:dur]/10;
% subplot(2,2,1); hold on;
cm=colormap('lines');
subplot(1,2,1)
title(['T4 axon terminals'], 'FontSize', 18);
h1 = plot_err_patch_v2(cur_t,m_T4,e_T4,[0.7 0.7 0.7],[0.8 0.8 0.8]);
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
L=legend([h1],sprintf(['T4 Control- N( %d )'],size(x_T4,1)),'location','northeast');
set(L,'FontSize', 15);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.1]);
ylabel('dF/F','FontSize', 18)
xlabel('time (s)','FontSize', 18);
set(gca,'FontSize',12)

subplot(1,2,2)
patch([0,15,15,0],[-0.2 -0.2 1.2 1.2],[0.8 0.8 0.8])
title(['T5 axon terminals'], 'FontSize', 18);
h2 = plot_err_patch_v2(cur_t,m_T5,e_T5,[0.4 0.4 0.4],[0.5 0.5 0.5]);  
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
L=legend([h2],sprintf(['T5 Control- N( %d )'],size(x_T5,1)),'location','northeast');
set(L,'FontSize', 15);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.1]);
xlabel('time (s)','FontSize', 18);
set(gca,'FontSize',12)


set(gcf,'Color','w');

%Plot C3silenced Data on top 
subplot(1,2,1)
hold on 

h5 = plot_err_patch_v2(cur_t,m_T4_C3Sil,e_T4_C3Sil,[0 0.5 0],[0.5 0.85 0.5]);
L=legend([h1,h5],sprintf(['T4 Control- N( %d )'],size(x_T4,1)),...
    sprintf(['T4 C3Silenced- N( %d )'],size(x_T4_C3Sil,1)),...
    'location','northeast');
set(L,'FontSize', 15);


subplot(1,2,2)
h6 = plot_err_patch_v2(cur_t,m_T5_C3Sil,e_T5_C3Sil,[0.2 0.4 0.2],[0.4 0.65 0.5]); %Green for C3  
L=legend([h2,h6],sprintf(['T5 Control- N( %d )'],size(x_T5,1)),...
    sprintf(['T5 C3Silenced- N( %d )'],size(x_T5_C3Sil,1)),...
    'location','northeast');
set(L,'FontSize', 15);


%% Supplementary Figure 3c: Plot mean +ste

%C2C3Silenced
F2=figure; hold on
set(F2,'Position', [ 400 400 600 600])
t = [1:dur]/10;
% subplot(2,2,1); hold on;
cm=colormap('lines');
subplot(1,2,1)
title(['T4 axon terminals'], 'FontSize', 18);
h1 = plot_err_patch_v2(cur_t,m_T4,e_T4,[0.7 0.7 0.7],[0.8 0.8 0.8]);
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
L=legend([h1],sprintf(['T4 Control- N( %d )'],size(x_T4,1)),'location','northeast');
set(L,'FontSize', 15);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.1]);
ylabel('dF/F','FontSize', 18)
xlabel('time (s)','FontSize', 18);
set(gca,'FontSize',12)

subplot(1,2,2)
patch([0,15,15,0],[-0.2 -0.2 1.2 1.2],[0.8 0.8 0.8])
title(['T5 axon terminals'], 'FontSize', 18);
h2 = plot_err_patch_v2(cur_t,m_T5,e_T5,[0.4 0.4 0.4],[0.5 0.5 0.5]);  
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
L=legend([h2],sprintf(['T5 Control- N( %d )'],size(x_T5,1)),'location','northeast');
set(L,'FontSize', 15);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.1]);
xlabel('time (s)','FontSize', 18);
set(gca,'FontSize',12)


set(gcf,'Color','w');


subplot(1,2,1)
hold on 

h7 = plot_err_patch_v2(cur_t,m_T4_C2C3Sil,e_T4_C2C3Sil,[0.5 0.67 0.83],[0.4 0.67 0.83]);
L=legend([h1,h7],sprintf(['T4 Control- N( %d )'],size(x_T4,1)),...
    sprintf(['T4 C2C3Silenced- N( %d )'],size(x_T4_C2C3Sil,1)),...
    'location','northeast');
set(L,'FontSize', 15);


subplot(1,2,2)
h8 = plot_err_patch_v2(cur_t,m_T5_C2C3Sil,e_T5_C2C3Sil,[0.4 0.55 0.75],[0.4 0.55 0.75]); 
L=legend([h2,h8],sprintf(['T5 Control- N( %d )'],size(x_T5,1)),...
    sprintf(['T5 C2C3Silenced- N( %d )'],size(x_T5_C2C3Sil,1)),...
    'location','northeast');

 set(L,'FontSize', 15);
% saveas(F1, ['/Volumes/ukme06/mhennin2/2p-imaging/Results_T4_T5_Imaging_C2_C3Kir/Responses_to_Flashes/Flash Response T4T5-Control+C2Sil+C3Sil+C2C3Sil_new-BG-SIMA.pdf'])    




%% Supplement Figure 2f: Plot mean +ste seperated Layers 

F4=figure; hold on
set(F4,'Position', [ 400 400 600 800])
t = [1:dur]/10;
% subplot(2,2,1); hold on;
cm=colormap('lines');
subplot(4,2,1)
title(['T4 axon terminals Layer1'], 'FontSize', 12);
h1 = plot_err_patch_v2(cur_t,m_T4_L1,e_T4_L1,[0.7 0.7 0.7],[0.8 0.8 0.8]);
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);

plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.6]);
ylabel('dF/F','FontSize', 18)
set(gca,'FontSize',12)


subplot(4,2,2)
title(['T5 axon terminals Layer1'], 'FontSize', 12);
h2 = plot_err_patch_v2(cur_t,m_T5_L1,e_T5_L1,[0.4 0.4 0.4],[0.5 0.5 0.5]);  
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);

plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.6]);
set(gca,'FontSize',12)


subplot(4,2,3)
title(['Layer2'], 'FontSize', 12);
h1 = plot_err_patch_v2(cur_t,m_T4_L2,e_T4_L2,[0.7 0.7 0.7],[0.8 0.8 0.8]);
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.6]);
ylabel('dF/F','FontSize', 18)
set(gca,'FontSize',12)

subplot(4,2,4)
title(['Layer2'], 'FontSize', 12);
h2 = plot_err_patch_v2(cur_t,m_T5_L2,e_T5_L2,[0.4 0.4 0.4],[0.5 0.5 0.5]);  
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.6]);
set(gca,'FontSize',12)

subplot(4,2,5)
title(['Layer3'], 'FontSize', 12);
h1 = plot_err_patch_v2(cur_t,m_T4_L3,e_T4_L3,[0.7 0.7 0.7],[0.8 0.8 0.8]);
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.6]);
ylabel('dF/F','FontSize', 18)
set(gca,'FontSize',12)

subplot(4,2,6)
title(['Layer3'], 'FontSize', 12);
h2 = plot_err_patch_v2(cur_t,m_T5_L3,e_T5_L3,[0.4 0.4 0.4],[0.5 0.5 0.5]);  
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.6]);
set(gca,'FontSize',12)


subplot(4,2,7)
title(['Layer4'], 'FontSize', 12);
h1 = plot_err_patch_v2(cur_t,m_T4_L4,e_T4_L2,[0.7 0.7 0.7],[0.8 0.8 0.8]);
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.6]);
ylabel('dF/F','FontSize', 18)
xlabel('time (s)','FontSize', 18);
set(gca,'FontSize',12)

subplot(4,2,8)
title(['Layer4'], 'FontSize', 12);
h2 = plot_err_patch_v2(cur_t,m_T5_L4,e_T5_L4,[0.4 0.4 0.4],[0.5 0.5 0.5]);  
plot([0 5],0.1*[1 1],'k-','linewidth',3);
plot([10 15],0.1*[1 1],'k-','linewidth',3);
plot([0 15],0*[1 1],'k--','linewidth',1);
ylim([-0.2 1.6]);
xlabel('time (s)','FontSize', 18);
set(gca,'FontSize',12)

set(gcf,'Color','w');
% set(F1, 'PaperPositionMode','manual')
% print(F1, ['/Volumes/ukme06/mhennin2/2p-imaging/Results_T4_T5_Imaging_C2_C3Kir/Responses_to_Flashes/Flash Response T4T5-Control_new -BG'],'-dpdf')    



%Plot C2silenced Data on top 

subplot(4,2,1)
hold on 
h3 = plot_err_patch_v2(cur_t,m_T4_C2Sil_L1,e_T4_C2Sil_L1,[0.75 0 0.75],[0.75 0.5 0.75]);

subplot(4,2,2)
hold on 
h4 = plot_err_patch_v2(cur_t,m_T5_C2Sil_L1,e_T5_C2Sil_L1,[0.55 0.4 0.55],[0.55 0.5 0.55]); %Green for C3  

subplot(4,2,3)
hold on 
h3 = plot_err_patch_v2(cur_t,m_T4_C2Sil_L2,e_T4_C2Sil_L2,[0.75 0 0.75],[0.75 0.5 0.75]);

subplot(4,2,4)
hold on 
h4 = plot_err_patch_v2(cur_t,m_T5_C2Sil_L2,e_T5_C2Sil_L2,[0.55 0.4 0.55],[0.55 0.5 0.55]); %Green for C3  

subplot(4,2,5)
hold on 
h3 = plot_err_patch_v2(cur_t,m_T4_C2Sil_L3,e_T4_C2Sil_L3,[0.75 0 0.75],[0.75 0.5 0.75]);

subplot(4,2,6)
hold on 
h4 = plot_err_patch_v2(cur_t,m_T5_C2Sil_L3,e_T5_C2Sil_L3,[0.55 0.4 0.55],[0.55 0.5 0.55]); %Green for C3  

subplot(4,2,7)
hold on 
h3 = plot_err_patch_v2(cur_t,m_T4_C2Sil_L4,e_T4_C2Sil_L4,[0.75 0 0.75],[0.75 0.5 0.75]);

subplot(4,2,8)
hold on 
h4 = plot_err_patch_v2(cur_t,m_T5_C2Sil_L4,e_T5_C2Sil_L4,[0.55 0.4 0.55],[0.55 0.5 0.55]); %Green for C3  

% saveas(F1, ['/Volumes/ukme06/mhennin2/2p-imaging/Results_T4_T5_Imaging_C2_C3Kir/Responses_to_Flashes/Flash Response T4T5-Control+C2Sil_new-BG.pdf'])    



%C3Silenced

subplot(4,2,1)
hold on 
h5 = plot_err_patch_v2(cur_t,m_T4_C3Sil_L1,e_T4_C3Sil_L1,[0 0.5 0],[0.5 0.85 0.5]);

subplot(4,2,2)
hold on 
h6 = plot_err_patch_v2(cur_t,m_T5_C3Sil_L1,e_T5_C3Sil_L1,[0.2 0.4 0.2],[0.4 0.65 0.5]); %Green for C3  

subplot(4,2,3)
hold on 
h5 = plot_err_patch_v2(cur_t,m_T4_C3Sil_L2,e_T4_C3Sil_L2,[0 0.5 0],[0.5 0.85 0.5]);

subplot(4,2,4)
hold on 
h6 = plot_err_patch_v2(cur_t,m_T5_C3Sil_L2,e_T5_C3Sil_L2,[0.2 0.4 0.2],[0.4 0.65 0.5]); %Green for C3  

subplot(4,2,5)
hold on 
h5 = plot_err_patch_v2(cur_t,m_T4_C3Sil_L3,e_T4_C3Sil_L3,[0 0.5 0],[0.5 0.85 0.5]);

subplot(4,2,6)
hold on 
h6 = plot_err_patch_v2(cur_t,m_T5_C3Sil_L3,e_T5_C3Sil_L3,[0.2 0.4 0.2],[0.4 0.65 0.5]); %Green for C3  

subplot(4,2,7)
hold on 
h5 = plot_err_patch_v2(cur_t,m_T4_C3Sil_L4,e_T4_C3Sil_L4,[0 0.5 0],[0.5 0.85 0.5]);

subplot(4,2,8)
hold on 
h6 = plot_err_patch_v2(cur_t,m_T5_C3Sil_L4,e_T5_C3Sil_L4,[0.2 0.4 0.2],[0.4 0.65 0.5]); %Green for C3  

% saveas(F1, ['/Volumes/ukme06/mhennin2/2p-imaging/Results_T4_T5_Imaging_C2_C3Kir/Responses_to_Flashes/Flash Response T4T5-Control+C2Sil+C3Sil_new-BG.pdf'])    

% % %C2C3Silenced
% % 
% % subplot(4,2,1)
% % hold on 
% % h7 = plot_err_patch_v2(cur_t,m_T4_C2C3Sil_L1,e_T4_C2C3Sil_L1,[0.5 0.67 0.83],[0.4 0.67 0.83]);
% % 
% % subplot(4,2,2)
% % hold on 
% % h8 = plot_err_patch_v2(cur_t,m_T5_C2C3Sil_L1,e_T5_C2C3Sil_L1,[0.4 0.55 0.75],[0.4 0.55 0.75]); 
% % 
% % subplot(4,2,3)
% % hold on 
% % h7 = plot_err_patch_v2(cur_t,m_T4_C2C3Sil_L2,e_T4_C2C3Sil_L2,[0.5 0.67 0.83],[0.4 0.67 0.83]);
% % 
% % subplot(4,2,4)
% % hold on 
% % h8 = plot_err_patch_v2(cur_t,m_T5_C2C3Sil_L2,e_T5_C2C3Sil_L2,[0.4 0.55 0.75],[0.4 0.55 0.75]); 
% % 
% % subplot(4,2,5)
% % hold on 
% % h7 = plot_err_patch_v2(cur_t,m_T4_C2C3Sil_L3,e_T4_C2C3Sil_L3,[0.5 0.67 0.83],[0.4 0.67 0.83]);
% % 
% % subplot(4,2,6)
% % hold on 
% % h8 = plot_err_patch_v2(cur_t,m_T5_C2C3Sil_L3,e_T5_C2C3Sil_L3,[0.4 0.55 0.75],[0.4 0.55 0.75]); 
% % 
% % subplot(4,2,7)
% % hold on 
% % h7 = plot_err_patch_v2(cur_t,m_T4_C2C3Sil_L4,e_T4_C2C3Sil_L4,[0.5 0.67 0.83],[0.4 0.67 0.83]);
% % 
% % subplot(4,2,8)
% % hold on 
% % h8 = plot_err_patch_v2(cur_t,m_T5_C2C3Sil_L4,e_T5_C2C3Sil_L4,[0.4 0.55 0.75],[0.4 0.55 0.75]); 
% % 
% % 
% % % saveas(F1, ['/Volumes/ukme06/mhennin2/2p-imaging/Results_T4_T5_Imaging_C2_C3Kir/Responses_to_Flashes/Flash Response T4T5-Control+C2Sil+C3Sil+C2C3Sil_new-BG-SIMA.pdf'])    
% % 

%% Figure2: Plot individual Flies

% F2=figure; hold on
% set(F2,'Position', [ 400 400 1500 600])
% t = [1:dur]/10;
% % subplot(2,2,1); hold on;
% cm=colormap('lines');
% subplot(3,2,1)
% h1 = plot(cur_t,x_T4,'Color', [0.7 0.7 0.7]);
% title(['T4 axon terminals'], 'FontSize', 18);
% hold on 
% plot([0 5],0.4*[1 1],'k-','linewidth',3);
% plot([10 15],0.4*[1 1],'k-','linewidth',3);
% L=legend([h1(1)],sprintf(['T4 Control- N( %d )'],size(x_T4,1)),'location','northeast');
% set(L,'FontSize', 12);
% plot([0 15],0*[1 1],'k--','linewidth',1);
% ylim([-0.3 1.3]);
% ylabel('dF/F','FontSize', 12)
% 
% 
% subplot(3,2,2)
% 
% h2 = plot(cur_t,x_T5,'Color',[0.4 0.4 0.4]);hold on; 
% title(['T5 axon terminals'], 'FontSize', 18);
% plot([0 5],0.4*[1 1],'k-','linewidth',3);
% plot([10 15],0.4*[1 1],'k-','linewidth',3);
% L=legend([h2(1)],sprintf(['T5 Control- N( %d )'],size(x_T5,1)),'location','northeast');
% set(L,'FontSize', 12);
% plot([0 15],0*[1 1],'k--','linewidth',1);
% ylim([-0.3 1.3]);
% % plot(t, (round(mean(mCsplitGal4.stims))*0.1)+0.8)
% %  ylim([-0.3 0.5]);
% set(gcf,'Color','w');
% 
% %Plot C2silenced Data on top 
% subplot(3,2,3)
% h1 = plot(cur_t,x_T4_C2Sil,'Color', [0.75 0 0.75]);
% hold on 
% plot([0 5],0.4*[1 1],'k-','linewidth',3);
% plot([10 15],0.4*[1 1],'k-','linewidth',3);
% L=legend([h1(1)],sprintf(['T4 C2Silence- N( %d )'],size(x_T4_C2Sil,1)),'location','northeast');
% set(L,'FontSize', 12);
% plot([0 15],0*[1 1],'k--','linewidth',1);
% ylim([-0.3 1.3]);
% ylabel('dF/F','FontSize', 12)
% 
% subplot(3,2,4)
% h2 = plot(cur_t,x_T5_C2Sil,'Color',[0.55 0.4 0.55]);hold on; 
% plot([0 5],0.4*[1 1],'k-','linewidth',3);
% plot([10 15],0.4*[1 1],'k-','linewidth',3);
% L=legend([h2(1)],sprintf(['T5 C2Silence- N( %d )'],size(x_T5_C2Sil,1)),'location','northeast');
% set(L,'FontSize', 12);
% plot([0 15],0*[1 1],'k--','linewidth',1);
% ylim([-0.3 1.3]);
% 
% 
% subplot(3,2,5)
% h1 = plot(cur_t,x_T4_C3Sil,'Color', [0 0.5 0]);
% hold on 
% plot([0 5],0.4*[1 1],'k-','linewidth',3);
% plot([10 15],0.4*[1 1],'k-','linewidth',3);
% L=legend([h1(1)],sprintf(['T4 C3Silence- N( %d )'],size(x_T4_C3Sil,1)),'location','northeast');
% set(L,'FontSize', 12);
% plot([0 15],0*[1 1],'k--','linewidth',1);
% ylim([-0.3 1.3]);
% ylabel('dF/F','FontSize', 12)
% xlabel('time (s)','FontSize', 12);
% 
% 
% subplot(3,2,6)
% h2 = plot(cur_t,x_T5_C3Sil,'Color',[0.2 0.4 0.2]);hold on; 
% plot([0 5],0.4*[1 1],'k-','linewidth',3);
% plot([10 15],0.4*[1 1],'k-','linewidth',3);
% L=legend([h2(1)],sprintf(['T5 C3Silence- N( %d )'],size(x_T5_C3Sil,1)),'location','northeast');
% set(L,'FontSize', 12);
% plot([0 15],0*[1 1],'k--','linewidth',1);
% ylim([-0.3 1.3]);
% xlabel('time (s)','FontSize', 12);



%% Evaluating the Increase of ON response 
%Figures 3 a-c 
%Suppl. Figures 2 c-e


T4_ONResps=nan(3,10);
T5_OFFResps=nan(3,10);
T4_ONResps_supp=nan(2,10);
T5_OFFResps_supp=nan(2,10);
T5_ONResps=nan(4,10); 
T4_ON_Delay=nan(2,10);
    
InterON=find((3<cur_t) .* (cur_t<5));  % Two seconds before ON response
InterON2=find((5<cur_t) .* (cur_t<7));  % Two seconds after ON response

InterOFF=find((8<cur_t) .* (cur_t<10));  % Two seconds before OFF response
InterOFF2=find((10<cur_t) .* (cur_t<12));  % One seconds after OFF response

%Control
StartLevel= mean(x_T4(:,InterON),2);
[MAX,delay]=max(x_T4(:,InterON2),[],2);
T4_ONResps(1,1:length(MAX))=MAX-StartLevel;
T4_ONResps_supp(1,1:length(MAX))=MAX-StartLevel;
% T4_ON_Delay(1,1:length(MAX))=delay/iRATE;

StartLevel= mean(x_T5(:,InterOFF),2);
MAX=max(x_T5(:,InterOFF2),[],2);
T5_OFFResps(1,1:length(MAX))=MAX-StartLevel;
T5_OFFResps_supp(1,1:length(MAX))=MAX-StartLevel;

StartLevel= mean(x_T5(:,InterON),2);
MAX=max(x_T5(:,InterON2),[],2);
T5_ONResps(1,1:length(MAX))=MAX-StartLevel;


%C2Sil
StartLevel= mean(x_T4_C2Sil(:,InterON),2);
[MAX,delay]=max(x_T4_C2Sil(:,InterON2),[],2);
T4_ONResps(2,1:length(MAX))=MAX-StartLevel;
T4_ON_Delay(1,1:length(MAX))=delay/iRATE;

StartLevel= mean(x_T5_C2Sil(:,InterOFF),2);
MAX=max(x_T5_C2Sil(:,InterOFF2),[],2);
T5_OFFResps(2,1:length(MAX))=MAX-StartLevel;

StartLevel= mean(x_T5_C2Sil(:,InterON),2);
MAX=max(x_T5_C2Sil(:,InterON2),[],2);
T5_ONResps(2,1:length(MAX))=MAX-StartLevel;


%C3Sil
StartLevel= mean(x_T4_C3Sil(:,InterON),2);
[MAX,delay]=max(x_T4_C3Sil(:,InterON2),[],2);
T4_ONResps(3,1:length(MAX))=MAX-StartLevel;
T4_ON_Delay(2,1:length(MAX))=delay/iRATE;

StartLevel= mean(x_T5_C3Sil(:,InterOFF),2);
MAX=max(x_T5_C3Sil(:,InterOFF2),[],2);
T5_OFFResps(3,1:length(MAX))=MAX-StartLevel;

StartLevel= mean(x_T5_C3Sil(:,InterON),2);
MAX=max(x_T5_C3Sil(:,InterON2),[],2);
T5_ONResps(3,1:length(MAX))=MAX-StartLevel;

% 
%C2C3Sil
StartLevel= mean(x_T4_C2C3Sil(:,InterON),2);
[MAX,delay]=max(x_T4_C2C3Sil(:,InterON2),[],2);
T4_ONResps_supp(2,1:length(MAX))=MAX-StartLevel;
% T4_ON_Delay(4,1:length(MAX))=delay/iRATE;
% 
StartLevel= mean(x_T5_C2C3Sil(:,InterOFF),2);
MAX=max(x_T5_C2C3Sil(:,InterOFF2),[],2);
T5_OFFResps_supp(2,1:length(MAX))=MAX-StartLevel;
% 
StartLevel= mean(x_T5_C2C3Sil(:,InterON),2);
MAX=max(x_T5_C2C3Sil(:,InterON2),[],2);
T5_ONResps(4,1:length(MAX))=MAX-StartLevel;


% Fig. 3b 
F3=figure; hold on
set(F3,'Position', [ 400 400 500 500])

subplot(1,2,1) 
boxplot(T4_ONResps', 'notch', 'on','labels', {'Control', 'C2 Silence', 'C3 Silence'} )%,'C2C3 Silence'} )
set(gca,'YLim',[-0.1 2.3])
a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9);% The 7th object is the first box
Median1=a(4); Median2=a(5);Median3=a(6);
set(box1, 'Color', '[0 0.5 0]');  set(box2, 'Color', '[0.75 0 0.75]');  set(box3, 'Color', '[0.7 0.7 0.7]'); 
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');    % 
title('Fig.3b: ON response - T4','FontSize', 18) 
ylabel('Steps dF/F','FontSize', 18);
set(gca,'FontSize',12)

subplot(1,2,2) 

boxplot(T5_OFFResps', 'notch', 'on','labels', {'Control', 'C2 Silence', 'C3 Silence'})%,'C2C3 Silence'} )
set(gca,'YLim',[-0.1 2.3])
a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9);% The 7th object is the first box
Median1=a(4); Median2=a(5);Median3=a(6);
set(box1, 'Color', '[0 0.5 0]');  set(box2, 'Color', '[0.75 0 0.75]');  set(box3, 'Color', '[0.7 0.7 0.7]'); 
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');    % 
title('OFF response - T5','FontSize', 18) 
set(gca,'FontSize',12)
patch([0,15,15,0],[-0.1 -0.1 2.3 2.3],[0.7 0.7 0.7],'FaceAlpha',0.5)


%Fig. 3c
F20=figure; hold on
set(F20,'Position', [ 400 400 250 320])

boxplot(T4_ON_Delay', 'notch', 'on','labels', {'C2 Silence', 'C3 Silence'} )
% set(gca,'YLim',[-0.1 1.3])
a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(5);  box2= a(6);
Median1=a(3); Median2=a(4);
set(box1, 'Color', '[0 0.5 0]');  set(box2, 'Color', '[0.75 0 0.75]');  
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k'); 
ylim([0.2 2])
title('Fig.3c Top: T4','FontSize', 18) 
ylabel('Time to peak (s)','FontSize', 18);
set(gca,'FontSize',12)



%Supp. Fig. 2d

F9=figure; hold on
set(F9,'Position', [ 400 400 500 500])

subplot(1,2,1) 
boxplot(T4_ONResps_supp', 'notch', 'on','labels', {'Control', 'C2C3 Silence'})
set(gca,'YLim',[-0.1 2.3])
a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(5);  box2= a(6);
Median1=a(3); Median2=a(4);
set(box1, 'Color', '[0.1 0.5 1]'); set(box2, 'Color', '[0.7 0.7 0.7]'); 
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');
title('Supp Fig.2d: ON response - T4','FontSize', 18) 
ylabel('Steps dF/F','FontSize', 18);
set(gca,'FontSize',12)

subplot(1,2,2) 

boxplot(T5_OFFResps_supp', 'notch', 'on','labels', {'Control', 'C2C3 Silence'})
set(gca,'YLim',[-0.1 2.3])
a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(5);  box2= a(6);
Median1=a(3); Median2=a(4);
set(box1, 'Color', '[0.1 0.5 1]'); set(box2, 'Color', '[0.7 0.7 0.7]'); 
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');
title('OFF response - T5','FontSize', 18) 
set(gca,'FontSize',12)
patch([0,15,15,0],[-0.1 -0.1 2.3 2.3],[0.7 0.7 0.7],'FaceAlpha',0.5)


%Supp. Fig. 2e
F25=figure; hold on
set(F25,'Position', [ 400 400 300 500])

boxplot(T5_ONResps', 'notch', 'on','labels', {'Control', 'C2 Silence', 'C3 Silence','C2C3 Silence'} )
set(gca,'YLim',[-0.1 2.3])
a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(9);  box2= a(10); box3= a(11); box4= a(12); % The 7th object is the first box
Median1=a(5); Median2=a(6);Median3=a(7);Median4=a(8);
set(box1, 'Color', '[0.1 0.5 1]'); set(box2, 'Color', '[0 0.5 0]');  set(box3, 'Color', '[0.75 0 0.75]');  set(box4, 'Color', '[0.7 0.7 0.7]'); 
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');  set(Median4, 'Color', 'k');   % 
title('SupFig.2e: ON response - T5','FontSize', 18) 
ylabel('Steps dF/F','FontSize', 18);
set(gca,'FontSize',12)
patch([0,15,15,0],[-0.1 -0.1 2.3 2.3],[0.7 0.7 0.7],'FaceAlpha',0.5)



Multcomp_Stats(T4_ONResps,{'Control' , 'C2Kir', 'C3Kir'} )%, 'C2C3Kir'})
Multcomp_Stats(T5_OFFResps,{'Control' , 'C2Kir', 'C3Kir'} )%, 'C2C3Kir'})
Multcomp_Stats(T5_ONResps,{'Control' , 'C2Kir', 'C3Kir'} )%, 'C2C3Kir'})






% Statistics



% For ON delay I just want to test C2 vs C3 

Multcomp_Stats(T4_ON_Delay(2:3,:),{'C2Kir', 'C3Kir'})



%% Fit Decay rates:

% Fig.3c
InterON3=find((5<cur_t) .* (cur_t<8));  % Two seconds before ON response
Decay_rates_C2Sil=nan(1,size(x_T4_C2Sil,1));
for NCells=1:size(x_T4_C2Sil,1)
CurrX=x_T4_C2Sil(NCells,InterON3);
[M,MT]=max(CurrX);
CurrDec= CurrX(MT:end)';
CurrDec=CurrDec-min(CurrDec); %shift values to be positive
Xx=(1:length(CurrDec))'/iRATE;    
f = fit(Xx,CurrDec,'exp1');
% figure; plot(f,Xx,CurrDec)
% hold on; plot(Xx,CurrDec)

if f.b<0 % only take into account if it is a negative decay constant
% Decay_rates_C2Sil(NCells)=1/abs(f.b);
Decay_rates_C2Sil(NCells)=f.b;


end 

end 
% Decay_rates_C2Sil=Decay_rates_C2Sil(Decay_rates_C2Sil<0);



Decay_rates_C3Sil=nan(1,size(x_T4_C2Sil,1));
for NCells=1:size(x_T4_C3Sil,1)
CurrX=x_T4_C3Sil(NCells,:);
[M,MT]=max(CurrX); 
CurrDec= CurrX(MT:find(cur_t==8))';
CurrDec=CurrDec-min(CurrDec);   %shift values to be positive
Xx=(1:length(CurrDec))'/iRATE;    
[f,d] = fit(Xx,CurrDec,'exp1');
% figure; plot(f,Xx,CurrDec)
% hold on; plot(Xx,CurrDec)
% title(num2str(d.rsquare));
if f.b<0 % only take into account if it is a negative decay constant
% Decay_rates_C3Sil(NCells)=1/abs(f.b);
Decay_rates_C3Sil(NCells)=f.b;

end 

end 


Decay_rates=nan(1,max(size(Decay_rates_C3Sil,2),size(Decay_rates_C2Sil,2)));
Decay_rates(1,1:size(Decay_rates_C2Sil,2))=Decay_rates_C2Sil;
Decay_rates(2,1:size(Decay_rates_C3Sil,2))=Decay_rates_C3Sil;

F21=figure; hold on
set(F21,'Position', [ 400 400 250 320])

boxplot(Decay_rates', 'notch', 'on','labels', {'C2 Silence', 'C3 Silence'} )
a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(5);  box2= a(6);
Median1=a(3); Median2=a(4);
set(box1, 'Color', '[0 0.5 0]');  set(box2, 'Color', '[0.75 0 0.75]');  
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');
title('Fig. 3c bottom')
ylabel(' Decay rate (tau)')

figure
Multcomp_Stats(Decay_rates,{'C2 Silence', 'C3 Silence'})

%% 
% Suppl. Fig.2b

% Plot Number of cells found per Fly 
NFlies_allCon_T4=nan(4,10); 
NFlies_allCon_T5=nan(4,10); 

Data=FFFDATA_T4T5_Control.T4T5_Control; 
NFlies=size(Data,2); 
NT4=nan(1,NFlies);
NT5=nan(1,NFlies);
for N=1:NFlies
    NT4(N)=Data(N).NT4;
    NT5(N)=Data(N).NT5;
end


NFlies_allCon_T4(1,1:size(NT4,2))=NT4;
NFlies_allCon_T5(1,1:size(NT4,2))=NT5;


Data=FFFDATA_T4T5_C2Sil.T4T5_Control_C2Sil; 
NFlies=size(Data,2); 
NT4=nan(1,NFlies);
NT5=nan(1,NFlies);
for N=1:NFlies
    NT4(N)=Data(N).NT4;
    NT5(N)=Data(N).NT5;
end


NFlies_allCon_T4(2,1:size(NT4,2))=NT4;
NFlies_allCon_T5(2,1:size(NT4,2))=NT5;


Data=FFFDATA_T4T5_C3Sil.T4T5_Control_C3Sil; NFlies=size(Data,2); 
NT4=nan(1,NFlies);
NT5=nan(1,NFlies);
for N=1:NFlies
    NT4(N)=Data(N).NT4;
    NT5(N)=Data(N).NT5;
end


NFlies_allCon_T4(3,1:size(NT4,2))=NT4;
NFlies_allCon_T5(3,1:size(NT4,2))=NT5;


Data=FFFDATA_T4T5_C2C3Sil.T4T5_Control_C2C3Sil; NFlies=size(Data,2); 
NT4=nan(1,NFlies);
NT5=nan(1,NFlies);
for N=1:NFlies
    NT4(N)=Data(N).NT4;
    NT5(N)=Data(N).NT5;
end


NFlies_allCon_T4(4,1:size(NT4,2))=NT4;
NFlies_allCon_T5(4,1:size(NT4,2))=NT5;



Multcomp_Stats(NFlies_allCon_T4,{'Control','C2Kir', 'C3Kir', 'C2C3Kir'})%,'ANOVA')
Multcomp_Stats(NFlies_allCon_T5,{'Control','C2Kir', 'C3Kir', 'C2C3Kir'})%,'ANOVA')

figure; 
subplot(1,2,1)
boxplot(NFlies_allCon_T4', 'Notch', 'on', 'Labels', {'Control','C2Kir', 'C3Kir', 'C2C3Kir'})
a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(9);  box2= a(10); box3= a(11); box4= a(12); % The 7th object is the first box
Median1=a(5); Median2=a(6);Median3=a(7);Median4=a(8);
set(box1, 'Color', '[0.1 0.5 1]'); set(box2, 'Color', '[0 0.5 0]');  set(box3, 'Color', '[0.75 0 0.75]');  set(box4, 'Color', '[0.7 0.7 0.7]'); 
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');  set(Median4, 'Color', 'k');  
set(gca, 'YLim', [0 70]) 
title('# T4 Cells')


subplot(1,2,2)
boxplot(NFlies_allCon_T5', 'Notch', 'on', 'Labels', {'Control','C2Kir', 'C3Kir', 'C2C3Kir'})
a = get(get(gca,'children'),'children');   % Get the handles of all the objects
t = get(a,'tag');   % List the names of all the objects 
box1 = a(9);  box2= a(10); box3= a(11); box4= a(12); % The 7th object is the first box
Median1=a(5); Median2=a(6);Median3=a(7);Median4=a(8);
set(box1, 'Color', '[0.1 0.5 1]'); set(box2, 'Color', '[0 0.5 0]');  set(box3, 'Color', '[0.75 0 0.75]');  set(box4, 'Color', '[0.7 0.7 0.7]'); 
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');  set(Median4, 'Color', 'k');  
set(gca, 'YLim', [0 70]) 
title('# T5 Cells')




% Colors: 
%Dark green: [0.2 0.4 0.2]
%Dark purple: [0.55 0.4 0.55]
%Dark gray: [0.4 0.4 0.4]


%Bright green: [0 0.5 0]
%Bright purple: [0.75 0 0.75]
%Bright gray: [0.7 0.7 0.7]
