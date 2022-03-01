
%% This skript unpacks and loads the rezeptive field python(npz) data
%  Plots the receptive fields


% predictions = response prediction based on RF
%   pred1 = for first epoch
%   pred2= for second epoch , ... predictions can slightly vary because of
%                   frames in stim that might be skipped...
% stas = receptive fields
% corrcoefs= correlation of the predicted response and real response



clear all
close all

% ___________

Save_STRFs=1;
Predicition_thres=0;
Rel_thres=0.1;



Conditions={'C2','C3'};%, 'C3Kir', 'C2Kir','T4C'};

filesource='Data/STRFs/RF_DATA_C2C3';


%____________
addpath(genpath('subscripts'))

load('Data/colormap_RF.mat')


%% Load DATA

RF_DATA=load(filesource);
RF_DATA=RF_DATA.RF_DATA; 


% % %% Now that I have all data together I want to plot the rezeptive fields
% % 
% % % NOW PLOT!!
% % 
% % cm=[59,235,53]/255;
% % 
% % 
% % for NCon=1:length(RF_DATA)
% %     COND=Conditions{NCon};
% %     DATAi= RF_DATA{1,NCon};
% %     
% %     MaxinTimeAz=[];
% %     MaxinTimeEl=[];
% %     
% %     Corrcoef_all_Az=[];
% %     Corrcoef_all_El=[];
% %     
% %     for iFly=1:length(DATAi.DATA)
% %         
% %         
% %         if isfield(DATAi.DATA{1,iFly},'Az')
% %             NROIs=size(DATAi.DATA{1,iFly}.Az.STRFs,1);
% %             MaskSize=size(DATAi.DATA{1,iFly}.Az.Cluster{1,1});
% %         elseif isfield(DATAi.DATA{1,iFly},'El')
% %             NROIs=size(DATAi.DATA{1,iFly}.El.STRFs,1);
% %             MaskSize=size(DATAi.DATA{1,iFly}.El.Cluster{1,1});
% %         end
% %         
% %         SpRF_Az=[];
% %         SpRF_El=[];
% %         Mask_all=zeros(MaskSize);
% %         
% %         for NRF=1:NROIs
% %             %                close all
% %             
% % %             F1=figure;
% % %             set(F1,'Position',[600 600 1200 300])
% % %             subplot(1,4,1)
% %             
% %             if isfield(DATAi.DATA{1,iFly},'Az')
% %                 ROIi=DATAi.DATA{1,iFly}.Az.AV;
% %                 mask=DATAi.DATA{1,iFly}.Az.Cluster{1,NRF};
% %                 
% %             elseif isfield(DATAi.DATA{1,iFly},'El')
% %                 ROIi=DATAi.DATA{1,iFly}.El.AV;
% %                 mask=DATAi.DATA{1,iFly}.El.Cluster{1,NRF};
% %             end
% % %             Mask_all=(Mask_all+mask*NRF);
% %             
% % %             imagesc(ROIi)
% % %             colormap(gca,'gray')
% % %             hold on
% % %             CMask=cat(3,cm(1).*(mask),cm(2).*(mask),cm(3).*(mask));
% % %             h=imagesc(CMask);
% % %             
% % %             set(h,'AlphaData',0.3);
% % %             set(gca, 'FontSize', 12)
% % %             set(gca, 'ytick', [])
% % %             set(gca, 'xtick', [])
% %             
% % %             subplot(1,4,2)
% %             
% %             if isfield(DATAi.DATA{1,iFly},'Az')
% %                 Corrcoef=DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF);
% %                 AllRFAz=DATAi.DATA{1,iFly}.Az.STRFs;
% %                 
% %                 if Corrcoef>=Predicition_thres %&& RELi>=Rel_thres
% %                     % Plot this RF only if the Corrcoef of prediction vs. real ROI response is bigger than the threshold!
% %                     % The threshold was chosen based on visualisation of corr values in a histogram
% %                     
% %                     RFi=(reshape(AllRFAz(NRF,:,:),[40,12]));
% %                     RFi=RFi';
% %                     RFi=flipud(RFi);  % Check if correct!!
% %                     
% % %                     imagesc(RFi);
% % %                     colorbar
% %                     %                     caxis([ScMin ScMax])
% % %                     title([COND, '- ',DATAi.DATA{1,iFly}.Flyname(1:6),'-', DATAi.DATA{1,iFly}.Flyname(8:11), '  -  Az' ])
% %                     
% %                     %%% set colormap:
% % %                     newmap = b2r(min(min(RFi)),max(max(RFi)));
% % %                     colormap(gca, newmap)
% %                     %%%
% %                     
% % %                     set(gca, 'xtick', [1 20 40])
% % %                     set(gca, 'xtickLabel', [-2 -1 0])
% % %                     xlabel('time [s]')
% % %                     set(gca, 'ytick', [1 12])
% % %                     set(gca, 'ytickLabel', [{'Up'},{'Down'}])
% % %                     set(gca, 'FontSize', 12)
% % %                     text(3,11, ['PredCorr = ', num2str(Corrcoef)])
% %                     %                    text(3,12, ['Reliability = ', num2str(RELi)])
% %                     [~,Mind]=max(max(RFi)); %get the time point of highest corr
% %                     SpRF_Az=[SpRF_Az, RFi(:,Mind)];
% %                     MaxinTimeAz=[MaxinTimeAz,Mind];
% %                     Corrcoef_all_Az=[Corrcoef_all_Az,Corrcoef]
% %                 end
% %             end
% %             
% %             subplot(1,4,3)
% %             if isfield(DATAi.DATA{1,iFly},'El')
% %                 try %in the case that I have more ROIs for Az than for El which could have happened accidentally while selecting ROIS manually)
% %                     Corrcoef=DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF);
% %                     AllRFEl=DATAi.DATA{1,iFly}.El.STRFs;
% %                     if Corrcoef>=Predicition_thres
% % 
% %                         RFi=(reshape(AllRFEl(NRF,:,:),[40,12]));
% %                         RFi=RFi';
% % 
% %                         imagesc(RFi);
% %                         colorbar
% %                         %                     caxis([ScMin ScMax])
% %                         title( '  -  El' )
% % 
% %                         %%% set colormap:
% %                         newmap = b2r(min(min(RFi)),max(max(RFi)));
% %                         colormap(gca, newmap)
% %                         %%%
% % 
% %                         set(gca, 'xtick', [1 20 40])
% %                         set(gca, 'xtickLabel', [-2 -1 0])
% %                         xlabel('time [s]')
% %                         set(gca, 'ytick', [1 12])
% %                         set(gca, 'ytickLabel', [{'Left'},{'Right'}])
% %                         set(gca, 'FontSize', 12)
% %                         text(3,11, ['PredCorr = ', num2str(Corrcoef)])
% %                         %                    text(3,12, ['Reliability = ', num2str(RELi)])
% %                         [~,Mind]=max(max(RFi)); %get the time point of highest corr
% %                         SpRF_El=[SpRF_El, RFi(:,Mind)];
% %                         MaxinTimeEl=[MaxinTimeEl,Mind];
% %                         Corrcoef_all_El=[Corrcoef_all_El,Corrcoef];
% % 
% %                     end
% %                 end
% %             end
% %             subplot(1,4,4)
% %             if isfield(DATAi.DATA{1,iFly},'El') &&isfield(DATAi.DATA{1,iFly},'Az')
% %                 SpatialRF=SpRF_El(:,end)*SpRF_Az(:,end)'; % to always take the Values of the last added, so the actual ROI 
% %                 imagesc(SpatialRF)
% %                 colorbar
% %                 newmap = b2r(min(min(SpatialRF)),max(max(SpatialRF)));
% %                 colormap(gca, newmap)
% %                 %%%
% %                 set(gca, 'xtick', [1 12])
% %                 set(gca, 'xtickLabel', [{'Up'},{'Down'}])
% %                 set(gca, 'ytick', [1 12])
% %                 set(gca, 'ytickLabel', [{'Left'},{'Right'}])
% %                 set(gca, 'FontSize', 12)
% %                 
% %             end
% %             
% %         end %NROIs
% %         
% %         
% %         %Plot the spatial RF at maximum time point for all ROIs
% %         
% %         F2=figure('Position',[600 600 800 300]);
% %         subplot(1,3,1)
% %         
% %         imagesc(ROIi)
% %         colormap(gca,'gray')
% %         hold on
% %         Mask_alli=Mask_all*0.3;
% %         CMask=cat(3,cm(1).*(Mask_alli),cm(2).*(Mask_alli),cm(3).*(Mask_alli));
% %         h=imagesc(CMask);
% %         set(h,'AlphaData',0.4);
% %         set(gca, 'FontSize', 12)
% %         set(gca, 'ytick', [])
% %         set(gca, 'xtick', [])
% %         
% %         subplot(1,3,2)
% %         SpRF_Az=fliplr(SpRF_Az);
% %         imagesc(SpRF_Az);
% %         colorbar
% %         newmap = b2r(min(min(RFi)),max(max(RFi)));
% %         colormap(gca, newmap)
% %         title('Spatial RF at maximum correlation - Az')
% %         xlabel('# ROI')
% %         set(gca, 'ytick', [1 12])
% %         set(gca, 'ytickLabel', [{'Up'},{'Down'}])
% %         set(gca, 'FontSize', 12)
% %         
% %         
% %         subplot(1,3,3)
% %         SpRF_El=fliplr(SpRF_El);
% %         imagesc(SpRF_El);
% %         colorbar
% %         newmap = b2r(min(min(RFi)),max(max(RFi)));
% %         colormap(gca, newmap)
% %         title('- El')
% %         xlabel('# ROI')
% %         set(gca, 'ytick', [1 12])
% %         set(gca, 'ytickLabel', [{'Left'},{'Right'}])
% %         set(gca, 'FontSize', 12)
% %         
% %         set(F2,'PaperSize', [ 30 15])
% %         if Save_STRFs
% %             print(['/Users/mhennin2/Documents/2p-imaging/RF-Analysis_Results/C2C3/RFplots/',COND, '_STRF_',DATAi.DATA{1,iFly}.Flyname(1:6), '_',DATAi.DATA{1,iFly}.Flyname(8:11),'-Az-El-AllROis'],'-dpdf','-r0')
% %         end
% %         
% %         
% %     end % for all Flys
% %     %
% %     Correlation_ALL{NCon}.MaxinTimeAz=MaxinTimeAz;
% %     Correlation_ALL{NCon}.MaxinTimeEl=MaxinTimeEl;
% %     Correlation_ALL{NCon}.Corrcoef_all_Az=Corrcoef_all_Az;
% %     Correlation_ALL{NCon}.Corrcoef_all_El=Corrcoef_all_El;
% %     
% % end  % for all Cond
% % 
% % 
% % % Quantify the maximum correlation timepoint for all STRFs overcoing the
% % % pred corr coef of 0.22: 
% % %For C2: 
% % % MaximumCorrTime_Az=mean(Correlation_ALL{1}.MaxinTimeAz(Correlation_ALL{1}.Corrcoef_all_Az>=0.28));
% % % MaximumCorrTime_El=mean(Correlation_ALL{1}.MaxinTimeEl(Correlation_ALL{1}.Corrcoef_all_El>=0.28));
% % 
% % % To get the changed colormap!!!
% % 
% % % cmap_max = colormap(gca);
% % % colormap(cmap_max)

%% quantify pos and negative lobe


Predicition_thres=0.26;
NCON=1;
[TimingC2,timeElC2,timeAzC2]=Plot_timeSectionSTRFC2C3_gh(RF_DATA, NCON,Predicition_thres,[0.75 0 0.75]);

NCON=2;
[TimingC3,timeElC3,timeAzC3]=Plot_timeSectionSTRFC2C3_gh(RF_DATA, NCON,Predicition_thres,[0 0.5 0]);
%

Timing_All_El=nan(2,100);
Timing_All_Az=nan(2,100);

Timing_All_El(1,1:length(timeElC2))=timeElC2; 
Timing_All_El(2,1:length(timeElC3))=timeElC3; 

Timing_All_Az(1,1:length(timeAzC2))=timeAzC2; 
Timing_All_Az(2,1:length(timeAzC3))=timeAzC3; 


figure('Position', [400 400 250 600]); 
subplot(2,1,2)
bar(nanmean(Timing_All_El,2))
set(gca,'XTickLabel', {'C2','C3'})
hold on ; errorbar([1,2],[nanmean(Timing_All_El,2)],[nanstd(Timing_All_El')]./sqrt([size(timeElC2,2),size(timeElC3,2)]), 'o')
ylabel('Timing of ON Peak')

title('El')

subplot(2,1,1)
bar(nanmean(Timing_All_Az,2))
set(gca,'XTickLabel', {'C2','C3'})
hold on ; errorbar([1,2],[nanmean(Timing_All_Az,2)],[nanstd(Timing_All_Az')]./sqrt([size(timeAzC2,2),size(timeAzC2,2)]), 'o')
title('Az')
ylabel('Timing of ON Peak')



% [h,p]=ttest2(timeAzC2,timeAzC3);

[p,h] = ranksum(timeElC2,timeElC3)
[p,h] = ranksum(timeAzC2,timeAzC3)

% Plot_SpatialExtend_STRFC2C3(RF_DATA, NCON,Predicition_thres)

%% Run average function
Predicition_thres=0.26%0.22;
% Rel_thres=0.1;
Weighted=true;
NCon=1; 
[Av_STRF,SpEx_Az_Max,SpEx_El_Max]=Average_STRFsC2C3(RF_DATA,NCon,Predicition_thres,Rel_thres,Weighted);

FWHM_C2=Gaussian_Fit_C2C3(SpEx_Az_Max,SpEx_El_Max);


NCon=2; 
[Av_STRF,SpEx_Az_Max,SpEx_El_Max]=Average_STRFsC2C3(RF_DATA,NCon,Predicition_thres,Rel_thres,Weighted);

FWHM_C3=Gaussian_Fit_C2C3(SpEx_Az_Max,SpEx_El_Max);

nanmean(FWHM_C2')
nanstd(FWHM_C2')

nanmean(FWHM_C3')
nanstd(FWHM_C3')


figure('Position', [400 400 250 600]); 

subplot(2,1,1)
bar(nanmean([FWHM_C2(1,:);FWHM_C3(1,:)],2))
set(gca,'XTickLabel', {'C2','C3'})
hold on ; errorbar([1,2],[nanmean([FWHM_C2(1,:);FWHM_C3(1,:)],2)],[nanstd([FWHM_C2(1,:);FWHM_C3(1,:)]')]./sqrt([size([FWHM_C2(1,:);FWHM_C3(1,:)],2),size([FWHM_C2(1,:);FWHM_C3(1,:)],2)]), 'o')
ylabel('FWHM')
set(gca, 'FontSize', 12) 
title('El')

subplot(2,1,2)
bar(nanmean([FWHM_C2(2,:);FWHM_C3(2,:)],2))
set(gca,'XTickLabel', {'C2','C3'})
hold on ; errorbar([1,2],[nanmean([FWHM_C2(2,:);FWHM_C3(2,:)],2)],[nanstd([FWHM_C2(2,:);FWHM_C3(2,:)]')]./sqrt([size([FWHM_C2(2,:);FWHM_C3(2,:)],2),size([FWHM_C2(2,:);FWHM_C3(2,:)],2)]), 'o')
ylabel('FWHM')
set(gca, 'FontSize', 12) 
title('Az')


[p,h] = ranksum(FWHM_C2(1,:),FWHM_C3(1,:))
[p,h] = ranksum(FWHM_C2(2,:),FWHM_C3(2,:))




