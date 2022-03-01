
function [Timing,timeEl,timeAz]=Plot_timeSectionSTRFC2C3(RF_DATA, NCON,Predicition_thres2,Rel_thres)

cmap_max=load('Data/colormap_RF.mat');

cmap_max=cmap_max.cmap; 

AvtimeL_allCon_C2_Az=nan(length(RF_DATA),80); %80 so I can put the mean and the ste trace into one matrix !! (1:40 mean), (41:80 ste)
AvtimeL_allCon_C2_EL=nan(length(RF_DATA),80);

RFCenter_Az_All_Pos=[];
RFCenter_Az_All_Neg=[];

RFCenter_El_All_Pos=[];
RFCenter_El_All_Neg=[];

Roi_loc_Az_All=[];
Roi_loc_El_All=[];

ZDepth_Az_All=[];
ZDepth_El_All=[];

for NCon=NCON%length(RF_DATA)
    % NCon=1;
    timemax_C2_Az=[];  timemax_C2_El=[];
    timemin_C2_Az=[];  timemin_C2_El=[];
    timeAv_Az=[];      timeAv_El=[]; 
    
    DATAi= RF_DATA{1,NCon};
    
    
    
    for iFly=1:length(DATAi.DATA)
        
        Corr_Az=[];
        Corr_El=[];
        
        RFCenter_Az_Pos=[];
        RFCenter_El_Pos=[];
        RFCenter_Az_Neg=[];
        RFCenter_El_Neg=[];
        
        Roi_loc_Az=[];
        Roi_loc_El=[];
        
        ZDepth_Az=[];
        ZDepth_El=[];
        
        if isfield(DATAi.DATA{1,iFly},'Az')
            
            AllRF=DATAi.DATA{1,iFly}.Az.STRFs;
            
            for NRF=1:size(AllRF,1)
                Corrcoef=DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF);
                %                 RELi=DATAi.DATA{1,iFly}.Az.REL(NRF);
                
                Roi=DATAi.DATA{1,iFly}.Az.Cluster(NRF);
                [~,Roi_loc]=find(Roi{1,1});
                if Corrcoef>=Predicition_thres2 %&& RELi>=Rel_thres
                    RFi=(reshape(AllRF(NRF,:,:),[40,12]));
                    RFi=RFi';
                    RFi=flipud(RFi);
                    
                    [~,xp_tma]=max(max(RFi'));
                    [~,xp_tmi]=min(min(RFi'));
                    
                    Corr_Az=[Corr_Az, Corrcoef];
                    RFCenter_Az_Pos=[RFCenter_Az_Pos, xp_tma];
                    RFCenter_Az_Neg=[RFCenter_Az_Neg, xp_tmi];
                    
                    Roi_loc_Az=[Roi_loc_Az,mean(Roi_loc)/size(Roi{1,1},2)];
                    ZDepth_Az=[ZDepth_Az,DATAi.DATA{1,iFly}.Az.Zdepth];
                    
                    timemax_C2_Az=[timemax_C2_Az,RFi(xp_tma,:)'];
                    timemin_C2_Az=[timemin_C2_Az,RFi(xp_tmi,:)'];
                    
                    if  xp_tma>1 && xp_tma<12
                        timeAv_Az=[timeAv_Az,mean(RFi(xp_tma-1:xp_tma+1,:),1)'];
                    elseif xp_tma==1
                        timeAv_Az=[timeAv_Az,mean(RFi(xp_tma:xp_tma+1,:),1)'];
                    elseif xp_tma==12
                        timeAv_Az=[timeAv_Az,mean(RFi(xp_tma-1:xp_tma,:),1)'];
                    end 
                    
                end %if Corrcoef
            end %NRF
            
        end %field AZ
        
        if isfield(DATAi.DATA{1,iFly},'El')
            
            AllRF=DATAi.DATA{1,iFly}.El.STRFs;
            
            for NRF=1:size(AllRF,1)
                Corrcoef=DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF);
                %                 RELi=DATAi.DATA{1,iFly}.El.REL(NRF);
                
                Roi=DATAi.DATA{1,iFly}.El.Cluster(NRF);
                [~,Roi_loc]=find(Roi{1,1});
                
                if Corrcoef>=Predicition_thres2 %&& RELi>=Rel_thres
                    RFi=(reshape(AllRF(NRF,:,:),[40,12]));
                    RFi=RFi';
                    
                    
                    [~,xp_tma]=max(max(RFi'));
                    [~,xp_tmi]=min(min(RFi'));
                    
                    Corr_El=[Corr_El, Corrcoef];
                    RFCenter_El_Pos=[RFCenter_El_Pos, xp_tma];
                    RFCenter_El_Neg=[RFCenter_El_Neg, xp_tmi];
                    
                    Roi_loc_El=[Roi_loc_El,mean(Roi_loc)/size(Roi{1,1},2)];
                    ZDepth_El=[ZDepth_El,DATAi.DATA{1,iFly}.El.Zdepth];
                    
                    timemax_C2_El=[timemax_C2_El,RFi(xp_tma,:)'];
                    timemin_C2_El=[timemin_C2_El,RFi(xp_tmi,:)'];
                    
                    if xp_tma>1 && xp_tma<12
                        timeAv_El=[timeAv_El,mean(RFi(xp_tma-1:xp_tma+1,:),1)'];
                    elseif xp_tma==1
                        timeAv_El=[timeAv_El,mean(RFi(xp_tma:xp_tma+1,:),1)'];
                    elseif xp_tma==12
                        timeAv_El=[timeAv_El,mean(RFi(xp_tma-1:xp_tma,:),1)'];
                    end 
                end
            end
            
        end
        
          
        RFCenter_Az_All_Pos=[RFCenter_Az_All_Pos,RFCenter_Az_Pos];
        RFCenter_El_All_Pos=[RFCenter_El_All_Pos,RFCenter_El_Pos];
        
        RFCenter_Az_All_Neg=[RFCenter_Az_All_Neg,RFCenter_Az_Neg];
        RFCenter_El_All_Neg=[RFCenter_El_All_Neg,RFCenter_El_Neg];
        
        Roi_loc_Az_All=[Roi_loc_Az_All,Roi_loc_Az];
        Roi_loc_El_All=[Roi_loc_El_All,Roi_loc_El];
        
        ZDepth_Az_All=[ZDepth_Az_All,ZDepth_Az];
        ZDepth_El_All=[ZDepth_El_All,ZDepth_El];
        
        
    end
    
  
 
%     figure
    [~,TM]=max(timemax_C2_El);
    [~,TM2]=max(timemax_C2_Az);
%     boxplot([t(TM),t(TM2)],'notch', 'on', 'labels', DATAi.name)
%     title('Timing of highest correlation')
    Timing=[t(TM),t(TM2)]; 
    timeEl=t((TM));
    timeAz=t(TM2);
    
    
    
    figure
    subplot(2,1,1)
    plot_err_patch_v2(t, mean([timeAv_Az],2),std([timeAv_Az],[],2)/sqrt(size([timeAv_Az],2)),[0 0 0],[0.7,0.7, 0.7]);
        line([t(1) t(end)],[0 0],'color',[0 0 0],'LineStyle','--');
    % set(gca, 'YLim', [-0.002 0.002])
    set(gca, 'XTick', [-2, -1,  0])
    ylabel('Correlation')
    set(gca, 'FontSize', 12)
    title([DATAi.name,'TimeAverage Az-  NCells=' , num2str(size([timeAv_Az],2))])
    % text(-1.8, -0.001,'T4','FontSize', 15)
    
    
    subplot(2,1,2)
    plot_err_patch_v2(t, mean([timeAv_El],2),std([timeAv_El],[],2)/sqrt(size([timeAv_El],2)),[0 0 0],[0.7,0.7, 0.7]);
    line([t(1) t(end)],[0 0],'color',[0 0 0],'LineStyle','--');
    title(['- T5'])
    set(gca, 'FontSize', 12)
    set(gca, 'XTick', [-2, -1,  0])
    title([ 'TimeAverage- El','  NCells=' , num2str(size([timeAv_El],2))])
    
    
    
    
    % Store Info in one Matrix to plot the traces for each condition together
    AvtimeL_allCon_C2_Az(NCon,1:40)=(mean([timemin_C2_Az+timemax_C2_Az],2));
    AvtimeL_allCon_C2_EL(NCon,1:40)=(mean([timemin_C2_El+timemax_C2_El],2));
    
    AvtimeL_allCon_C2_Az(NCon,41:80)=(std([timemin_C2_Az+timemax_C2_Az],[],2)/sqrt(size(timemin_C2_Az,2)));
    AvtimeL_allCon_C2_EL(NCon,41:80)=(std([timemin_C2_El+timemax_C2_El],[],2)/sqrt(size(timemin_C2_El,2)));
    
end


end
