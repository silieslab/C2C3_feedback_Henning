
function Av_STRF=Average_STRFs(RF_DATA,NCon,Predicition_thres2,Rel_thres,Weighted)


AllSTRFs_T4_L1=[];  AllSTRFs_T5_L1=[];

AllSTRFs_T4_L2=[];  AllSTRFs_T5_L2=[];

AllSTRFs_T4_L3=[];  AllSTRFs_T5_L3=[];

AllSTRFs_T4_L4=[];  AllSTRFs_T5_L4=[];



DATAi= RF_DATA{1,NCon};

for iFly=1:length(DATAi.DATA)
    
    Corr_Az=[];
    Corr_El=[];
    
    RFCenter_Az=[];
    RFCenter_El=[];
    
    
    if isfield(DATAi.DATA{1,iFly},'Az')
        
        AllRF=DATAi.DATA{1,iFly}.Az.STRFs;
        CellT=DATAi.DATA{1,iFly}.Az.T4T5;
        LayerT=DATAi.DATA{1,iFly}.Az.Layer;
        
        for NRF=1:size(AllRF,1)
            Corrcoef=DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF);
            RELi=DATAi.DATA{1,iFly}.Az.REL(NRF);

            if Corrcoef>=Predicition_thres2 && RELi>=Rel_thres
                RFi=(reshape(AllRF(NRF,:,:),[40,12]));
                RFi=RFi';
                RFi=flipud(RFi);
                
                [~,xp_tma]=max(max(RFi'));
                [~,xp_tmi]=min(min(RFi'));
                
                
%                    imagesc(RFi);
%                    colorbar  
%                    %%% set colormap: 
%                    newmap = b2r(min(min(RFi)),max(max(RFi)));
%                    colormap(gca, newmap)
%                    %%% 

                RFCenter_Az= mean([xp_tma,xp_tmi]);
                 
                shift=ceil(size(RFi,1)/2-RFCenter_Az);
                
                if shift>0 %shift downwards
                    RFi_cut=RFi(1:size(RFi,1)-shift,:);
                    RFi_shift=[RFi(size(RFi,1)-shift+1:size(RFi,1),:); RFi_cut]; 
                 
                
                elseif  shift<0 %shift upwards
                    shift=abs(shift);
                    RFi_cut=RFi(shift+1:size(RFi,1),:);
                    RFi_shift=[RFi_cut; RFi(1:shift,:)]; 
                    
                else 
                    RFi_shift=RFi; 
                    
                end 
                
                
                % scale the STRF contribution to the mean by its
                % correlation value (corr: pred-response)
                % AND normalize before? 
                if Weighted
                    RFi_shift=RFi_shift*double(Corrcoef)^10;
                end 
                
                
                if  CellT(NRF)==5 && LayerT(NRF)==3
                    AllSTRFs_T5_L3=cat(3,AllSTRFs_T5_L3,RFi_shift);
                 
                elseif CellT(NRF)==5 && LayerT(NRF)==4
                    AllSTRFs_T5_L4=cat(3,AllSTRFs_T5_L4,RFi_shift);
    
                elseif CellT(NRF)==4 && LayerT(NRF)==3
                    AllSTRFs_T4_L3=cat(3,AllSTRFs_T4_L3,RFi_shift);

                elseif CellT(NRF)==4 && LayerT(NRF)==4
                    AllSTRFs_T4_L4=cat(3,AllSTRFs_T4_L4,RFi_shift);                
                end
               
                
                
            end %if Corrcoef
        end %NRF
        
    end %field AZ
    
    if isfield(DATAi.DATA{1,iFly},'El')
        
        AllRF=DATAi.DATA{1,iFly}.El.STRFs;
        CellT=DATAi.DATA{1,iFly}.El.T4T5;
        LayerT=DATAi.DATA{1,iFly}.El.Layer;
        
        for NRF=1:size(AllRF,1)
            Corrcoef=DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF);
            RELi=DATAi.DATA{1,iFly}.El.REL(NRF);
            
            if Corrcoef>=Predicition_thres2 && RELi>=Rel_thres
                RFi=(reshape(AllRF(NRF,:,:),[40,12]));
                RFi=RFi';
                
                
                [~,xp_tma]=max(max(RFi'));
                [~,xp_tmi]=min(min(RFi'));
                
                RFCenter_El= mean([xp_tma,xp_tmi]);
                 
                shift=ceil(size(RFi,1)/2-RFCenter_El);
                
                if shift>0 %shift downwards
                    RFi_cut=RFi(1:size(RFi,1)-shift,:);
                    RFi_shift=[RFi(size(RFi,1)-shift+1:size(RFi,1),:); RFi_cut]; 
                 
                
                elseif  shift<0 %shift upwards
                    shift=abs(shift);
                    RFi_cut=RFi(shift+1:size(RFi,1),:);
                    RFi_shift=[RFi_cut; RFi(1:shift,:)]; 
                    
                else 
                    RFi_shift=RFi; 
                end 
                
                % scale the STRF contribution to the mean by its
                % correlation value (corr: pred-response)
                if Weighted
                    RFi_shift=RFi_shift*double(Corrcoef)^10;
                end 
                
                 
                if  CellT(NRF)==5 && LayerT(NRF)==1
                    AllSTRFs_T5_L1=cat(3,AllSTRFs_T5_L1,RFi_shift);
                 
                elseif CellT(NRF)==5 && LayerT(NRF)==2
                    AllSTRFs_T5_L2=cat(3,AllSTRFs_T5_L2,RFi_shift);
    
                elseif CellT(NRF)==4 && LayerT(NRF)==1
                    AllSTRFs_T4_L1=cat(3,AllSTRFs_T4_L1,RFi_shift);

                elseif CellT(NRF)==4 && LayerT(NRF)==2
                    AllSTRFs_T4_L2=cat(3,AllSTRFs_T4_L2,RFi_shift);                
                end
                
                
            end
        end
        
    end
    
end


figure('Position', [500 400 1100 390]);

subplot(2,4,1)
try
    imagesc(mean(AllSTRFs_T4_L1,3));
    colorbar
    newmap = b2r(min(min(mean(AllSTRFs_T4_L1,3))),max(max(mean(AllSTRFs_T4_L1,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Left'},{'Right'}])
    set(gca, 'FontSize', 12)
    title(['T4 Layer1 (N=', num2str(size(AllSTRFs_T4_L1,3)),')'])
end


% % 
subplot(2,4,5)
try
    imagesc(mean(AllSTRFs_T5_L1,3));
    colorbar
    newmap = b2r(min(min(mean(AllSTRFs_T5_L1,3))),max(max(mean(AllSTRFs_T5_L1,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Left'},{'Right'}])
    set(gca, 'FontSize', 12)
    title(['T5 Layer1 (N=', num2str(size(AllSTRFs_T5_L1,3)),')'])
end

subplot(2,4,2)
try
imagesc(mean(AllSTRFs_T4_L2,3));
colorbar
    newmap = b2r(min(min(mean(AllSTRFs_T4_L2,3))),max(max(mean(AllSTRFs_T4_L2,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Left'},{'Right'}])
    set(gca, 'FontSize', 12)
    title(['T4 Layer2 (N=', num2str(size(AllSTRFs_T4_L2,3)),')'])
end

subplot(2,4,6)
try
    imagesc(mean(AllSTRFs_T5_L2,3));
    colorbar
    newmap = b2r(min(min(mean(AllSTRFs_T5_L2,3))),max(max(mean(AllSTRFs_T5_L2,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Left'},{'Right'}])
    set(gca, 'FontSize', 12)
    title(['T5 Layer2 (N=', num2str(size(AllSTRFs_T5_L2,3)),')'])
end

subplot(2,4,3)
try
    imagesc(mean(AllSTRFs_T4_L3,3));
    colorbar
    newmap = b2r(min(min(mean(AllSTRFs_T4_L3,3))),max(max(mean(AllSTRFs_T4_L3,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Up'},{'Down'}])
    set(gca, 'FontSize', 12)
    title(['T4 Layer3 (N=', num2str(size(AllSTRFs_T4_L3,3)),')'])
end

subplot(2,4,7)
try
    imagesc(mean(AllSTRFs_T5_L3,3));
    colorbar
    newmap = b2r(min(min(mean(AllSTRFs_T5_L3,3))),max(max(mean(AllSTRFs_T5_L3,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Up'},{'Down'}])
    set(gca, 'FontSize', 12)
    title(['T5 Layer3 (N=', num2str(size(AllSTRFs_T5_L3,3)),')'])
end

subplot(2,4,4)
try
    imagesc(mean(AllSTRFs_T4_L4,3));
    colorbar
    newmap = b2r(min(min(mean(AllSTRFs_T4_L4,3))),max(max(mean(AllSTRFs_T4_L4,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Up'},{'Down'}])
    set(gca, 'FontSize', 12)
    title(['T4 Layer4 (N=', num2str(size(AllSTRFs_T4_L4,3)),')'])
end

subplot(2,4,8)
try
    imagesc(mean(AllSTRFs_T5_L4,3));
    colorbar
    newmap = b2r(min(min(mean(AllSTRFs_T5_L4,3))),max(max(mean(AllSTRFs_T5_L4,3))));
    colormap(gca, newmap)
    set(gca, 'xtick', [1 20 40])
    set(gca, 'xtickLabel', [-2 -1 0])
    xlabel('time [s]')
    set(gca, 'ytick', [1 12])
    set(gca, 'ytickLabel', [{'Up'},{'Down'}])
    set(gca, 'FontSize', 12)
    title(['T5 Layer4 (N=', num2str(size(AllSTRFs_T5_L4,3)),')'])
end

Av_STRF.AllSTRFs_T4_L1=AllSTRFs_T4_L1; 
Av_STRF.AllSTRFs_T5_L1=AllSTRFs_T5_L1;
Av_STRF.AllSTRFs_T4_L2=AllSTRFs_T4_L2; 
Av_STRF.AllSTRFs_T5_L2=AllSTRFs_T5_L2;
Av_STRF.AllSTRFs_T4_L3=AllSTRFs_T4_L3; 
Av_STRF.AllSTRFs_T5_L3=AllSTRFs_T5_L3;
Av_STRF.AllSTRFs_T4_L4=AllSTRFs_T4_L4; 
Av_STRF.AllSTRFs_T5_L4=AllSTRFs_T5_L4;


