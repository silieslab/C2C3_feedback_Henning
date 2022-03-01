
function [Av_STRF,SpEx_Az_Max,SpEx_El_Max]=Average_STRFsC2C3(RF_DATA,NCon,Predicition_thres2,Rel_thres,Weighted)


AllSTRFs_Az=[];  AllSTRFs_El=[];


DATAi= RF_DATA{1,NCon};

  SpEx_Az_Max=[]; 
  SpEx_El_Max=[]; 
    
  SpEx_Az_Min=[]; 
  SpEx_El_Min=[]; 

for iFly=1:length(DATAi.DATA)
    
    Corr_Az=[];
    Corr_El=[];
    
    RFCenter_Az=[];
    RFCenter_El=[];
    
  
    
    
    if isfield(DATAi.DATA{1,iFly},'Az')
        
        AllRF=DATAi.DATA{1,iFly}.Az.STRFs;
        
        for NRF=1:size(AllRF,1)
            Corrcoef=DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF);
%             RELi=DATAi.DATA{1,iFly}.Az.REL(NRF);

            if Corrcoef>=Predicition_thres2 % && RELi>=Rel_thres
                RFi=(reshape(AllRF(NRF,:,:),[40,12]));
                RFi=RFi';
                RFi=flipud(RFi);
                
                [~,xp_tma]=max(max(RFi'));
                [~,xp_tmi]=min(min(RFi'));

                [~,tp_tma]=max(max(RFi));
                [~,tp_tmi]=min(min(RFi));
                 
                
                RFCenter_Az=xp_tma; %mean([xp_tma,xp_tmi]);
                 
                shift=ceil(size(RFi,1)/2-RFCenter_Az);
                
%                 if shift>0 %shift downwards
%                     RFi_cut=RFi(1:size(RFi,1)-shift,:);
%                     RFi_shift=[RFi(size(RFi,1)-shift+1:size(RFi,1),:); RFi_cut]; 
%                  
%                 
%                 elseif  shift<0 %shift upwards
%                     shift=abs(shift);
%                     RFi_cut=RFi(shift+1:size(RFi,1),:);
%                     RFi_shift=[RFi_cut; RFi(1:shift,:)]; 
%                     
%                 else 
%                     RFi_shift=RFi; 
%                     
%                 end 
                if shift>0 %shift downwards
                    RFi_cut=RFi(1:size(RFi,1)-shift,:);
                    RFi_shift=[zeros(shift,40); RFi_cut]; 
                 
                
                elseif  shift<0 %shift upwards
                    shift=abs(shift);
                    RFi_cut=RFi(shift+1:size(RFi,1),:);
                    RFi_shift=[RFi_cut; zeros(shift,40)]; 
                    
                else 
                    RFi_shift=RFi; 
                    
                end 
                
                SpEx_Az_Max=[SpEx_Az_Max,RFi_shift(:,tp_tma)]; 
                SpEx_Az_Min=[SpEx_Az_Min,RFi_shift(:,tp_tmi)];
                
                
                % scale the STRF contribution to the mean by its
                % correlation value (corr: pred-response)
                % AND normalize before? 
               
                
                if Weighted
                    RFi_shift=RFi_shift*double(Corrcoef)^10;
                end 
                
                 
               
%                 figure; 
%                 subplot(1,2,1) 
%                 imagesc(RFi)
%                 subplot(1,2,2)
%                 imagesc(RFi_shift)
%                 
                
                AllSTRFs_Az=cat(3,AllSTRFs_Az,RFi_shift);
                 
            end %if Corrcoef
        end %NRF
        
    end %field AZ
    
    if isfield(DATAi.DATA{1,iFly},'El')
        
        AllRF=DATAi.DATA{1,iFly}.El.STRFs;
        
        for NRF=1:size(AllRF,1)
            Corrcoef=DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF);
%             RELi=DATAi.DATA{1,iFly}.El.REL(NRF);
            
            if Corrcoef>=Predicition_thres2 %&& RELi>=Rel_thres
                RFi=(reshape(AllRF(NRF,:,:),[40,12]));
                RFi=RFi';
                
                
                [~,xp_tma]=max(max(RFi'));
                [~,xp_tmi]=min(min(RFi'));
                
                [~,tp_tma]=max(max(RFi));
                [~,tp_tmi]=min(min(RFi));
                
                RFCenter_El= xp_tma; %mean([xp_tma,xp_tmi]);
                 
                shift=ceil(size(RFi,1)/2-RFCenter_El);
                
%                 if shift>0 %shift downwards
%                     RFi_cut=RFi(1:size(RFi,1)-shift,:);
%                     RFi_shift=[RFi(size(RFi,1)-shift+1:size(RFi,1),:); RFi_cut]; 
%                  
%                 
%                 elseif  shift<0 %shift upwards
%                     shift=abs(shift);
%                     RFi_cut=RFi(shift+1:size(RFi,1),:);
%                     RFi_shift=[RFi_cut; RFi(1:shift,:)]; 
%                     
%                 else 
%                     RFi_shift=RFi; 
%                 end 
                if shift>0 %shift downwards
                    RFi_cut=RFi(1:size(RFi,1)-shift,:);
                    RFi_shift=[zeros(shift,40); RFi_cut]; 
                 
                
                elseif  shift<0 %shift upwards
                    shift=abs(shift);
                    RFi_cut=RFi(shift+1:size(RFi,1),:);
                    RFi_shift=[RFi_cut; zeros(shift,40)]; 
                    
                else 
                    RFi_shift=RFi; 
                    
                end 
                % scale the STRF contribution to the mean by its
                % correlation value (corr: pred-response)
                
                SpEx_El_Max=[SpEx_El_Max,RFi_shift(:,tp_tma)]; 
                SpEx_El_Min=[SpEx_El_Min,RFi_shift(:,tp_tmi)];
                
                if Weighted
                    RFi_shift=RFi_shift*double(Corrcoef)^10;
                end   
                

                
               AllSTRFs_El=cat(3,AllSTRFs_El,RFi_shift);
                 
                
                
                
            end
        end
        
    end
    
end

figure('Position',[600 600 800 300]);
subplot(1,2,1)
try
    imagesc(nanmean(AllSTRFs_Az,3));
    colorbar
    newmap = b2r(min(min(nanmean(AllSTRFs_Az,3))),max(max(nanmean(AllSTRFs_Az,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Left'},{'Right'}])
    set(gca, 'FontSize', 12)
    title([DATAi.name,' Az (N=', num2str(size(AllSTRFs_Az,3)),')'])
end


% % 
subplot(1,2,2)
try
    imagesc(nanmean(AllSTRFs_El,3));
    colorbar
    newmap = b2r(min(min(nanmean(AllSTRFs_El,3))),max(max(nanmean(AllSTRFs_El,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Left'},{'Right'}])
    set(gca, 'FontSize', 12)
    title([DATAi.name,' El (N=', num2str(size(AllSTRFs_El,3)),')'])
end


% Plot the spatial extend of the delayed inhibitory and the exitatory lobe 
cmap_max=load('Data/colormap_RF.mat');
cmap_max=cmap_max.cmap; 
x=[1:12]*5; %In deg 

figure
subplot(2,1,1)
plot_err_patch_v2(x, nanmean([SpEx_Az_Max],2),nanstd([SpEx_Az_Max],[],2)/sqrt(size([SpEx_Az_Max],2)),cmap_max(64,:),cmap_max(60,:));
        line([x(1) x(end)],[0 0],'color',[0 0 0],'LineStyle','--');
hold on 
plot_err_patch_v2(x, nanmean([SpEx_Az_Min],2),nanstd([SpEx_Az_Min],[],2)/sqrt(size([SpEx_Az_Min],2)),cmap_max(1,:),cmap_max(15,:));
        line([x(1) x(end)],[0 0],'color',[0 0 0],'LineStyle','--');
% plot_err_patch_v2(x, nanmean([SpEx_Az_Min+SpEx_Az_Max],2),nanstd([SpEx_Az_Min+SpEx_Az_Max],[],2)/sqrt(size([SpEx_Az_Min],2)),[0 0 0],[0.7,0.7, 0.7]);
%         line([x(1) x(end)],[0 0],'color',[0 0 0],'LineStyle','--');       
ylabel('Correlation')
xlabel('space [deg] ')
title([DATAi.name,'-Az- vertical spread'])
set(gca, 'FontSize', 12)
% set(gca, 'YLim', [-0.002 0.002])
        

subplot(2,1,2)
plot_err_patch_v2(x, nanmean([SpEx_El_Max],2),nanstd([SpEx_El_Max],[],2)/sqrt(size([SpEx_El_Max],2)),cmap_max(64,:),cmap_max(60,:));
        line([x(1) x(end)],[0 0],'color',[0 0 0],'LineStyle','--');
% set(gca, 'YLim', [-0.002 0.002])
hold on 
plot_err_patch_v2(x, nanmean([SpEx_El_Min],2),nanstd([SpEx_El_Min],[],2)/sqrt(size([SpEx_El_Min],2)),cmap_max(1,:),cmap_max(15,:));
        line([x(1) x(end)],[0 0],'color',[0 0 0],'LineStyle','--');
        
% plot_err_patch_v2(x, nanmean([SpEx_El_Min+SpEx_El_Max],2),nanstd([SpEx_El_Min+SpEx_El_Max],[],2)/sqrt(size([SpEx_El_Min],2)),[0 0 0],[0.7,0.7, 0.7]);
%         line([x(1) x(end)],[0 0],'color',[0 0 0],'LineStyle','--');

ylabel('Correlation')
xlabel('space [deg] ')
title('El- horizontal spread')
set(gca, 'FontSize', 12)

        
        

Av_STRF.AllSTRFs_Az=AllSTRFs_Az; 
Av_STRF.AllSTRFs_El=AllSTRFs_El;



