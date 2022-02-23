% Plot statistics 

function plot_GaussFit_statistics2(GausfitInfo1,GausfitInfo2,GausfitInfo3, Fit_TreshT4,Fit_TreshT5)
% Input:
% GausfitInfo1= Informatin about Gaus Fit from Fit_Gauss function for 
%            Condition 1 = Control
% GausfitInfo2= for Condition2 = C3Kir 


Ind_abThres_T41=find(GausfitInfo1.RsqT4>=Fit_TreshT4); 
Ind_abThres_T42=find(GausfitInfo2.RsqT4>=Fit_TreshT4); 
Ind_abThres_T43=find(GausfitInfo3.RsqT4>=Fit_TreshT4); 


Ind_abThres_T51=find(GausfitInfo1.RsqT5>=Fit_TreshT5); 
Ind_abThres_T52=find(GausfitInfo2.RsqT5>=Fit_TreshT5); 
Ind_abThres_T53=find(GausfitInfo3.RsqT5>=Fit_TreshT5); 


%%%%%%%%%%%%%%%%%%%%%%%%

%Suppl. Fig.3b 
F1=figure('Position', [500 400 400 500]);
h1=subplot(1,2,1);
boxplot([GausfitInfo1.RsqT4(Ind_abThres_T41)';GausfitInfo2.RsqT4(Ind_abThres_T42)'; GausfitInfo3.RsqT4(Ind_abThres_T43)'],...
    [ones(1,length(GausfitInfo1.RsqT4(Ind_abThres_T41)))';2*ones(1,length(GausfitInfo2.RsqT4(Ind_abThres_T42)))';3*ones(1,length(GausfitInfo3.RsqT4(Ind_abThres_T43)))'],...
    'notch', 'on','labels',{'Control','C2Kir','C3Kir'});
ylabel('R^{2} - goodness of gauss fit')
a = get(get(h1,'children'),'children');% t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h1,'FontSize',13)
set(h1,'YLim', [0 1])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.RsqT4(Ind_abThres_T41)))=GausfitInfo1.RsqT4(Ind_abThres_T41);
DATA_tog(2,1:length(GausfitInfo2.RsqT4(Ind_abThres_T42)))=GausfitInfo2.RsqT4(Ind_abThres_T42);
DATA_tog(3,1:length(GausfitInfo3.RsqT4(Ind_abThres_T43)))=GausfitInfo3.RsqT4(Ind_abThres_T43);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 0.77, ['KKW p=', num2str(round(Pval(1),3))]);
text(1, 0.75, ['KKW p=', num2str(round(Pval(2),3))]);
title('Suppl. Fig.3b  : T4')


h2=subplot(1,2,2);
boxplot([GausfitInfo1.RsqT5(Ind_abThres_T51)';GausfitInfo2.RsqT5(Ind_abThres_T52)'; GausfitInfo3.RsqT5(Ind_abThres_T53)'],...
    [ones(1,length(GausfitInfo1.RsqT5(Ind_abThres_T51)))';2*ones(1,length(GausfitInfo2.RsqT5(Ind_abThres_T52)))';3*ones(1,length(GausfitInfo3.RsqT5(Ind_abThres_T53)))'],...
    'notch', 'on','labels',{'Control','C2Kir','C3Kir'})
set(gca, 'Ylim', [0 1])
% title(['Goodness of Gauss Fit after Thresholding (', Fit_TreshT5, ')- T5'])
a = get(get(h2,'children'),'children');% t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h2,'FontSize',13)
set(h2,'YLim', [0 1])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.RsqT5(Ind_abThres_T51)))=GausfitInfo1.RsqT5(Ind_abThres_T51);
DATA_tog(2,1:length(GausfitInfo2.RsqT5(Ind_abThres_T52)))=GausfitInfo2.RsqT5(Ind_abThres_T52);
DATA_tog(3,1:length(GausfitInfo3.RsqT5(Ind_abThres_T53)))=GausfitInfo3.RsqT5(Ind_abThres_T53);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 0.77, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.75, ['KKW p=', num2str(round(Pval(2),3))])




%%%%%%%%%%%%%%%%%%%%%%%%

%Fig.3f 

F2=figure(10)
set(F2,'Position', [500 400 1200 550]);

h2=subplot(2,5,1);
boxplot([GausfitInfo1.Peak_amplitudeT4(1,Ind_abThres_T41)';GausfitInfo2.Peak_amplitudeT4(1,Ind_abThres_T42)';GausfitInfo3.Peak_amplitudeT4(1,Ind_abThres_T43)'],...
    [ones(1,length(GausfitInfo1.Peak_amplitudeT4(1,Ind_abThres_T41)))';2*ones(1,length(GausfitInfo2.Peak_amplitudeT4(1,Ind_abThres_T42)))'; 3*ones(1,length(GausfitInfo3.Peak_amplitudeT4(1,Ind_abThres_T43)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'});
ylabel('Peak amplitude-T4')
xlabel('Pos')
a = get(get(h2,'children'),'children');% t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h2,'FontSize',13)
set(h2, 'YLim',[0 0.015])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.Peak_amplitudeT4(1,Ind_abThres_T41)))=GausfitInfo1.Peak_amplitudeT4(1,Ind_abThres_T41);
DATA_tog(2,1:length(GausfitInfo2.Peak_amplitudeT4(1,Ind_abThres_T42)))=GausfitInfo2.Peak_amplitudeT4(1,Ind_abThres_T42);
DATA_tog(3,1:length(GausfitInfo3.Peak_amplitudeT4(1,Ind_abThres_T43)))=GausfitInfo3.Peak_amplitudeT4(1,Ind_abThres_T43);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 0.014, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.013, ['KKW p=', num2str(round(Pval(2),3))])


%Fig.3f' 

h3=subplot(2,5,6);
boxplot([GausfitInfo1.Peak_amplitudeT4(2,Ind_abThres_T41)';GausfitInfo2.Peak_amplitudeT4(2,Ind_abThres_T42)';GausfitInfo3.Peak_amplitudeT4(2,Ind_abThres_T43)'],...
    [ones(1,length(GausfitInfo1.Peak_amplitudeT4(2,Ind_abThres_T41)))';2*ones(1,length(GausfitInfo2.Peak_amplitudeT4(2,Ind_abThres_T42)))'; 3*ones(1,length(GausfitInfo3.Peak_amplitudeT4(2,Ind_abThres_T43)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Peak amplitude-T4')
xlabel('Neg')
a = get(get(h3,'children'),'children');% t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h3,'FontSize',13)
set(h3, 'YLim',[0 0.03])
DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.Peak_amplitudeT4(2,Ind_abThres_T41)))=GausfitInfo1.Peak_amplitudeT4(2,Ind_abThres_T41);
DATA_tog(2,1:length(GausfitInfo2.Peak_amplitudeT4(2,Ind_abThres_T42)))=GausfitInfo2.Peak_amplitudeT4(2,Ind_abThres_T42);
DATA_tog(3,1:length(GausfitInfo3.Peak_amplitudeT4(2,Ind_abThres_T43)))=GausfitInfo3.Peak_amplitudeT4(2,Ind_abThres_T43);


[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 0.028, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.0265, ['KKW p=', num2str(round(Pval(2),3))])


%Fig.3g 

h4=subplot(2,5,2);
boxplot([GausfitInfo1.HalfwidthMaxT4_X(1,Ind_abThres_T41)';GausfitInfo2.HalfwidthMaxT4_X(1,Ind_abThres_T42)';GausfitInfo3.HalfwidthMaxT4_X(1,Ind_abThres_T43)'],...
    [ones(1,length(GausfitInfo1.HalfwidthMaxT4_X(1,Ind_abThres_T41)))';2*ones(1,length(GausfitInfo2.HalfwidthMaxT4_X(1,Ind_abThres_T42)))';3*ones(1,length(GausfitInfo3.HalfwidthMaxT4_X(1,Ind_abThres_T43)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Half Width Maximum-X(deg/s) ')
xlabel('Pos')
a = get(get(h4,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h4,'FontSize',13)
set(h4, 'YLim',[-50 120])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.HalfwidthMaxT4_X(1,Ind_abThres_T41)))=GausfitInfo1.HalfwidthMaxT4_X(1,Ind_abThres_T41);
DATA_tog(2,1:length(GausfitInfo2.HalfwidthMaxT4_X(1,Ind_abThres_T42)))=GausfitInfo2.HalfwidthMaxT4_X(1,Ind_abThres_T42);
DATA_tog(3,1:length(GausfitInfo3.HalfwidthMaxT4_X(1,Ind_abThres_T43)))=GausfitInfo3.HalfwidthMaxT4_X(1,Ind_abThres_T43);


[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 110, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 100, ['KKW p=', num2str(round(Pval(2),3))])


%Fig.3g' 

h5=subplot(2,5,7);
boxplot([GausfitInfo1.HalfwidthMaxT4_X(2,Ind_abThres_T41)';GausfitInfo2.HalfwidthMaxT4_X(2,Ind_abThres_T42)';GausfitInfo3.HalfwidthMaxT4_X(2,Ind_abThres_T43)'],...
    [ones(1,length(GausfitInfo1.HalfwidthMaxT4_X(2,Ind_abThres_T41)))';2*ones(1,length(GausfitInfo2.HalfwidthMaxT4_X(2,Ind_abThres_T42)))';3*ones(1,length(GausfitInfo3.HalfwidthMaxT4_X(2,Ind_abThres_T43)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Half Width Maximum-X(deg/s) ')
xlabel('Neg')
a = get(get(h5,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h5,'FontSize',13)
set(h5, 'YLim',[0 65])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.HalfwidthMaxT4_X(2,Ind_abThres_T41)))=GausfitInfo1.HalfwidthMaxT4_X(2,Ind_abThres_T41);
DATA_tog(2,1:length(GausfitInfo2.HalfwidthMaxT4_X(2,Ind_abThres_T42)))=GausfitInfo2.HalfwidthMaxT4_X(2,Ind_abThres_T42);
DATA_tog(3,1:length(GausfitInfo3.HalfwidthMaxT4_X(2,Ind_abThres_T43)))=GausfitInfo3.HalfwidthMaxT4_X(2,Ind_abThres_T43);


[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 62, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 58, ['KKW p=', num2str(round(Pval(2),3))])


%Fig.3h 
h6=subplot(2,5,3);
boxplot([GausfitInfo1.HalfwidthMaxT4_Y(1,Ind_abThres_T41)';GausfitInfo2.HalfwidthMaxT4_Y(1,Ind_abThres_T42)';GausfitInfo3.HalfwidthMaxT4_Y(1,Ind_abThres_T43)'],...
    [ones(1,length(GausfitInfo1.HalfwidthMaxT4_Y(1,Ind_abThres_T41)))';2*ones(1,length(GausfitInfo2.HalfwidthMaxT4_Y(1,Ind_abThres_T42)))';3*ones(1,length(GausfitInfo3.HalfwidthMaxT4_Y(1,Ind_abThres_T43)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Half Width Maximum-Y(ged/s) ')
xlabel('Pos')
a = get(get(h6,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h6,'FontSize',13)
set(h6, 'YLim',[-1 6])
DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.HalfwidthMaxT4_Y(1,Ind_abThres_T41)))=GausfitInfo1.HalfwidthMaxT4_Y(1,Ind_abThres_T41);
DATA_tog(2,1:length(GausfitInfo2.HalfwidthMaxT4_Y(1,Ind_abThres_T42)))=GausfitInfo2.HalfwidthMaxT4_Y(1,Ind_abThres_T42);
DATA_tog(3,1:length(GausfitInfo3.HalfwidthMaxT4_Y(1,Ind_abThres_T43)))=GausfitInfo3.HalfwidthMaxT4_Y(1,Ind_abThres_T43);


[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 5.7, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 5.3, ['KKW p=', num2str(round(Pval(2),3))])



%Fig.3h'  
h7=subplot(2,5,8);
boxplot([GausfitInfo1.HalfwidthMaxT4_Y(2,Ind_abThres_T41)';GausfitInfo2.HalfwidthMaxT4_Y(2,Ind_abThres_T42)';GausfitInfo3.HalfwidthMaxT4_Y(2,Ind_abThres_T43)'],...
    [ones(1,length(GausfitInfo1.HalfwidthMaxT4_Y(2,Ind_abThres_T41)))';2*ones(1,length(GausfitInfo2.HalfwidthMaxT4_Y(2,Ind_abThres_T42)))';3*ones(1,length(GausfitInfo3.HalfwidthMaxT4_Y(2,Ind_abThres_T43)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Half Width Maximum-Y(ged/s) ')
xlabel('Neg')
a = get(get(h7,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h7,'FontSize',13)
set(h7, 'YLim',[0 6])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.HalfwidthMaxT4_Y(2,Ind_abThres_T41)))=GausfitInfo1.HalfwidthMaxT4_Y(2,Ind_abThres_T41);
DATA_tog(2,1:length(GausfitInfo2.HalfwidthMaxT4_Y(2,Ind_abThres_T42)))=GausfitInfo2.HalfwidthMaxT4_Y(2,Ind_abThres_T42);
DATA_tog(3,1:length(GausfitInfo3.HalfwidthMaxT4_Y(2,Ind_abThres_T43)))=GausfitInfo3.HalfwidthMaxT4_Y(2,Ind_abThres_T43);


[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'})
text(1, 5.7, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 5.3, ['KKW p=', num2str(round(Pval(2),3))])



%Fig.3i 
h8=subplot(2,5,4);
boxplot([GausfitInfo1.timetoPeakT4(1,Ind_abThres_T41)';GausfitInfo2.timetoPeakT4(1,Ind_abThres_T42)';GausfitInfo3.timetoPeakT4(1,Ind_abThres_T43)'],...
    [ones(1,length(GausfitInfo1.timetoPeakT4(1,Ind_abThres_T41)))';2*ones(1,length(GausfitInfo2.timetoPeakT4(1,Ind_abThres_T42)))';3*ones(1,length(GausfitInfo3.timetoPeakT4(1,Ind_abThres_T43)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Time to Peak')
xlabel('Pos')
a = get(get(h8,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h8,'FontSize',13)
set(h8, 'YLim',[-2 0.4])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.timetoPeakT4(1,Ind_abThres_T41)))=GausfitInfo1.timetoPeakT4(1,Ind_abThres_T41);
DATA_tog(2,1:length(GausfitInfo2.timetoPeakT4(1,Ind_abThres_T42)))=GausfitInfo2.timetoPeakT4(1,Ind_abThres_T42);
DATA_tog(3,1:length(GausfitInfo3.timetoPeakT4(1,Ind_abThres_T43)))=GausfitInfo3.timetoPeakT4(1,Ind_abThres_T43);


[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1,  0.3, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.18, ['KKW p=', num2str(round(Pval(2),3))])



%Fig.3i'
h9=subplot(2,5,9);
boxplot([GausfitInfo1.timetoPeakT4(2,Ind_abThres_T41)';GausfitInfo2.timetoPeakT4(2,Ind_abThres_T42)';GausfitInfo3.timetoPeakT4(2,Ind_abThres_T43)'],...
    [ones(1,length(GausfitInfo1.timetoPeakT4(2,Ind_abThres_T41)))';2*ones(1,length(GausfitInfo2.timetoPeakT4(2,Ind_abThres_T42)))';3*ones(1,length(GausfitInfo3.timetoPeakT4(2,Ind_abThres_T43)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Time to Peak')
xlabel('Neg')
a = get(get(h9,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h9,'FontSize',13)
set(h9, 'YLim',[-2 0.4])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.timetoPeakT4(2,Ind_abThres_T41)))=GausfitInfo1.timetoPeakT4(2,Ind_abThres_T41);
DATA_tog(2,1:length(GausfitInfo2.timetoPeakT4(2,Ind_abThres_T42)))=GausfitInfo2.timetoPeakT4(2,Ind_abThres_T42);
DATA_tog(3,1:length(GausfitInfo3.timetoPeakT4(2,Ind_abThres_T43)))=GausfitInfo3.timetoPeakT4(2,Ind_abThres_T43);


[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1,  0.3, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.18, ['KKW p=', num2str(round(Pval(2),3))])




%% Now for T5



%%%%%%%%%%%%%%%%%%%%%%%%

F3=figure(11)
set(F3,'Position', [500 400 1200 550]);

%Fig.3f
h11=subplot(2,5,1);
boxplot([GausfitInfo1.Peak_amplitudeT5(1,Ind_abThres_T51)';GausfitInfo2.Peak_amplitudeT5(1,Ind_abThres_T52)';GausfitInfo3.Peak_amplitudeT5(1,Ind_abThres_T53)'],...
    [ones(1,length(GausfitInfo1.Peak_amplitudeT5(1,Ind_abThres_T51)))';2*ones(1,length(GausfitInfo2.Peak_amplitudeT5(1,Ind_abThres_T52)))'; 3*ones(1,length(GausfitInfo3.Peak_amplitudeT5(1,Ind_abThres_T53)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Peak amplitude-T5')
xlabel('Pos')
a = get(get(h11,'children'),'children');% t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h11,'FontSize',13)
set(h11, 'YLim',[0 0.015])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.Peak_amplitudeT5(1,Ind_abThres_T51)))=GausfitInfo1.Peak_amplitudeT5(1,Ind_abThres_T51);
DATA_tog(2,1:length(GausfitInfo2.Peak_amplitudeT5(1,Ind_abThres_T52)))=GausfitInfo2.Peak_amplitudeT5(1,Ind_abThres_T52);
DATA_tog(3,1:length(GausfitInfo3.Peak_amplitudeT5(1,Ind_abThres_T53)))=GausfitInfo3.Peak_amplitudeT5(1,Ind_abThres_T53);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 0.014, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.013, ['KKW p=', num2str(round(Pval(2),3))])


%Fig.3f'
h12=subplot(2,5,6)
boxplot([GausfitInfo1.Peak_amplitudeT5(2,Ind_abThres_T51)';GausfitInfo2.Peak_amplitudeT5(2,Ind_abThres_T52)';GausfitInfo3.Peak_amplitudeT5(2,Ind_abThres_T53)'],...
    [ones(1,length(GausfitInfo1.Peak_amplitudeT5(2,Ind_abThres_T51)))';2*ones(1,length(GausfitInfo2.Peak_amplitudeT5(2,Ind_abThres_T52)))'; 3*ones(1,length(GausfitInfo3.Peak_amplitudeT5(2,Ind_abThres_T53)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Peak amplitude-T5')
xlabel('Neg')
a = get(get(h12,'children'),'children');% t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h12,'FontSize',13)
set(h12, 'YLim',[-0.01 0.03])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.Peak_amplitudeT5(2,Ind_abThres_T51)))=GausfitInfo1.Peak_amplitudeT5(2,Ind_abThres_T51);
DATA_tog(2,1:length(GausfitInfo2.Peak_amplitudeT5(2,Ind_abThres_T52)))=GausfitInfo2.Peak_amplitudeT5(2,Ind_abThres_T52);
DATA_tog(3,1:length(GausfitInfo3.Peak_amplitudeT5(2,Ind_abThres_T53)))=GausfitInfo3.Peak_amplitudeT5(2,Ind_abThres_T53);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 0.028, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.025, ['KKW p=', num2str(round(Pval(2),3))])



%Fig.3g
h13=subplot(2,5,2);
boxplot([GausfitInfo1.HalfwidthMaxT5_X(1,Ind_abThres_T51)';GausfitInfo2.HalfwidthMaxT5_X(1,Ind_abThres_T52)';GausfitInfo3.HalfwidthMaxT5_X(1,Ind_abThres_T53)'],...
    [ones(1,length(GausfitInfo1.HalfwidthMaxT5_X(1,Ind_abThres_T51)))';2*ones(1,length(GausfitInfo2.HalfwidthMaxT5_X(1,Ind_abThres_T52)))';3*ones(1,length(GausfitInfo3.HalfwidthMaxT5_X(1,Ind_abThres_T53)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Half Width Maximum-X(deg/s) ')
xlabel('Pos')
a = get(get(h13,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h13,'FontSize',13)
set(h13, 'YLim',[-50 120])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.HalfwidthMaxT5_X(1,Ind_abThres_T51)))=GausfitInfo1.HalfwidthMaxT5_X(1,Ind_abThres_T51);
DATA_tog(2,1:length(GausfitInfo2.HalfwidthMaxT5_X(1,Ind_abThres_T52)))=GausfitInfo2.HalfwidthMaxT5_X(1,Ind_abThres_T52);
DATA_tog(3,1:length(GausfitInfo3.HalfwidthMaxT5_X(1,Ind_abThres_T53)))=GausfitInfo3.HalfwidthMaxT5_X(1,Ind_abThres_T53);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 110, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 100, ['KKW p=', num2str(round(Pval(2),3))])

%Fig.3g'
h14=subplot(2,5,7);
boxplot([GausfitInfo1.HalfwidthMaxT5_X(2,Ind_abThres_T51)';GausfitInfo2.HalfwidthMaxT5_X(2,Ind_abThres_T52)';GausfitInfo3.HalfwidthMaxT5_X(2,Ind_abThres_T53)'],...
    [ones(1,length(GausfitInfo1.HalfwidthMaxT5_X(2,Ind_abThres_T51)))';2*ones(1,length(GausfitInfo2.HalfwidthMaxT5_X(2,Ind_abThres_T52)))';3*ones(1,length(GausfitInfo3.HalfwidthMaxT5_X(2,Ind_abThres_T53)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Half Width Maximum-X(deg/s) ')
xlabel('Neg')
a = get(get(h14,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h14,'FontSize',13)
set(h14, 'YLim',[-10 30])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.HalfwidthMaxT5_X(2,Ind_abThres_T51)))=GausfitInfo1.HalfwidthMaxT5_X(2,Ind_abThres_T51);
DATA_tog(2,1:length(GausfitInfo2.HalfwidthMaxT5_X(2,Ind_abThres_T52)))=GausfitInfo2.HalfwidthMaxT5_X(2,Ind_abThres_T52);
DATA_tog(3,1:length(GausfitInfo3.HalfwidthMaxT5_X(2,Ind_abThres_T53)))=GausfitInfo3.HalfwidthMaxT5_X(2,Ind_abThres_T53);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 25, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 29, ['KKW p=', num2str(round(Pval(2),3))])


%Fig.3h
h15=subplot(2,5,3);
boxplot([GausfitInfo1.HalfwidthMaxT5_Y(1,Ind_abThres_T51)';GausfitInfo2.HalfwidthMaxT5_Y(1,Ind_abThres_T52)';GausfitInfo3.HalfwidthMaxT5_Y(1,Ind_abThres_T53)'],...
    [ones(1,length(GausfitInfo1.HalfwidthMaxT5_Y(1,Ind_abThres_T51)))';2*ones(1,length(GausfitInfo2.HalfwidthMaxT5_Y(1,Ind_abThres_T52)))';3*ones(1,length(GausfitInfo3.HalfwidthMaxT5_Y(1,Ind_abThres_T53)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Half Width Maximum-Y(ged/s) ')
xlabel('Pos')
a = get(get(h15,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h15,'FontSize',13)
set(h15, 'YLim',[-1 6])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.HalfwidthMaxT5_Y(1,Ind_abThres_T51)))=GausfitInfo1.HalfwidthMaxT5_Y(1,Ind_abThres_T51);
DATA_tog(2,1:length(GausfitInfo2.HalfwidthMaxT5_Y(1,Ind_abThres_T52)))=GausfitInfo2.HalfwidthMaxT5_Y(1,Ind_abThres_T52);
DATA_tog(3,1:length(GausfitInfo3.HalfwidthMaxT5_Y(1,Ind_abThres_T53)))=GausfitInfo3.HalfwidthMaxT5_Y(1,Ind_abThres_T53);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 5.7, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 5.3, ['KKW p=', num2str(round(Pval(2),3))])



%Fig.3h'
h16=subplot(2,5,8);
boxplot([GausfitInfo1.HalfwidthMaxT5_Y(2,Ind_abThres_T51)';GausfitInfo2.HalfwidthMaxT5_Y(2,Ind_abThres_T52)';GausfitInfo3.HalfwidthMaxT5_Y(2,Ind_abThres_T53)'],...
    [ones(1,length(GausfitInfo1.HalfwidthMaxT5_Y(2,Ind_abThres_T51)))';2*ones(1,length(GausfitInfo2.HalfwidthMaxT5_Y(2,Ind_abThres_T52)))';3*ones(1,length(GausfitInfo3.HalfwidthMaxT5_Y(2,Ind_abThres_T53)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Half Width Maximum-Y(ged/s) ')
xlabel('Neg')
a = get(get(h16,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h16,'FontSize',13)
set(h16, 'YLim',[0 7])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.HalfwidthMaxT5_Y(2,Ind_abThres_T51)))=GausfitInfo1.HalfwidthMaxT5_Y(2,Ind_abThres_T51);
DATA_tog(2,1:length(GausfitInfo2.HalfwidthMaxT5_Y(2,Ind_abThres_T52)))=GausfitInfo2.HalfwidthMaxT5_Y(2,Ind_abThres_T52);
DATA_tog(3,1:length(GausfitInfo3.HalfwidthMaxT5_Y(2,Ind_abThres_T53)))=GausfitInfo3.HalfwidthMaxT5_Y(2,Ind_abThres_T53);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 6.7, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 6.3, ['KKW p=', num2str(round(Pval(2),3))])


%Fig.3i
h17=subplot(2,5,4);
boxplot([GausfitInfo1.timetoPeakT5(1,Ind_abThres_T51)';GausfitInfo2.timetoPeakT5(1,Ind_abThres_T52)';GausfitInfo3.timetoPeakT5(1,Ind_abThres_T53)'],...
    [ones(1,length(GausfitInfo1.timetoPeakT5(1,Ind_abThres_T51)))';2*ones(1,length(GausfitInfo2.timetoPeakT5(1,Ind_abThres_T52)))';3*ones(1,length(GausfitInfo3.timetoPeakT5(1,Ind_abThres_T53)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Time to Peak')
xlabel('Pos')
a = get(get(h17,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h17,'FontSize',13)
set(h17, 'YLim',[-2 0.4])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.timetoPeakT5(1,Ind_abThres_T51)))=GausfitInfo1.timetoPeakT5(1,Ind_abThres_T51);
DATA_tog(2,1:length(GausfitInfo2.timetoPeakT5(1,Ind_abThres_T52)))=GausfitInfo2.timetoPeakT5(1,Ind_abThres_T52);
DATA_tog(3,1:length(GausfitInfo3.timetoPeakT5(1,Ind_abThres_T53)))=GausfitInfo3.timetoPeakT5(1,Ind_abThres_T53);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 0.3, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.18, ['KKW p=', num2str(round(Pval(2),3))])


%Fig.3i'
h18=subplot(2,5,9);
boxplot([GausfitInfo1.timetoPeakT5(2,Ind_abThres_T51)';GausfitInfo2.timetoPeakT5(2,Ind_abThres_T52)';GausfitInfo3.timetoPeakT5(2,Ind_abThres_T53)'],...
    [ones(1,length(GausfitInfo1.timetoPeakT5(2,Ind_abThres_T51)))';2*ones(1,length(GausfitInfo2.timetoPeakT5(2,Ind_abThres_T52)))';3*ones(1,length(GausfitInfo3.timetoPeakT5(2,Ind_abThres_T53)))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('Time to Peak')
xlabel('Neg')
a = get(get(h18,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h18,'FontSize',13)
set(h18, 'YLim',[-2 0.4])
% 
DATA_tog=nan(3,50);
DATA_tog(1,1:length(GausfitInfo1.timetoPeakT5(2,Ind_abThres_T51)))=GausfitInfo1.timetoPeakT5(2,Ind_abThres_T51);
DATA_tog(2,1:length(GausfitInfo2.timetoPeakT5(2,Ind_abThres_T52)))=GausfitInfo2.timetoPeakT5(2,Ind_abThres_T52);
DATA_tog(3,1:length(GausfitInfo3.timetoPeakT5(2,Ind_abThres_T53)))=GausfitInfo3.timetoPeakT5(2,Ind_abThres_T53);

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'});
text(1, 0.32, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.25, ['KKW p=', num2str(round(Pval(2),3))])


%% Plot the tilt of the Gaussian to know TF tuning:
LayerID1=GausfitInfo1.LayerID_T4(Ind_abThres_T41); %Extract all Cells from Layer 1 and 4 that are above the fitting thresh
LayerID2=GausfitInfo2.LayerID_T4(Ind_abThres_T42); %Extract all Cells from Layer 1 and 4 that are above the fitting thresh
LayerID3=GausfitInfo3.LayerID_T4(Ind_abThres_T43); %Extract all Cells from Layer 1 and 4 that are above the fitting thresh

Thetha1=GausfitInfo1.theta_T4(:,Ind_abThres_T41);
Thetha2=GausfitInfo2.theta_T4(:,Ind_abThres_T42);
Thetha3=GausfitInfo3.theta_T4(:,Ind_abThres_T43);

SigmaX1=GausfitInfo1.SigmaX_T4(:,Ind_abThres_T41);
SigmaX2=GausfitInfo2.SigmaX_T4(:,Ind_abThres_T42);
SigmaX3=GausfitInfo3.SigmaX_T4(:,Ind_abThres_T43);

SigmaY1=GausfitInfo1.SigmaY_T4(:,Ind_abThres_T41);
SigmaY2=GausfitInfo2.SigmaY_T4(:,Ind_abThres_T42);
SigmaY3=GausfitInfo3.SigmaY_T4(:,Ind_abThres_T43);
%%% 


Layer1u4_1=[find(LayerID1==1),find(LayerID1==4)];
Layer1u4_2=[find(LayerID2==1),find(LayerID2==4)];
Layer1u4_3=[find(LayerID3==1),find(LayerID3==4)];

Theta1u4_1=Thetha1(:,Layer1u4_1);
Theta1u4_2=Thetha2(:,Layer1u4_2);
Theta1u4_3=Thetha3(:,Layer1u4_3);

SigmaX1u4_1=SigmaX1(:,Layer1u4_1);
SigmaX1u4_2=SigmaX2(:,Layer1u4_2);
SigmaX1u4_3=SigmaX3(:,Layer1u4_3);

SigmaY1u4_1=SigmaY1(:,Layer1u4_1);
SigmaY1u4_2=SigmaY2(:,Layer1u4_2);
SigmaY1u4_3=SigmaY3(:,Layer1u4_3);

SigmaX1u4_1(2,:)>SigmaY1u4_1(2,:);

Slope_1u4_1=tan(deg2rad(Theta1u4_1(2,:)));
Slope_1u4_2=tan(deg2rad(Theta1u4_2(2,:)));
Slope_1u4_3=tan(deg2rad(Theta1u4_3(2,:)));

%Fig.3j'
figure(10)
h19=subplot(2,5,5);
boxplot([Slope_1u4_1';Slope_1u4_2';Slope_1u4_3'],...
    [ones(1,length(Slope_1u4_1))';2*ones(1,length(Slope_1u4_2))';3*ones(1,length(Slope_1u4_3))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('slope Layer 1&4')
xlabel('Neg')
a = get(get(h19,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h19,'FontSize',13)
set(h19, 'YLim',[-0.2 0.2])


DATA_tog=nan(3,50);
DATA_tog(1,1:length(Slope_1u4_1))=Slope_1u4_1;
DATA_tog(2,1:length(Slope_1u4_2))=Slope_1u4_2;
DATA_tog(3,1:length(Slope_1u4_3))=Slope_1u4_3;

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'})
text(1, 0.17, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.14, ['KKW p=', num2str(round(Pval(2),3))])



Layer2u3_1=[find(LayerID1==2),find(LayerID1==3)];
Layer2u3_2=[find(LayerID2==2),find(LayerID2==3)];
Layer2u3_3=[find(LayerID3==2),find(LayerID3==3)];


Theta2u3_1=Thetha1(:,Layer2u3_1);
Theta2u3_2=Thetha2(:,Layer2u3_2);
Theta2u3_3=Thetha3(:,Layer2u3_3);

SigmaX2u3_1=SigmaX1(:,Layer2u3_1);
SigmaX2u3_2=SigmaX2(:,Layer2u3_2);
SigmaX2u3_3=SigmaX3(:,Layer2u3_3);

SigmaY2u3_1=SigmaY1(:,Layer2u3_1);
SigmaY2u3_2=SigmaY2(:,Layer2u3_2);
SigmaY2u3_3=SigmaY3(:,Layer2u3_3);

SigmaX1u4_1(2,:)>SigmaY1u4_1(2,:);

Slope_2u3_1=tan(deg2rad(Theta2u3_1(2,:)));
Slope_2u3_2=tan(deg2rad(Theta2u3_2(2,:)));
Slope_2u3_3=tan(deg2rad(Theta2u3_3(2,:)));


h10=subplot(2,5,10);

boxplot([Slope_2u3_1';Slope_2u3_2';Slope_2u3_3'],...
    [ones(1,length(Slope_2u3_1))';2*ones(1,length(Slope_2u3_2))';3*ones(1,length(Slope_2u3_3))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('slope Layer 2&3')
xlabel('Neg')
a = get(get(h10,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h10,'FontSize',13)
set(h10, 'YLim',[-0.2 0.2])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(Slope_2u3_1))=Slope_2u3_1;
DATA_tog(2,1:length(Slope_2u3_2))=Slope_2u3_2;
DATA_tog(3,1:length(Slope_2u3_3))=Slope_2u3_3;

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'})
text(1, 0.17, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.14, ['KKW p=', num2str(round(Pval(2),3))])





%% Now for T5 

LayerID1=GausfitInfo1.LayerID_T5(Ind_abThres_T51); %Extract all Cells from Layer 1 and 4 that are above the fitting thresh
LayerID2=GausfitInfo2.LayerID_T5(Ind_abThres_T52); %Extract all Cells from Layer 1 and 4 that are above the fitting thresh
LayerID3=GausfitInfo3.LayerID_T5(Ind_abThres_T53); %Extract all Cells from Layer 1 and 4 that are above the fitting thresh

Thetha1=GausfitInfo1.theta_T5(:,Ind_abThres_T51);
Thetha2=GausfitInfo2.theta_T5(:,Ind_abThres_T52);
Thetha3=GausfitInfo3.theta_T5(:,Ind_abThres_T53);

SigmaX1=GausfitInfo1.SigmaX_T5(:,Ind_abThres_T51);
SigmaX2=GausfitInfo2.SigmaX_T5(:,Ind_abThres_T52);
SigmaX3=GausfitInfo3.SigmaX_T5(:,Ind_abThres_T53);

SigmaY1=GausfitInfo1.SigmaY_T5(:,Ind_abThres_T51);
SigmaY2=GausfitInfo2.SigmaY_T5(:,Ind_abThres_T52);
SigmaY3=GausfitInfo3.SigmaY_T5(:,Ind_abThres_T53);
%%% 


Layer1u4_1=[find(LayerID1==1),find(LayerID1==4)];
Layer1u4_2=[find(LayerID2==1),find(LayerID2==4)];
Layer1u4_3=[find(LayerID3==1),find(LayerID3==4)];

Theta1u4_1=Thetha1(:,Layer1u4_1);
Theta1u4_2=Thetha2(:,Layer1u4_2);
Theta1u4_3=Thetha3(:,Layer1u4_3);

SigmaX1u4_1=SigmaX1(:,Layer1u4_1);
SigmaX1u4_2=SigmaX2(:,Layer1u4_2);
SigmaX1u4_3=SigmaX3(:,Layer1u4_3);

SigmaY1u4_1=SigmaY1(:,Layer1u4_1);
SigmaY1u4_2=SigmaY2(:,Layer1u4_2);
SigmaY1u4_3=SigmaY3(:,Layer1u4_3);

% SigmaX1u4_1(2,:)>SigmaY1u4_1(2,:);

Slope_1u4_1=tan(deg2rad(Theta1u4_1(1,:))); %For T5 I take the slope of the 'positive subfield' 
Slope_1u4_2=tan(deg2rad(Theta1u4_2(1,:)));
Slope_1u4_3=tan(deg2rad(Theta1u4_3(1,:)));


figure(11)
%Fig.3j

h11=subplot(2,5,5)
boxplot([Slope_1u4_1';Slope_1u4_2';Slope_1u4_3'],...
    [ones(1,length(Slope_1u4_1))';2*ones(1,length(Slope_1u4_2))';3*ones(1,length(Slope_1u4_3))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('slope')
xlabel('Pos')
a = get(get(h11,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h11,'FontSize',13)
set(h11, 'YLim',[-0.2 0.2])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(Slope_1u4_1))=Slope_1u4_1;
DATA_tog(2,1:length(Slope_1u4_2))=Slope_1u4_2;
DATA_tog(3,1:length(Slope_1u4_3))=Slope_1u4_3;

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'})
text(1, 0.17, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.14, ['KKW p=', num2str(round(Pval(2),3))])




Layer2u3_1=[find(LayerID1==2),find(LayerID1==3)];
Layer2u3_2=[find(LayerID2==2),find(LayerID2==3)];
Layer2u3_3=[find(LayerID3==2),find(LayerID3==3)];


Theta2u3_1=Thetha1(:,Layer2u3_1);
Theta2u3_2=Thetha2(:,Layer2u3_2);
Theta2u3_3=Thetha3(:,Layer2u3_3);

SigmaX2u3_1=SigmaX1(:,Layer2u3_1);
SigmaX2u3_2=SigmaX2(:,Layer2u3_2);
SigmaX2u3_3=SigmaX3(:,Layer2u3_3);

SigmaY2u3_1=SigmaY1(:,Layer2u3_1);
SigmaY2u3_2=SigmaY2(:,Layer2u3_2);
SigmaY2u3_3=SigmaY3(:,Layer2u3_3);

% SigmaX1u4_1(2,:)>SigmaY1u4_1(2,:);

Slope_2u3_1=tan(deg2rad(Theta2u3_1(1,:)));
Slope_2u3_2=tan(deg2rad(Theta2u3_2(1,:)));
Slope_2u3_3=tan(deg2rad(Theta2u3_3(1,:)));


h12=subplot(2,5,10)
boxplot([Slope_2u3_1';Slope_2u3_2';Slope_2u3_3'],...
    [ones(1,length(Slope_2u3_1))';2*ones(1,length(Slope_2u3_2))';3*ones(1,length(Slope_2u3_3))'],...
    'notch', 'on', 'labels', {'Control','C2Kir','C3Kir'})
ylabel('slope Layer 2&3')
xlabel('Pos')
a = get(get(h12,'children'),'children'); t = get(a,'tag');   % List the names of all the objects 
box1 = a(7);  box2= a(8); box3= a(9); Median1=a(4); Median2=a(5); Median3=a(6);
set(box1, 'Color', '[0.2 0.5 0.2]', 'Linewidth', 2); set(box2, 'Color','[0.55 0.4 0.55]', 'Linewidth', 2); set(box3, 'Color', '[0.4 0.4 0.4]', 'Linewidth', 2);   
set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');     % 
set(h12,'FontSize',13)
set(h12, 'YLim',[-0.2 0.2])

DATA_tog=nan(3,50);
DATA_tog(1,1:length(Slope_2u3_1))=Slope_2u3_1;
DATA_tog(2,1:length(Slope_2u3_2))=Slope_2u3_2;
DATA_tog(3,1:length(Slope_2u3_3))=Slope_2u3_3;

[Pval,N1,N2]=Multcomp_Stats(DATA_tog, {'Control', 'C2sil', 'C3Sil'})
text(1, 0.17, ['KKW p=', num2str(round(Pval(1),3))])
text(1, 0.14, ['KKW p=', num2str(round(Pval(2),3))])


end 

