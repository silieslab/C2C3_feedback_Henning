function Plot_Compass_SingleFlies_new(cond,condition,Foldertosave)
% Plot_Compass_SingleFlies
onedeg=2*pi/360; %in rad
theta=[90, 45, 0, 315, 270, 225, 180, 135, 90];
theta=theta*onedeg;
R_teta=[1,0,0,0,0,0,0,0];
L=sum(R_teta.*exp(1i*theta(1:end-1)))/sum(R_teta);

T4T5_mb_ON=cond.ON.T4T5_mb;
T4T5_mb_OFF=cond.OFF.T4T5_mb;
% check if same flies for ON and OFF condition


for NFlies=1:length(T4T5_mb_ON)
    Ncells_LA=0; Ncells_LB=0; Ncells_LC=0; Ncells_LD=0;
    Flyname_ON=T4T5_mb_ON(NFlies).Flyname(1:11);
    CellType='T4';
    T4T5_mb=T4T5_mb_ON;
    
    F=figure;
    P=compass(L);
    set(P, 'Visible', 'off')
    hold on
    
    title(Flyname_ON, 'FontSize', 12)
    Comp=compass(eval(['T4T5_mb(NFlies).Z.',CellType, 'A']));
    for i=1:length(Comp)
        set(Comp(i),'color',[0 .6 0]);
    end
    % title([condition,' LayerA - N Cells= ',num2str(length(eval(['T4T5_mb(NFlies).Z.',CellType, 'A'])))]);
    
    Comp=compass(eval(['T4T5_mb(NFlies).Z.',CellType, 'B']));
    for i=1:length(Comp)
        set(Comp(i),'color',[0 0 1]);
    end
    % title([condition,' LayerA - N Cells= ',num2str(length(eval(['T4T5_mb(NFlies).Z.',CellType, 'B'])))]);
    
    
    Comp=compass(eval(['T4T5_mb(NFlies).Z.',CellType, 'C']));
    for i=1:length(Comp)
        set(Comp(i),'color',[1 0 0]);
    end
    % title([condition,' LayerA - N Cells= ',num2str(length(eval(['T4T5_mb(NFlies).Z.',CellType, 'C'])))]);
    
    
    Comp=compass(eval(['T4T5_mb(NFlies).Z.',CellType, 'D']));
    for i=1:length(Comp)
        set(Comp(i),'color',[.8 .8 0]);
    end
    % title([condition,' LayerA - N Cells= ',num2str(length(eval(['T4T5_mb(NFlies).Z.',CellType, 'D'])))]);
    
    Ncells_LA=length(T4T5_mb_ON(NFlies).Z.T4A); 
    Ncells_LB=length(T4T5_mb_ON(NFlies).Z.T4B); 
    Ncells_LC=length(T4T5_mb_ON(NFlies).Z.T4C); 
    Ncells_LD=length(T4T5_mb_ON(NFlies).Z.T4D); 

    %%Plot T5 vectors on Top
    
    
    CellType='T5';
    T4T5_mb=T4T5_mb_OFF;
    
    same=nan(1,size(T4T5_mb_OFF,2));
    for NFO=1:size(T4T5_mb_OFF,2);
        Flyname_OFF=T4T5_mb_OFF(NFO).Flyname(1:11);
        same(NFO)=strcmp(Flyname_ON, Flyname_OFF)
    end
    
    
    if sum(same)==1;
        FlyOFFi=find(same);
        
        Comp=compass(eval(['T4T5_mb(FlyOFFi).Z.',CellType, 'A']));
        for i=1:length(Comp)
            set(Comp(i),'color',[0 .3 0]);
        end
        % title([condition,' LayerA - N Cells= ',num2str(length(eval(['T4T5_mb(NFlies).Z.',CellType, 'A'])))]);
        
        
        Comp=compass(eval(['T4T5_mb(FlyOFFi).Z.',CellType, 'B']));
        for i=1:length(Comp)
            set(Comp(i),'color',[0 0 0.7]);
        end
        % title([condition,' LayerA - N Cells= ',num2str(length(eval(['T4T5_mb(NFlies).Z.',CellType, 'B'])))]);
        
        
        Comp=compass(eval(['T4T5_mb(FlyOFFi).Z.',CellType, 'C']));
        for i=1:length(Comp)
            set(Comp(i),'color',[0.7 0 0]);
        end
        % title([condition,' LayerA - N Cells= ',num2str(length(eval(['T4T5_mb(NFlies).Z.',CellType, 'C'])))]);
        
        
        Comp=compass(eval(['T4T5_mb(FlyOFFi).Z.',CellType, 'D']));
        for i=1:length(Comp)
            set(Comp(i),'color',[.6 .6 0]);
        end
        % title([condition,' LayerA - N Cells= ',num2str(length(eval(['T4T5_mb(NFlies).Z.',CellType, 'D'])))]);
        
        
        Ncells_LA=Ncells_LA+length(T4T5_mb_OFF(FlyOFFi).Z.T5A); 
        Ncells_LB=Ncells_LB+length(T4T5_mb_OFF(FlyOFFi).Z.T5B); 
        Ncells_LC=Ncells_LC+length(T4T5_mb_OFF(FlyOFFi).Z.T5C); 
        Ncells_LD=Ncells_LD+length(T4T5_mb_OFF(FlyOFFi).Z.T5D); 

        % saveas(F,['/Volumes/ukme06/mhennin2/2p-imaging/Results_T4_T5_Imaging_C2_C3Kir/Responses_to_Stripes/Single_FlyPlots/',condition, '- ', T4T5_mb(NFlies).Flyname(1:6),'_', T4T5_mb(NFlies).Flyname(8:12), CellType,'.pdf'])
        % close all
    end
    
    text(-1.7, 1.2,[condition,' LayerA - N Cells= ',num2str(Ncells_LA)])
    text(-1.7, 1.1,[condition,' LayerB - N Cells= ',num2str(Ncells_LB)])
    text(-1.7, 1,[condition,' LayerC - N Cells= ',num2str(Ncells_LC)])
    text(-1.7, 0.9,[condition,' LayerD - N Cells= ',num2str(Ncells_LD)])
    
    ISD=size(dir([Foldertosave, '/Responses_to_Stripes/',condition,'/', 'Single_FlyPlots']),1);
    if ISD==0;
        mkdir([Foldertosave, '/Responses_to_Stripes/',condition,'/', 'Single_FlyPlots'])
    end 
    saveas(F,[Foldertosave, '/Responses_to_Stripes/',condition,'/', 'Single_FlyPlots/', T4T5_mb_ON(NFlies).Flyname(1:6),'_', T4T5_mb_ON(NFlies).Flyname(8:13),'.pdf'])
 
end

end