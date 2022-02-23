
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
addpath(genpath('subscripts'))
% ___________

Save_STRFs=0; 
Predicition_thres=0.2;
Rel_thres=0.1;

Conditions={'Control','C3Kir', 'C2Kir'};%, 'C3Kir', 'C2Kir','T4C'};



%% 

RF_DATA=load('Data/RF_DATA_new_191029.mat');
RF_DATA=RF_DATA.RF_DATA_new; 
    

%% Collect Data and Plot Suppl.Fig.3a:
Conditions={'Control','C3Kir', 'C2Kir'};
Corr_sum=[];
Corri=[];


for NCon=1:length(RF_DATA)
Corri_T4=[];
Corri_T5=[];

    DATAi= RF_DATA{1,NCon};   
    Corr=[];
    REL=[]; %reliability 
    

    for iFly=1:length(DATAi.DATA)
        if isfield(DATAi.DATA{1,iFly},'Az')

           AllRF=DATAi.DATA{1,iFly}.Az.STRFs; 
           for NRF=1:size(AllRF,1) 
            Corr_sum=[Corr_sum,DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF)];
            Corr=[Corr,DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF)];
            REL=[REL,DATAi.DATA{1,iFly}.Az.REL(NRF)];

            if DATAi.DATA{1,iFly}.Az.T4T5(NRF)==5
                Corri_T5=[Corri_T5,DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF)];
            elseif  DATAi.DATA{1,iFly}.Az.T4T5(NRF)==4
                Corri_T4=[Corri_T4,DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF)];
            end

           end 

        end 

        if isfield(DATAi.DATA{1,iFly},'El')

           AllRF=DATAi.DATA{1,iFly}.El.STRFs; 
           for NRF=1:size(AllRF,1); 
            Corr_sum=[Corr_sum,DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF)];
            Corr=[Corr,DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF)];
            REL=[REL,DATAi.DATA{1,iFly}.El.REL(NRF)];

             if DATAi.DATA{1,iFly}.El.T4T5(NRF)==5
                Corri_T5=[Corri_T5,DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF)];
            elseif  DATAi.DATA{1,iFly}.El.T4T5(NRF)==4
                Corri_T4=[Corri_T4,DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF)];
            end

           end 

        end  
        
        if isfield(DATAi.DATA{1,iFly},'El_s')

           AllRF=DATAi.DATA{1,iFly}.El_s.STRFs; 
           for NRF=1:size(AllRF,1) 
            Corr_sum=[Corr_sum,DATAi.DATA{1,iFly}.El_s.corrcoefs(1,NRF)];
            Corr=[Corr,DATAi.DATA{1,iFly}.El_s.corrcoefs(1,NRF)];
             if DATAi.DATA{1,iFly}.El_s.T4T5(NRF)==5
                Corri_T5=[Corri_T5,DATAi.DATA{1,iFly}.El_s.corrcoefs(1,NRF)];
            elseif  DATAi.DATA{1,iFly}.El_s.T4T5(NRF)==4
                Corri_T4=[Corri_T4,DATAi.DATA{1,iFly}.El_s.corrcoefs(1,NRF)];
            end

           end 

        end  
        
         if isfield(DATAi.DATA{1,iFly},'Dg_LU')

           AllRF=DATAi.DATA{1,iFly}.Dg_LU.STRFs; 
           for NRF=1:size(AllRF,1); 
            Corr_sum=[Corr_sum,DATAi.DATA{1,iFly}.Dg_LU.corrcoefs(1,NRF)];
            Corr=[Corr,DATAi.DATA{1,iFly}.Dg_LU.corrcoefs(1,NRF)];
             if DATAi.DATA{1,iFly}.Dg_LU.T4T5(NRF)==5
                Corri_T5=[Corri_T5,DATAi.DATA{1,iFly}.Dg_LU.corrcoefs(1,NRF)];
            elseif  DATAi.DATA{1,iFly}.Dg_LU.T4T5(NRF)==4
                Corri_T4=[Corri_T4,DATAi.DATA{1,iFly}.Dg_LU.corrcoefs(1,NRF)];
            end

           end 

        end  
    end  
    
    Corri{NCon}=Corr;
   


PerC=round(length(find((Corr>=Predicition_thres).*(REL>=Rel_thres)))/length(Corr)*100,2);

figure; 
scatter(Corr,REL)
xlabel('Corr Pred-real Response')
ylabel('Reliability- Corr First-Second Stimulus Epoch')
[rho,p]=corr(Corr',REL');
set(gca,'YLim', [-0.4 0.6]);
set(gca,'XLim', [0.05 0.5]);

text(0.1,0.5, ['Rho=', num2str(rho), '  p=', num2str(p)])
text(0.1,0.45, ['% valid STRFs=', num2str(PerC)])

% [r,m,b] = regression(Corr,REL);
% hold on 
% linearpred=m*Corr+b;
% line(Corr,linearpred,'Color','k')

line([Predicition_thres Predicition_thres],[-0.4 0.4], 'Color', 'r', 'LineStyle', ':')
line([0.1 0.35],[Rel_thres Rel_thres], 'Color', 'r', 'LineStyle', '--')
title([Conditions{NCon}]) 

end    




%% Plot receptive fields for each neuron

% cm=[59,235,53]/255;
%  
% for NCon=1:length(RF_DATA)
%     COND=Conditions{NCon}; 
%     DATAi= RF_DATA{1,NCon};   
% 
% 
%     for iFly=1:length(DATAi.DATA)
%         if isfield(DATAi.DATA{1,iFly},'Az')
% 
%            AllRF=DATAi.DATA{1,iFly}.Az.STRFs; 
%            
%            for NRF=1:size(AllRF,1)
% %                close all
%               
%                Corrcoef=DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF);
%                RELi=DATAi.DATA{1,iFly}.Az.REL(NRF);
% 
%             
%             if Corrcoef>=Predicition_thres && RELi>=Rel_thres
%               % Plot this RF only if the Corrcoef of prediction vs. real ROI response is bigger than the threshold! 
%                    % The threshold was chosen based on visualisation of corr values in a histogram       
%                    F1=figure;
%                    set(F1,'Position',[600 600 800 300])
%                    
%                    T4T5i=DATAi.DATA{1,iFly}.Az.T4T5(NRF);   % I already assign the correct values when loading the data (mh, 01.07.19)
%                    Layeri=DATAi.DATA{1,iFly}.Az.Layer(NRF);
% 
%                    subplot(1,2,2)
%                    RFi=(reshape(AllRF(NRF,:,:),[40,12]));
%                    RFi=RFi'; 
%                    RFi=flipud(RFi);  % Check if correct!! 
%                    % For fitgmdist I have to transform the RF into an array
%                    % of 3columns 
% %                    [X,Y]=find(RFi);
% %                    Z=RFi(X,Y);
%                    % GMModel = fitgmdist(RFi',2);
%                    
%                    imagesc(RFi);
%                    colorbar
% %                     caxis([ScMin ScMax])
%                    title([COND, '- ',DATAi.DATA{1,iFly}.Flyname(1:6),'-', DATAi.DATA{1,iFly}.Flyname(8:11), '  -  Az' ])
%                    
%                    %%% set colormap: 
%                    newmap = b2r(min(min(RFi)),max(max(RFi)));
%                    colormap(gca, newmap)
%                    %%% 
%                    
%                    set(gca, 'xtick', [1 20 40])
%                    set(gca, 'xtickLabel', [-2 -1 0])
%                    xlabel('time [s]')
%                    set(gca, 'ytick', [1 12])
%                    set(gca, 'ytickLabel', [{'Up'},{'Down'}])
%                    set(gca, 'FontSize', 12)    
%                    text(3,11, ['PredCorr = ', num2str(Corrcoef)])
%                    text(3,12, ['Reliability = ', num2str(RELi)])
% 
%                    subplot(1,2,1)
%                    imagesc(DATAi.DATA{1,iFly}.Az.AV)
%                 %  imshow(DATAi.DATA{1,iFly}.Az.AV)
% 
%                    colormap(gca,'gray')
% 
%                    title(['T', num2str(T4T5i), '- Layer ', num2str(Layeri), '  ROI-index=', num2str(NRF) ])
%                    hold on 
%                    mask=DATAi.DATA{1,iFly}.Az.Cluster{1,NRF};
%                    CMask=cat(3,cm(1).*(mask),cm(2).*(mask),cm(3).*(mask));
%                    h=imagesc(CMask);
%                 %  h=imshow(CMask);
% 
%                    set(h,'AlphaData',0.3);
%                    set(gca, 'FontSize', 12)    
%                    set(gca, 'ytick', [])
%                    set(gca, 'xtick', [])        
% 
% 
%                end %if corr 
%            end % for all RFs
% 
%         end  %if isfield AZ 
% 
%         
%         
%         if isfield(DATAi.DATA{1,iFly},'El')
% 
%            AllRF=DATAi.DATA{1,iFly}.El.STRFs; 
%            for NRF=1:size(AllRF,1)
% %                close all 
%                
%                Corrcoef=DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF);
%                  RELi=DATAi.DATA{1,iFly}.El.REL(NRF);
% 
%                if Corrcoef>=Predicition_thres && RELi>=Rel_thres % Plot this RF only if the Corrcoef of prediction vs. real ROI response is bigger than the threshold! 
%                    % The threshold was chosen based on visualisation of corr values in a histogram       
%                    F1=figure; hold on
%                    set(F1,'Position',[600 600 800 300])
%                    
% %                    ROIind=DATAi.DATA{1,iFly}.El.roi_ind(NRF)+1;
%                    T4T5i=DATAi.DATA{1,iFly}.El.T4T5(NRF);
%                    Layeri=DATAi.DATA{1,iFly}.El.Layer(NRF);
% 
%                    subplot(1,2,2)
%                    RFi=(reshape(AllRF(NRF,:,:),[40,12]));
%                    RFi=RFi'; 
% 
%                    imagesc(RFi);
%                    colorbar
% %                     caxis([ScMin ScMax])
%                    title([COND, '- ',DATAi.DATA{1,iFly}.Flyname(1:6),'-', DATAi.DATA{1,iFly}.Flyname(8:11), '  -  El' ])
%                    
%                    %%% set colormap: 
%                    newmap = b2r(min(min(RFi)),max(max(RFi)));
%                    colormap(gca, newmap)
%                    %%% 
%                    
%                    set(gca, 'xtick', [1 20 40])
%                    set(gca, 'xtickLabel', [-2 -1 0])
%                    xlabel('time [s]')
%                    set(gca, 'ytick', [1 12])
%                    set(gca, 'ytickLabel', [{'Left'},{'Right'}])
%                    set(gca, 'FontSize', 12)    
%                    text(3,11, ['PredCorr = ', num2str(Corrcoef)])
%                    text(3,12, ['Reliability = ', num2str(RELi)])
% 
%                    subplot(1,2,1)
%                    imagesc(DATAi.DATA{1,iFly}.El.AV)
%                 %  imshow(DATAi.DATA{1,iFly}.Az.AV)
% 
%                    colormap(gca,'gray')
% 
%                    title(['T', num2str(T4T5i), '- Layer ', num2str(Layeri), '  ROI-index=', num2str(NRF) ])
%                    hold on 
%                    mask=DATAi.DATA{1,iFly}.El.Cluster{1,NRF};
%                    CMask=cat(3,cm(1).*(mask),cm(2).*(mask),cm(3).*(mask));
%                    h=imagesc(CMask);
%                 %  h=imshow(CMask);
% 
%                    set(h,'AlphaData',0.3);
%                    set(gca, 'FontSize', 12)    
%                    set(gca, 'ytick', [])
%                    set(gca, 'xtick', [])        
% 
%                end % and if corr
% 
%            end  % end loop RFs
% 
%         end %if field El 
% 
%     end  % end loop NFly 
% end    % end loop NCon 
% 
% 


%% Run average function 
% Predicition_thres2=0.1%0.22;
% Rel_thres=0.1;
Weighted=true; 

%Control
Av_STRF=Average_STRFs(RF_DATA,1,Predicition_thres,Rel_thres,Weighted);
Norm=true;
Plot_GaussFit_On_Av(Av_STRF,Norm)

%C3Sil
Av_STRF=Average_STRFs(RF_DATA,2,Predicition_thres,Rel_thres,Weighted);
Norm=true;
Plot_GaussFit_On_Av(Av_STRF,Norm)

%C2Sil
Av_STRF=Average_STRFs(RF_DATA,3,Predicition_thres,Rel_thres,Weighted);
Norm=true;
Plot_GaussFit_On_Av(Av_STRF,Norm)

%% Run fitting skript: 

NCon=1;
[GausfitInfo,DATAi_wFit]=Fit_Gauss(RF_DATA,NCon, false,Predicition_thres,Rel_thres);

NCon=2;
[GausfitInfoC3sil,DATAi_wFitC3Sil]=Fit_Gauss(RF_DATA,NCon, false,Predicition_thres,Rel_thres);

NCon=3;
[GausfitInfoC2sil,DATAi_wFitC2Sil]=Fit_Gauss(RF_DATA,NCon, false,Predicition_thres,Rel_thres);

% Plot the averages of STRFs again BUT with the additional info of the
% goodness of the fit. Discard STRFs with a fit below 0.5 
RF_DATA_new=RF_DATA;
RF_DATA_new{1}=DATAi_wFit;
RF_DATA_new{2}=DATAi_wFitC3Sil;
RF_DATA_new{3}=DATAi_wFitC2Sil;

% Now plot again but as box plots 
Fit_thresT4=0.3;
Fit_thresT5=0.3;

%If only two conditions: plot_GaussFit_statistics(GausfitInfo,GausfitInfoC3sil, Fit_thresT4,Fit_thresT5)
%For all three conditions:
plot_GaussFit_statistics2(GausfitInfo,GausfitInfoC2sil,GausfitInfoC3sil, Fit_thresT4,Fit_thresT5)



