function MinimaANDMaxima=ExtractMinandMax(Av_STRF_co,Av_STRF_c2,Av_STRF_c3)

    
%This script extracts the maxima and minima of Average STRFs and
%individual STRFs across all conditions for normalization(plotting)
Minima_allCond_T4_L1=min([min(min(mean(Av_STRF_co.AllSTRFs_T4_L1,3))),min(min(mean(Av_STRF_c2.AllSTRFs_T4_L1,3))),min(min(mean(Av_STRF_c3.AllSTRFs_T4_L1,3)))]);
Maxima_allCond_T4_L1=max([max(max(mean(Av_STRF_co.AllSTRFs_T4_L1,3))),max(max(mean(Av_STRF_c2.AllSTRFs_T4_L1,3))),max(max(mean(Av_STRF_c3.AllSTRFs_T4_L1,3)))]);

Minima_allCond_T5_L1=min([min(min(mean(Av_STRF_co.AllSTRFs_T5_L1,3))),min(min(mean(Av_STRF_c2.AllSTRFs_T5_L1,3))),min(min(mean(Av_STRF_c3.AllSTRFs_T5_L1,3)))]);
Maxima_allCond_T5_L1=max([max(max(mean(Av_STRF_co.AllSTRFs_T5_L1,3))),max(max(mean(Av_STRF_c2.AllSTRFs_T5_L1,3))),max(max(mean(Av_STRF_c3.AllSTRFs_T5_L1,3)))]);



Minima_allCond_T4_L2=min([min(min(mean(Av_STRF_co.AllSTRFs_T4_L2,3))),min(min(mean(Av_STRF_c2.AllSTRFs_T4_L2,3))),min(min(mean(Av_STRF_c3.AllSTRFs_T4_L2,3)))]);
Maxima_allCond_T4_L2=max([max(max(mean(Av_STRF_co.AllSTRFs_T4_L2,3))),max(max(mean(Av_STRF_c2.AllSTRFs_T4_L2,3))),max(max(mean(Av_STRF_c3.AllSTRFs_T4_L2,3)))]);

Minima_allCond_T5_L2=min([min(min(mean(Av_STRF_co.AllSTRFs_T5_L2,3))),min(min(mean(Av_STRF_c2.AllSTRFs_T5_L2,3))),min(min(mean(Av_STRF_c3.AllSTRFs_T5_L2,3)))]);
Maxima_allCond_T5_L2=max([max(max(mean(Av_STRF_co.AllSTRFs_T5_L2,3))),max(max(mean(Av_STRF_c2.AllSTRFs_T5_L2,3))),max(max(mean(Av_STRF_c3.AllSTRFs_T5_L2,3)))]);



Minima_allCond_T4_L3=min([min(min(mean(Av_STRF_co.AllSTRFs_T4_L3,3))),min(min(mean(Av_STRF_c2.AllSTRFs_T4_L3,3))),min(min(mean(Av_STRF_c3.AllSTRFs_T4_L3,3)))]);
Maxima_allCond_T4_L3=max([max(max(mean(Av_STRF_co.AllSTRFs_T4_L3,3))),max(max(mean(Av_STRF_c2.AllSTRFs_T4_L3,3))),max(max(mean(Av_STRF_c3.AllSTRFs_T4_L3,3)))]);

Minima_allCond_T5_L3=min([min(min(mean(Av_STRF_co.AllSTRFs_T5_L3,3))),min(min(mean(Av_STRF_c2.AllSTRFs_T5_L3,3))),min(min(mean(Av_STRF_c3.AllSTRFs_T5_L3,3)))]);
Maxima_allCond_T5_L3=max([max(max(mean(Av_STRF_co.AllSTRFs_T5_L3,3))),max(max(mean(Av_STRF_c2.AllSTRFs_T5_L3,3))),max(max(mean(Av_STRF_c3.AllSTRFs_T5_L3,3)))]);




Minima_allCond_T4_L4=min([min(min(mean(Av_STRF_co.AllSTRFs_T4_L4,3))),min(min(mean(Av_STRF_c2.AllSTRFs_T4_L4,3))),min(min(mean(Av_STRF_c3.AllSTRFs_T4_L4,3)))]);
Maxima_allCond_T4_L4=max([max(max(mean(Av_STRF_co.AllSTRFs_T4_L4,3))),max(max(mean(Av_STRF_c2.AllSTRFs_T4_L4,3))),max(max(mean(Av_STRF_c3.AllSTRFs_T4_L4,3)))]);

Minima_allCond_T5_L4=min([min(min(mean(Av_STRF_co.AllSTRFs_T5_L4,3))),min(min(mean(Av_STRF_c2.AllSTRFs_T5_L4,3))),min(min(mean(Av_STRF_c3.AllSTRFs_T5_L4,3)))]);
Maxima_allCond_T5_L4=max([max(max(mean(Av_STRF_co.AllSTRFs_T5_L4,3))),max(max(mean(Av_STRF_c2.AllSTRFs_T5_L4,3))),max(max(mean(Av_STRF_c3.AllSTRFs_T5_L4,3)))]);


Minima_allCond_T4_AllLayer=min([min(min(mean(cat(3,Av_STRF_co.AllSTRFs_T4_L1,Av_STRF_co.AllSTRFs_T4_L2,Av_STRF_co.AllSTRFs_T4_L3,Av_STRF_co.AllSTRFs_T4_L4),3))),...
                                min(min(mean(cat(3,Av_STRF_c2.AllSTRFs_T4_L1,Av_STRF_c2.AllSTRFs_T4_L2,Av_STRF_c2.AllSTRFs_T4_L3,Av_STRF_c2.AllSTRFs_T4_L4),3))),...
                                min(min(mean(cat(3,Av_STRF_c3.AllSTRFs_T4_L1,Av_STRF_c3.AllSTRFs_T4_L2,Av_STRF_c3.AllSTRFs_T4_L3,Av_STRF_c3.AllSTRFs_T4_L4),3)))]);
                      
Maxima_allCond_T4_AllLayer=max([max(max(mean(cat(3,Av_STRF_co.AllSTRFs_T4_L1,Av_STRF_co.AllSTRFs_T4_L2,Av_STRF_co.AllSTRFs_T4_L3,Av_STRF_co.AllSTRFs_T4_L4),3))),...
                                max(max(mean(cat(3,Av_STRF_c2.AllSTRFs_T4_L1,Av_STRF_c2.AllSTRFs_T4_L2,Av_STRF_c2.AllSTRFs_T4_L3,Av_STRF_c2.AllSTRFs_T4_L4),3))),...
                                max(max(mean(cat(3,Av_STRF_c3.AllSTRFs_T4_L1,Av_STRF_c3.AllSTRFs_T4_L2,Av_STRF_c3.AllSTRFs_T4_L3,Av_STRF_c3.AllSTRFs_T4_L4),3)))]);

Minima_allCond_T5_AllLayer=min([min(min(mean(cat(3,Av_STRF_co.AllSTRFs_T5_L1,Av_STRF_co.AllSTRFs_T5_L2,Av_STRF_co.AllSTRFs_T5_L3,Av_STRF_co.AllSTRFs_T5_L4),3))),...
                                min(min(mean(cat(3,Av_STRF_c2.AllSTRFs_T5_L1,Av_STRF_c2.AllSTRFs_T5_L2,Av_STRF_c2.AllSTRFs_T5_L3,Av_STRF_c2.AllSTRFs_T5_L4),3))),...
                                min(min(mean(cat(3,Av_STRF_c3.AllSTRFs_T5_L1,Av_STRF_c3.AllSTRFs_T5_L2,Av_STRF_c3.AllSTRFs_T5_L3,Av_STRF_c3.AllSTRFs_T5_L4),3)))]);
                      
Maxima_allCond_T5_AllLayer=max([max(max(mean(cat(3,Av_STRF_co.AllSTRFs_T5_L1,Av_STRF_co.AllSTRFs_T5_L2,Av_STRF_co.AllSTRFs_T5_L3,Av_STRF_co.AllSTRFs_T5_L4),3))),...
                                max(max(mean(cat(3,Av_STRF_c2.AllSTRFs_T5_L1,Av_STRF_c2.AllSTRFs_T5_L2,Av_STRF_c2.AllSTRFs_T5_L3,Av_STRF_c2.AllSTRFs_T5_L4),3))),...
                                max(max(mean(cat(3,Av_STRF_c3.AllSTRFs_T5_L1,Av_STRF_c3.AllSTRFs_T5_L2,Av_STRF_c3.AllSTRFs_T5_L3,Av_STRF_c3.AllSTRFs_T5_L4),3)))]);



AllMinandMax.T4_L1=[Minima_allCond_T4_L1,Maxima_allCond_T4_L1];
AllMinandMax.T4_L2=[Minima_allCond_T4_L2,Maxima_allCond_T4_L2];
AllMinandMax.T4_L3=[Minima_allCond_T4_L3,Maxima_allCond_T4_L3];
AllMinandMax.T4_L4=[Minima_allCond_T4_L4,Maxima_allCond_T4_L4];


AllMinandMax.T5_L1=[Minima_allCond_T5_L1,Maxima_allCond_T5_L1];
AllMinandMax.T5_L2=[Minima_allCond_T5_L2,Maxima_allCond_T5_L2];
AllMinandMax.T5_L3=[Minima_allCond_T5_L3,Maxima_allCond_T5_L3];
AllMinandMax.T5_L4=[Minima_allCond_T5_L4,Maxima_allCond_T5_L4];

AllMinandMax.T4_AllLayer=[Minima_allCond_T4_AllLayer,Maxima_allCond_T4_AllLayer];
AllMinandMax.T5_AllLayer=[Minima_allCond_T5_AllLayer,Maxima_allCond_T5_AllLayer];


%% Extract the lowest minimum and highest maximum of all STRFs for plotting individual RF

Minima_allCond_T4_L1=min([min(min(min(Av_STRF_co.AllSTRFs_T4_L1))),min(min(min(Av_STRF_c2.AllSTRFs_T4_L1))),min(min(min(Av_STRF_c3.AllSTRFs_T4_L1)))]);
Maxima_allCond_T4_L1=max([max(max(max(Av_STRF_co.AllSTRFs_T4_L1))),max(max(max(Av_STRF_c2.AllSTRFs_T4_L1))),max(max(mean(Av_STRF_c3.AllSTRFs_T4_L1)))]);

Minima_allCond_T5_L1=min([min(min(min(Av_STRF_co.AllSTRFs_T5_L1))),min(min(min(Av_STRF_c2.AllSTRFs_T5_L1))),min(min(min(Av_STRF_c3.AllSTRFs_T5_L1)))]);
Maxima_allCond_T5_L1=max([max(max(max(Av_STRF_co.AllSTRFs_T5_L1))),max(max(max(Av_STRF_c2.AllSTRFs_T5_L1))),max(max(max(Av_STRF_c3.AllSTRFs_T5_L1)))]);



Minima_allCond_T4_L2=min([min(min(min(Av_STRF_co.AllSTRFs_T4_L2))),min(min(min(Av_STRF_c2.AllSTRFs_T4_L2))),min(min(min(Av_STRF_c3.AllSTRFs_T4_L2)))]);
Maxima_allCond_T4_L2=max([max(max(max(Av_STRF_co.AllSTRFs_T4_L2))),max(max(max(Av_STRF_c2.AllSTRFs_T4_L2))),max(max(max(Av_STRF_c3.AllSTRFs_T4_L2)))]);

Minima_allCond_T5_L2=min([min(min(min(Av_STRF_co.AllSTRFs_T5_L2))),min(min(min(Av_STRF_c2.AllSTRFs_T5_L2))),min(min(min(Av_STRF_c3.AllSTRFs_T5_L2)))]);
Maxima_allCond_T5_L2=max([max(max(max(Av_STRF_co.AllSTRFs_T5_L2))),max(max(max(Av_STRF_c2.AllSTRFs_T5_L2))),max(max(max(Av_STRF_c3.AllSTRFs_T5_L2)))]);



Minima_allCond_T4_L3=min([min(min(min(Av_STRF_co.AllSTRFs_T4_L3))),min(min(min(Av_STRF_c2.AllSTRFs_T4_L3))),min(min(min(Av_STRF_c3.AllSTRFs_T4_L3)))]);
Maxima_allCond_T4_L3=max([max(max(max(Av_STRF_co.AllSTRFs_T4_L3))),max(max(max(Av_STRF_c2.AllSTRFs_T4_L3))),max(max(max(Av_STRF_c3.AllSTRFs_T4_L3)))]);

Minima_allCond_T5_L3=min([min(min(min(Av_STRF_co.AllSTRFs_T5_L3))),min(min(min(Av_STRF_c2.AllSTRFs_T5_L3))),min(min(min(Av_STRF_c3.AllSTRFs_T5_L3)))]);
Maxima_allCond_T5_L3=max([max(max(max(Av_STRF_co.AllSTRFs_T5_L3))),max(max(max(Av_STRF_c2.AllSTRFs_T5_L3))),max(max(max(Av_STRF_c3.AllSTRFs_T5_L3)))]);




Minima_allCond_T4_L4=min([min(min(min(Av_STRF_co.AllSTRFs_T4_L4))),min(min(min(Av_STRF_c2.AllSTRFs_T4_L4))),min(min(min(Av_STRF_c3.AllSTRFs_T4_L4)))]);
Maxima_allCond_T4_L4=max([max(max(max(Av_STRF_co.AllSTRFs_T4_L4))),max(max(max(Av_STRF_c2.AllSTRFs_T4_L4))),max(max(max(Av_STRF_c3.AllSTRFs_T4_L4)))]);

Minima_allCond_T5_L4=min([min(min(min(Av_STRF_co.AllSTRFs_T5_L4))),min(min(min(Av_STRF_c2.AllSTRFs_T5_L4))),min(min(min(Av_STRF_c3.AllSTRFs_T5_L4)))]);
Maxima_allCond_T5_L4=max([max(max(max(Av_STRF_co.AllSTRFs_T5_L4))),max(max(max(Av_STRF_c2.AllSTRFs_T5_L4))),max(max(max(Av_STRF_c3.AllSTRFs_T5_L4)))]);



AllMinandMax_abs.T4_L1=[Minima_allCond_T4_L1,Maxima_allCond_T4_L1];
AllMinandMax_abs.T4_L2=[Minima_allCond_T4_L2,Maxima_allCond_T4_L2];
AllMinandMax_abs.T4_L3=[Minima_allCond_T4_L3,Maxima_allCond_T4_L3];
AllMinandMax_abs.T4_L4=[Minima_allCond_T4_L4,Maxima_allCond_T4_L4];


AllMinandMax_abs.T5_L1=[Minima_allCond_T5_L1,Maxima_allCond_T5_L1];
AllMinandMax_abs.T5_L2=[Minima_allCond_T5_L2,Maxima_allCond_T5_L2];
AllMinandMax_abs.T5_L3=[Minima_allCond_T5_L3,Maxima_allCond_T5_L3];
AllMinandMax_abs.T5_L4=[Minima_allCond_T5_L4,Maxima_allCond_T5_L4];



% AllMinandMax_absFit.T4_L1=[min([-GausfitInfo.Peak_amplitudeT4(2,GausfitInfo.LayerID_T4==1),-GausfitInfoC2sil.Peak_amplitudeT4(2,GausfitInfoC2sil.LayerID_T4==1),-GausfitInfoC3sil.Peak_amplitudeT4(2,GausfitInfoC3sil.LayerID_T4==1)]),...
%     max([GausfitInfo.Peak_amplitudeT4(1,GausfitInfo.LayerID_T4==1),GausfitInfoC2sil.Peak_amplitudeT4(1,GausfitInfoC2sil.LayerID_T4==1),GausfitInfoC3sil.Peak_amplitudeT4(1,GausfitInfoC3sil.LayerID_T4==1)])];
% AllMinandMax_absFit.T4_L2=[min([-GausfitInfo.Peak_amplitudeT4(2,GausfitInfo.LayerID_T4==2),-GausfitInfoC2sil.Peak_amplitudeT4(2,GausfitInfoC2sil.LayerID_T4==2),-GausfitInfoC3sil.Peak_amplitudeT4(2,GausfitInfoC3sil.LayerID_T4==2)]),...
%     max([GausfitInfo.Peak_amplitudeT4(1,GausfitInfo.LayerID_T4==2),GausfitInfoC2sil.Peak_amplitudeT4(1,GausfitInfoC2sil.LayerID_T4==2),GausfitInfoC3sil.Peak_amplitudeT4(1,GausfitInfoC3sil.LayerID_T4==2)])];
% AllMinandMax_absFit.T4_L3=[min([-GausfitInfo.Peak_amplitudeT4(2,GausfitInfo.LayerID_T4==3),-GausfitInfoC2sil.Peak_amplitudeT4(2,GausfitInfoC2sil.LayerID_T4==3),-GausfitInfoC3sil.Peak_amplitudeT4(2,GausfitInfoC3sil.LayerID_T4==3)]),...
%     max([GausfitInfo.Peak_amplitudeT4(1,GausfitInfo.LayerID_T4==3),GausfitInfoC2sil.Peak_amplitudeT4(1,GausfitInfoC2sil.LayerID_T4==3),GausfitInfoC3sil.Peak_amplitudeT4(1,GausfitInfoC3sil.LayerID_T4==3)])];
% AllMinandMax_absFit.T4_L4=[min([-GausfitInfo.Peak_amplitudeT4(2,GausfitInfo.LayerID_T4==4),-GausfitInfoC2sil.Peak_amplitudeT4(2,GausfitInfoC2sil.LayerID_T4==4),-GausfitInfoC3sil.Peak_amplitudeT4(2,GausfitInfoC3sil.LayerID_T4==4)]),...
%     max([GausfitInfo.Peak_amplitudeT4(1,GausfitInfo.LayerID_T4==4),GausfitInfoC2sil.Peak_amplitudeT4(1,GausfitInfoC2sil.LayerID_T4==4),GausfitInfoC3sil.Peak_amplitudeT4(1,GausfitInfoC3sil.LayerID_T4==4)])];
% 
% 
% AllMinandMax_absFit.T5_L1=[min([-GausfitInfo.Peak_amplitudeT5(2,GausfitInfo.LayerID_T5==1),-GausfitInfoC2sil.Peak_amplitudeT5(2,GausfitInfoC2sil.LayerID_T5==1),-GausfitInfoC3sil.Peak_amplitudeT5(2,GausfitInfoC3sil.LayerID_T5==1)]),...
%     max([GausfitInfo.Peak_amplitudeT5(1,GausfitInfo.LayerID_T5==1),GausfitInfoC2sil.Peak_amplitudeT5(1,GausfitInfoC2sil.LayerID_T5==1),GausfitInfoC3sil.Peak_amplitudeT5(1,GausfitInfoC3sil.LayerID_T5==1)])];
% AllMinandMax_absFit.T5_L2=[min([-GausfitInfo.Peak_amplitudeT5(2,GausfitInfo.LayerID_T5==2),-GausfitInfoC2sil.Peak_amplitudeT5(2,GausfitInfoC2sil.LayerID_T5==2),-GausfitInfoC3sil.Peak_amplitudeT5(2,GausfitInfoC3sil.LayerID_T5==2)]),...
%     max([GausfitInfo.Peak_amplitudeT5(1,GausfitInfo.LayerID_T5==2),GausfitInfoC2sil.Peak_amplitudeT5(1,GausfitInfoC2sil.LayerID_T5==2),GausfitInfoC3sil.Peak_amplitudeT5(1,GausfitInfoC3sil.LayerID_T5==2)])];
% AllMinandMax_absFit.T5_L3=[min([-GausfitInfo.Peak_amplitudeT5(2,GausfitInfo.LayerID_T5==3),-GausfitInfoC2sil.Peak_amplitudeT5(2,GausfitInfoC2sil.LayerID_T5==3),-GausfitInfoC3sil.Peak_amplitudeT5(2,GausfitInfoC3sil.LayerID_T5==3)]),...
%     max([GausfitInfo.Peak_amplitudeT5(1,GausfitInfo.LayerID_T5==3),GausfitInfoC2sil.Peak_amplitudeT5(1,GausfitInfoC2sil.LayerID_T5==3),GausfitInfoC3sil.Peak_amplitudeT5(1,GausfitInfoC3sil.LayerID_T5==3)])];
% AllMinandMax_absFit.T5_L4=[min([-GausfitInfo.Peak_amplitudeT5(2,GausfitInfo.LayerID_T5==4),-GausfitInfoC2sil.Peak_amplitudeT5(2,GausfitInfoC2sil.LayerID_T5==4),-GausfitInfoC3sil.Peak_amplitudeT5(2,GausfitInfoC3sil.LayerID_T5==4)]),...
%     max([GausfitInfo.Peak_amplitudeT5(1,GausfitInfo.LayerID_T5==4),GausfitInfoC2sil.Peak_amplitudeT5(1,GausfitInfoC2sil.LayerID_T5==4),GausfitInfoC3sil.Peak_amplitudeT5(1,GausfitInfoC3sil.LayerID_T5==4)])];
% 

MinimaANDMaxima.AllMinandMax_Av=AllMinandMax;
MinimaANDMaxima.AllMinandMax_forIndiv_STRFs=AllMinandMax_abs;

end 

