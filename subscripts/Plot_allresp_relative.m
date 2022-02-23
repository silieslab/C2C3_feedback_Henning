function Plot_allresp_relative(Conditions)

addpath('/Users/Miri/Documents/MATLAB/TP_code_Miriam'); 


Con= fields(Conditions);
Numcon=length(Con);

AlldirResp_T4_AvperCon=nan(Numcon,5); 
AlldirResp_T5_AvperCon=nan(Numcon,5);

AlldirResp_T4_STEperCon=nan(Numcon,5); 
AlldirResp_T5_STEperCon=nan(Numcon,5); 

AlldirResp_T4_AvperCon_sep=nan(Numcon,9); 
AlldirResp_T5_AvperCon_sep=nan(Numcon,9);

AlldirResp_T4_STEperCon_sep=nan(Numcon,9); 
AlldirResp_T5_STEperCon_sep=nan(Numcon,9); 


%New: First average across cells of one fly and then average of flies
Av_AlldirResp_T4_STEperCon_sep=nan(Numcon,9); 
Av_AlldirResp_T5_STEperCon_sep=nan(Numcon,9); 

Av_AlldirResp_T4_AvperCon_sep=nan(Numcon,9); 
Av_AlldirResp_T5_AvperCon_sep=nan(Numcon,9);

Av_AlldirResp_T4_ALLperCon_sep=nan(8,9,Numcon);
Av_AlldirResp_T5_ALLperCon_sep=nan(8,9,Numcon);


NumberofCellsperCon=nan(Numcon,2); 

for Ncon=1:Numcon
    
    AlldirResp_T4=[];
    AlldirResp_T5=[];
    AlldirResp_T4_sep=[];
    AlldirResp_T5_sep=[];
    Av_AlldirResp_T4_sep=[];
    Av_AlldirResp_T5_sep=[];
    
    Condi=eval(['Conditions.', Con{Ncon}]);
    
    condi_ON= Condi.ON.T4T5_mb;
    condi_OFF= Condi.OFF.T4T5_mb;
    NeuronTypes_ON={'T4A', 'T4B', 'T4C', 'T4D'};
    NeuronTypes_OFF={'T5A', 'T5B', 'T5C', 'T5D'};
    
    % Extract PD for each ROI - T4
    NFlies=size(condi_ON,2);
    for iFly=1:NFlies
        
        OneFlyAllResp_T5=[];
        OneFlyAllResp_T4=[];
        
        ROI_Resp_ON=condi_ON(iFly).ROI_Resp;
        ROI_Resp_OFF=condi_OFF(iFly).ROI_Resp;
        
        for NeronT=1:4
            
            % for ON responses T4 cells
            NeuronResp=eval(['ROI_Resp_ON.',NeuronTypes_ON{NeronT}]);
            
            if ~isempty(NeuronResp) % If for this fly neurons of the specific type are available
                R_teta=squeeze(max(NeuronResp,[],2));
                
                [PDr,PDi]=max(R_teta);
                % Extract responses to angles (+/-) 1 next to PD
                PD1_1i=PDi+1; PD1_1i(PD1_1i>8)=PD1_1i(PD1_1i>8)-8;
                PD1_2i=PDi-1; PD1_2i(PD1_2i<1)=PD1_2i(PD1_2i<1)+8;
                PD1_1r=R_teta(sub2ind(size(R_teta),PD1_1i,[1:size(R_teta,2)]));
                PD1_2r=R_teta(sub2ind(size(R_teta),PD1_2i,[1:size(R_teta,2)]));
                PD1r=mean([PD1_1r;PD1_2r]);
                % Extract responses to angles (+/-) 2 next to PD
                PD2_1i=PDi+2; PD2_1i(PD2_1i>8)=PD2_1i(PD2_1i>8)-8;
                PD2_2i=PDi-2; PD2_2i(PD2_2i<1)=PD2_2i(PD2_2i<1)+8;
                PD2_1r=R_teta(sub2ind(size(R_teta),PD2_1i,[1:size(R_teta,2)]));
                PD2_2r=R_teta(sub2ind(size(R_teta),PD2_2i,[1:size(R_teta,2)]));
                PD2r=mean([PD2_1r;PD2_2r]);
                % Extract responses to angles (+/-) 3 next to PD
                PD3_1i=PDi+3; PD3_1i(PD3_1i>8)=PD3_1i(PD3_1i>8)-8;
                PD3_2i=PDi-3; PD3_2i(PD3_2i<1)=PD3_2i(PD3_2i<1)+8;
                PD3_1r=R_teta(sub2ind(size(R_teta),PD3_1i,[1:size(R_teta,2)]));
                PD3_2r=R_teta(sub2ind(size(R_teta),PD3_2i,[1:size(R_teta,2)]));
                PD3r=mean([PD3_1r;PD3_2r]);
                
                % Extract responses to ND
                NDi=PDi+4; NDi(NDi>8)=NDi(NDi>8)-8;
                NDr=R_teta(sub2ind(size(R_teta),NDi,[1:size(R_teta,2)]));
                
                AllT4=[PDr;PD1r;PD2r;PD3r;NDr]';
                AllT4_sep=[NDr;PD3_2r;PD2_2r;PD1_2r;PDr;PD1_1r;PD2_1r;PD3_1r;NDr]';
            end %if isempty
            
            
            
            % for OFF responses T5 cells
            NeuronResp=eval(['ROI_Resp_OFF.',NeuronTypes_OFF{NeronT}]);
            
            if ~isempty(NeuronResp) % If for this fly neurons of the specific type are available
                R_teta=squeeze(max(NeuronResp,[],2));
                
                [PDr,PDi]=max(R_teta);
                % Extract responses to angles (+/-) 1 next to PD
                PD1_1i=PDi+1; PD1_1i(PD1_1i>8)=PD1_1i(PD1_1i>8)-8;
                PD1_2i=PDi-1; PD1_2i(PD1_2i<1)=PD1_2i(PD1_2i<1)+8;
                PD1_1r=R_teta(sub2ind(size(R_teta),PD1_1i,[1:size(R_teta,2)]));
                PD1_2r=R_teta(sub2ind(size(R_teta),PD1_2i,[1:size(R_teta,2)]));
                PD1r=mean([PD1_1r;PD1_2r]);
                % Extract responses to angles (+/-) 2 next to PD
                PD2_1i=PDi+2; PD2_1i(PD2_1i>8)=PD2_1i(PD2_1i>8)-8;
                PD2_2i=PDi-2; PD2_2i(PD2_2i<1)=PD2_2i(PD2_2i<1)+8;
                PD2_1r=R_teta(sub2ind(size(R_teta),PD2_1i,[1:size(R_teta,2)]));
                PD2_2r=R_teta(sub2ind(size(R_teta),PD2_2i,[1:size(R_teta,2)]));
                PD2r=mean([PD2_1r;PD2_2r]);
                % Extract responses to angles (+/-) 3 next to PD
                PD3_1i=PDi+3; PD3_1i(PD3_1i>8)=PD3_1i(PD3_1i>8)-8;
                PD3_2i=PDi-3; PD3_2i(PD3_2i<1)=PD3_2i(PD3_2i<1)+8;
                PD3_1r=R_teta(sub2ind(size(R_teta),PD3_1i,[1:size(R_teta,2)]));
                PD3_2r=R_teta(sub2ind(size(R_teta),PD3_2i,[1:size(R_teta,2)]));
                PD3r=mean([PD3_1r;PD3_2r]);
                
                % Extract responses to ND
                NDi=PDi+4; NDi(NDi>8)=NDi(NDi>8)-8;
                NDr=R_teta(sub2ind(size(R_teta),NDi,[1:size(R_teta,2)]));
                
                AllT5=[PDr;PD1r;PD2r;PD3r;NDr]';
                AllT5_sep=[NDr;PD3_2r;PD2_2r;PD1_2r;PDr;PD1_1r;PD2_1r;PD3_1r;NDr]';

            end %if isempty
            
            
            AlldirResp_T4=[AlldirResp_T4;AllT4];
            AlldirResp_T5=[AlldirResp_T5;AllT5];
            
            AlldirResp_T4_sep=[AlldirResp_T4_sep;AllT4_sep];
            AlldirResp_T5_sep=[AlldirResp_T5_sep;AllT5_sep];
            
            OneFlyAllResp_T4=[OneFlyAllResp_T4;AllT4_sep];
            OneFlyAllResp_T5=[OneFlyAllResp_T5;AllT5_sep];
            
        end %for NeronT=1:4
        
            Av_AlldirResp_T4_sep=[Av_AlldirResp_T4_sep;mean(OneFlyAllResp_T4,1)];
            Av_AlldirResp_T5_sep=[Av_AlldirResp_T5_sep;mean(OneFlyAllResp_T5,1)];
        
    end %iFly
    
    
    AlldirResp_T4_AvperCon(Ncon,:)=mean(AlldirResp_T4);  
    AlldirResp_T5_AvperCon(Ncon,:)=mean(AlldirResp_T5);
    
    AlldirResp_T4_AvperCon_sep(Ncon,:)=mean(AlldirResp_T4_sep);
    AlldirResp_T5_AvperCon_sep(Ncon,:)=mean(AlldirResp_T5_sep);
    
    % normalize responses
    AlldirResp_T4_sep_norm=AlldirResp_T4_sep-min(AlldirResp_T4_sep,[],2);
    AlldirResp_T4_sep_norm=AlldirResp_T4_sep_norm./max(AlldirResp_T4_sep_norm,[],2);
    
    AlldirResp_T5_sep_norm=AlldirResp_T5_sep-min(AlldirResp_T5_sep,[],2);
    AlldirResp_T5_sep_norm=AlldirResp_T5_sep_norm./max(AlldirResp_T5_sep_norm,[],2);
    
    Av_AlldirResp_T4_AvperCon_sep(Ncon,:)=mean(Av_AlldirResp_T4_sep);
    Av_AlldirResp_T5_AvperCon_sep(Ncon,:)=mean(Av_AlldirResp_T5_sep);
    
    Av_AlldirResp_T4_STEperCon_sep(Ncon,:)=std(Av_AlldirResp_T4_sep)/sqrt(size(Av_AlldirResp_T4_sep,1)); 
    Av_AlldirResp_T5_STEperCon_sep(Ncon,:)=std(Av_AlldirResp_T5_sep)/sqrt(size(Av_AlldirResp_T5_sep,1)); 

    Av_AlldirResp_T4_ALLperCon_sep(1:size(Av_AlldirResp_T4_sep,1),:,Ncon)=Av_AlldirResp_T4_sep;
    Av_AlldirResp_T5_ALLperCon_sep(1:size(Av_AlldirResp_T5_sep,1),:,Ncon)=Av_AlldirResp_T5_sep;



    AlldirResp_T4_AvperCon_sep_norm(Ncon,:)=mean(AlldirResp_T4_sep_norm);
    AlldirResp_T5_AvperCon_sep_norm(Ncon,:)=mean(AlldirResp_T5_sep_norm);
 
    
    AlldirResp_T4_STEperCon(Ncon,:)=std(AlldirResp_T4)/sqrt(size(AlldirResp_T4,1)); 
    AlldirResp_T5_STEperCon(Ncon,:)=std(AlldirResp_T5)/sqrt(size(AlldirResp_T5,1));
    
    AlldirResp_T4_STEperCon_sep(Ncon,:)=std(AlldirResp_T4_sep)/sqrt(size(AlldirResp_T4_sep,1)); 
    AlldirResp_T5_STEperCon_sep(Ncon,:)=std(AlldirResp_T5_sep)/sqrt(size(AlldirResp_T5_sep,1));
   
    AlldirResp_T4_STEperCon_sep_norm(Ncon,:)=std(AlldirResp_T4_sep_norm)/sqrt(size(AlldirResp_T4_sep_norm,1)); 
    AlldirResp_T5_STEperCon_sep_norm(Ncon,:)=std(AlldirResp_T5_sep_norm)/sqrt(size(AlldirResp_T5_sep_norm,1)); 
    
%     AlldirResp_T4_AvperCon_fit(Ncon,:)=mean(AlldirResp_T4_fit);
%     AlldirResp_T5_AvperCon_fit(Ncon,:)=mean(AlldirResp_T5_fit);

%     AlldirResp_T4_STEperCon_fit(Ncon,:)=std(AlldirResp_T4_fit)/sqrt(size(AlldirResp_T4_fit,1)); 
%     AlldirResp_T5_STEperCon_fit(Ncon,:)=std(AlldirResp_T5_fit)/sqrt(size(AlldirResp_T5_fit,1)); 
%     
    NumberofCellsperCon(Ncon,1)=size(AlldirResp_T4,1); 
    NumberofCellsperCon(Ncon,2)=size(AlldirResp_T5,1); 
    
%     boxplot(AlldirResp_T4, 'notch', 'on', 'Colors',NCONCol(Ncon,:))
%     hold on 
%     plot(mean(AlldirResp_T4), 'o-', 'Color', NCONCol(Ncon,:))

    
end %NCON



NCONCol=[0.5 0.5 0.5; 0.75 0 0.75; 0 0.5 0; 0.1 0.5 1]; % for all Con



figure
for i=1:Numcon
plot(Av_AlldirResp_T4_AvperCon_sep(i,:), 'o', 'Color', NCONCol(i,:))
hold on 
errorbar(1:9,Av_AlldirResp_T4_AvperCon_sep(i,:),Av_AlldirResp_T4_STEperCon_sep(i,:),'Color', NCONCol(i,:))
end 
title('T4')
xlabel('angular distance from PD first average across cells then flies') 

ylabel('dF/F') 


figure
for i=1:Numcon
plot(Av_AlldirResp_T5_AvperCon_sep(i,:), 'o', 'Color', NCONCol(i,:))
hold on 
errorbar(1:9,Av_AlldirResp_T5_AvperCon_sep(i,:),Av_AlldirResp_T5_STEperCon_sep(i,:),'Color', NCONCol(i,:))
end 
title('T5')
xlabel('angular distance from PD first average across cells then flies') 

ylabel('dF/F') 


%% Statistics:
disp('-180 angular distance')
Data=squeeze(Av_AlldirResp_T4_ALLperCon_sep(:,1,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('-135 angular distance')
Data=squeeze(Av_AlldirResp_T4_ALLperCon_sep(:,2,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('-90 angular distance')
Data=squeeze(Av_AlldirResp_T4_ALLperCon_sep(:,3,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('-45 angular distance')
Data=squeeze(Av_AlldirResp_T4_ALLperCon_sep(:,4,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('0 angular distance')
Data=squeeze(Av_AlldirResp_T4_ALLperCon_sep(:,5,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('45 angular distance')
Data=squeeze(Av_AlldirResp_T4_ALLperCon_sep(:,6,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('90 angular distance')
Data=squeeze(Av_AlldirResp_T4_ALLperCon_sep(:,7,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('135 angular distance')
Data=squeeze(Av_AlldirResp_T4_ALLperCon_sep(:,8,:))'; 
Multcomp_Stats(Data,Con,'KKW')





disp('-180 angular distance')
Data=squeeze(Av_AlldirResp_T5_ALLperCon_sep(:,1,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('-135 angular distance')
Data=squeeze(Av_AlldirResp_T5_ALLperCon_sep(:,2,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('-90 angular distance')
Data=squeeze(Av_AlldirResp_T5_ALLperCon_sep(:,3,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('-45 angular distance')
Data=squeeze(Av_AlldirResp_T5_ALLperCon_sep(:,4,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('0 angular distance')
Data=squeeze(Av_AlldirResp_T5_ALLperCon_sep(:,5,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('45 angular distance')
Data=squeeze(Av_AlldirResp_T5_ALLperCon_sep(:,6,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('90 angular distance')
Data=squeeze(Av_AlldirResp_T5_ALLperCon_sep(:,7,:))'; 
Multcomp_Stats(Data,Con,'KKW')

disp('135 angular distance')
Data=squeeze(Av_AlldirResp_T5_ALLperCon_sep(:,8,:))'; 
Multcomp_Stats(Data,Con,'KKW')

end

