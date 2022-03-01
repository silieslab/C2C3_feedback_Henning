%%% Analyse by different regions of the neuron

clc;
clearvars
close all;


% % % % % 

addpath(genpath('subscripts'))

datapath='Data/FFFData';

addpath(datapath);

FFFDATA_C2=load([datapath,'/FFFDATA_C2.mat']);
FFFDATA_C3=load([datapath,'/FFFDATA_C3.mat']);


FFFDATA_C2_M5=load([datapath,'/FFFDATA_C2_M5.mat']);
FFFDATA_C3_M5=load([datapath,'/FFFDATA_C3_M5.mat']);
FFFDATA_C2_M8=load([datapath,'/FFFDATA_C2_M8.mat']);
FFFDATA_C2_M9=load([datapath,'/FFFDATA_C2_M9.mat']);
FFFDATA_C3_M9=load([datapath,'/FFFDATA_C3_M9.mat']);
FFFDATA_C2_CB=load([datapath,'/FFFDATA_C2_CB.mat']);
FFFDATA_C3_CB=load([datapath,'/FFFDATA_C3_CB.mat']);


mCsplitGal4_C2 = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_C2.xCsplitGal4);
mCsplitGal4_C3 = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_C3.xCsplitGal4);


mCsplitGal4_C2_M5 = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_C2_M5.xCsplitGal4);
mCsplitGal4_C3_M5 = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_C3_M5.xCsplitGal4);
mCsplitGal4_C2_M8 = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_C2_M8.xCsplitGal4);
mCsplitGal4_C2_M9 = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_C2_M9.xCsplitGal4);
mCsplitGal4_C3_M9 = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_C3_M9.xCsplitGal4);
mCsplitGal4_C2_CB = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_C2_CB.xCsplitGal4);
mCsplitGal4_C3_CB = aggregate_fffall_means10Hz_BleedThruFix_v2_mh(FFFDATA_C3_CB.xCsplitGal4);



%%
% correlate with stimulus to select normal and inverted ROIs
iRATE = 10; %rate at which data are interpolated
dur = size(mCsplitGal4_C2.rats,2);
DURS = 5;


% start with all the data, keep the ones that are positively correlated
% with stimulus (by value Q)
cur_mat_C2 = mCsplitGal4_C2.rats;
cur_IDs_C2 = mCsplitGal4_C2.flyID;
%clean up by zeros-only datasets and NaN dataset
inds = find(sum(cur_mat_C2,2)~=0);
cur_mat_C2 = cur_mat_C2(inds,:);
cur_IDs_C2 = cur_IDs_C2(inds);
inds = ~isnan(sum(cur_mat_C2,2));%ms: added these two lines, because there were NaN in dataset
cur_mat_C2 = cur_mat_C2(inds,:);
cur_IDs_C2 = cur_IDs_C2(inds);

cur_mat_C3 = mCsplitGal4_C3.rats;
cur_IDs_C3 = mCsplitGal4_C3.flyID;
%clean up by zeros-only datasets and NaN dataset
inds = find(sum(cur_mat_C3,2)~=0);
cur_mat_C3 = cur_mat_C3(inds,:);
cur_IDs_C3 = cur_IDs_C3(inds);
inds = ~isnan(sum(cur_mat_C3,2));%ms: added these two lines, because there were NaN in dataset
cur_mat_C3 = cur_mat_C3(inds,:);
cur_IDs_C3 = cur_IDs_C3(inds);

cur_t = [1:size(cur_mat_C2,2)]/iRATE;


%positive correlation with stimulus C2

Q_C2 = corr(mean(mCsplitGal4_C2.stims)',cur_mat_C2');
inds = find(Q_C2>0); %finds the cells whose response correlates well with the stimulus 
cur_mat_pos_C2 = cur_mat_C2(inds,:); 
cur_IDs_pos_C2 = cur_IDs_C2(inds);

%calculating means across flies
[x_pos_C2,m_pos_C2,e_pos_C2] = mean_cat_full(cur_mat_pos_C2,1,cur_IDs_pos_C2);
%calculating the max for each trace
max_pos_C2 = max(x_pos_C2,[],2)-1;


%positive correlation with stimulus C3

Q_C3 = corr(mean(mCsplitGal4_C3.stims)',cur_mat_C3');
inds = find(Q_C3>0); 
cur_mat_pos_C3 = cur_mat_C3(inds,:); 
cur_IDs_pos_C3 = cur_IDs_C3(inds);

%calculating means across flies
[x_pos_C3,m_pos_C3,e_pos_C3] = mean_cat_full(cur_mat_pos_C3,1,cur_IDs_pos_C3);
%calculating the max for each trace
max_pos_C3 = max(x_pos_C3,[],2)-1;



%% Figure1 
figure('Position', [400 400 1000 800]); hold on

subplot(2,2,1); 

t = [1:dur]/10;
cm=colormap('lines');
h1 = plot_err_patch_v2(cur_t,m_pos_C2,e_pos_C2,[0.75 0 0.75],[0.75 0.5 0.75]);
legend([h1],sprintf([' "fff pos corr", N = %d ( %d )'],size(x_pos_C2,1),size(cur_mat_pos_C2,1)),...
    'location','northeast');
plot(t, (round(mean(mCsplitGal4_C2.stims))*0.1)+0.8)
ylim([-0.5 1.5]);
line([0 5.5],[0 0],'color',[0 0 0]);
set(gcf,'Color','w');
title('C2')


subplot(2,2,3);
plot(t,x_pos_C2)
title('individual fly means');
ylim([-1 3]); 
line([DURS DURS],[-0.6 0.6],'color',[0 0 0],'linestyle','--');
line([0 DURS],[0 0],'color',[0 0 0]);
set(gcf,'Color','w');


subplot(2,2,2); 

t = [1:dur]/10;
cm=colormap('lines');
h1 = plot_err_patch_v2(cur_t,m_pos_C3,e_pos_C3,[0 0.5 0],[0.5 0.85 0.5]);
legend([h1],sprintf([' "fff pos corr", N = %d ( %d )'],size(x_pos_C3,1),size(cur_mat_pos_C3,1)),...
    'location','northeast');
plot(t, (round(mean(mCsplitGal4_C3.stims))*0.1)+0.8)
ylim([-0.5 1.5]);
line([0 5.5],[0 0],'color',[0 0 0]);
set(gcf,'Color','w');
title('C3')


subplot(2,2,4);
plot(t,x_pos_C3)
title('individual fly means');
ylim([-1 3]); 
line([DURS DURS],[-0.6 0.6],'color',[0 0 0],'linestyle','--');
line([0 DURS],[0 0],'color',[0 0 0]);
set(gcf,'Color','w');




%%
% correlate with stimulus to select normal and inverted ROIs

% start with all the data, keep the ones that are positively correlated
% with stimulus (by value Q)


F2=figure(2);
set(F2,'Position', [400 400 1000 800]); hold on

subplot(5,2,1); 

t = [1:dur]/10;
cm=colormap('lines');
h1 = plot_err_patch_v2(cur_t,m_pos_C2,e_pos_C2,[0.75 0 0.75],[0.75 0.5 0.75]);
legend([h1],sprintf([' "fff pos corr", N = %d ( %d )'],size(x_pos_C2,1),size(cur_mat_pos_C2,1)),...
    'location','northeast');
plot(t, (round(mean(mCsplitGal4_C2.stims))*0.1)+0.8)
ylim([-0.5 1.5]);
line([0 5.5],[0 0],'color',[0 0 0]);
set(gcf,'Color','w');
title('C2')


subplot(5,2,2); 

t = [1:dur]/10;
cm=colormap('lines');
h1 = plot_err_patch_v2(cur_t,m_pos_C3,e_pos_C3,[0 0.5 0],[0.5 0.85 0.5]);
legend([h1],sprintf([' "fff pos corr", N = %d ( %d )'],size(x_pos_C3,1),size(cur_mat_pos_C3,1)),...
    'location','northeast');
plot(t, (round(mean(mCsplitGal4_C3.stims))*0.1)+0.8)
ylim([-0.5 1.5]);
line([0 5.5],[0 0],'color',[0 0 0]);
set(gcf,'Color','w');
title('C3')


Regions={'M5','M8','M9','CB'};

count=2;

for R=1:size(Regions,2) 

    try 
    
        mCsplitGal4_C2_R=eval(['mCsplitGal4_C2_',Regions{R}]);

        cur_mat_C2= mCsplitGal4_C2_R.rats;
        cur_IDs_C2 = mCsplitGal4_C2_R.flyID;
        %clean up by zeros-only datasets and NaN dataset
        inds = find(sum(cur_mat_C2,2)~=0);
        cur_mat_C2 = cur_mat_C2(inds,:);
        cur_IDs_C2 = cur_IDs_C2(inds);
        inds = ~isnan(sum(cur_mat_C2,2));%ms: added these two lines, because there were NaN in dataset
        cur_mat_C2 = cur_mat_C2(inds,:);
        cur_IDs_C2 = cur_IDs_C2(inds);

    catch 
        cur_mat_C2=nan;
        cur_IDs_C2=nan;

    end 

    try   mCsplitGal4_C3_R=eval(['mCsplitGal4_C3_',Regions{R}]);
        cur_mat_C3 = mCsplitGal4_C3_R.rats;
        cur_IDs_C3 = mCsplitGal4_C3_R.flyID;
        %clean up by zeros-only datasets and NaN dataset
        inds = find(sum(cur_mat_C3,2)~=0);
        cur_mat_C3 = cur_mat_C3(inds,:);
        cur_IDs_C3 = cur_IDs_C3(inds);
        inds = ~isnan(sum(cur_mat_C3,2));%ms: added these two lines, because there were NaN in dataset
        cur_mat_C3 = cur_mat_C3(inds,:);
        cur_IDs_C3 = cur_IDs_C3(inds);
        
     catch 
        cur_mat_C3=nan;
        cur_IDs_C3=nan;

    end 


%positive correlation with stimulus C2
if ~sum(sum(isnan(cur_mat_C2)))
    Q_C2 = corr(mean(mCsplitGal4_C2.stims)',cur_mat_C2');
    inds = find(Q_C2>0); %finds the cells whose response correlates well with the stimulus 
    cur_mat_pos_C2 = cur_mat_C2(inds,:); 
    cur_IDs_pos_C2 = cur_IDs_C2(inds);

    %calculating means across flies
    [x_pos_C2,m_pos_C2,e_pos_C2] = mean_cat_full(cur_mat_pos_C2,1,cur_IDs_pos_C2);
    %calculating the max for each trace
    max_pos_C2 = max(x_pos_C2,[],2)-1;
    
    figure(2)
    subplot(5,2,count+1); 

    t = [1:dur]/10;
    cm=colormap('lines');
    h1 = plot_err_patch_v2(cur_t,m_pos_C2,e_pos_C2,[0.75 0 0.75],[0.75 0.5 0.75]);
    legend([h1],sprintf([' "fff pos corr", N = %d ( %d )'],size(x_pos_C2,1),size(cur_mat_pos_C2,1)),...
        'location','northeast');
    plot(t, (round(mean(mCsplitGal4_C2.stims))*0.1)+0.8)
    ylim([-0.5 1.5]);
    line([0 5.5],[0 0],'color',[0 0 0]);
    set(gcf,'Color','w');
    title(['C2 ',Regions{R}])

end 

%positive correlation with stimulus C3

if ~sum(sum(isnan(cur_mat_C3)))
    Q_C3 = corr(mean(mCsplitGal4_C3.stims)',cur_mat_C3');
    inds = find(Q_C3>0); 
    cur_mat_pos_C3 = cur_mat_C3(inds,:); 
    cur_IDs_pos_C3 = cur_IDs_C3(inds);

    %calculating means across flies
    [x_pos_C3,m_pos_C3,e_pos_C3] = mean_cat_full(cur_mat_pos_C3,1,cur_IDs_pos_C3);
    %calculating the max for each trace
    max_pos_C3 = max(x_pos_C3,[],2)-1;

    figure(2)
    subplot(5,2,count+2); 

    t = [1:dur]/10;
    cm=colormap('lines');
    h1 = plot_err_patch_v2(cur_t,m_pos_C3,e_pos_C3,[0 0.5 0],[0.5 0.85 0.5]);
    legend([h1],sprintf([' "fff pos corr", N = %d ( %d )'],size(x_pos_C3,1),size(cur_mat_pos_C3,1)),...
        'location','northeast');
    plot(t, (round(mean(mCsplitGal4_C3.stims))*0.1)+0.8)
    ylim([-0.5 1.5]);
    line([0 5.5],[0 0],'color',[0 0 0]);
    set(gcf,'Color','w');
    title(['C3 ',Regions{R}])

end 

count=count+2;
end 




