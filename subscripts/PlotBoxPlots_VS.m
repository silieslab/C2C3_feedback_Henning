
function [F5,F6,F7]=PlotBoxPlots_VS(Conditions,Average)


Con= fields(Conditions);
Ncon=length(Con);

Z_T5=nan(Ncon,1500);
Z_T4=nan(Ncon,1500);
NT4=[];
NT5=[];
Z_abs_allCond=[]; 
        
for i=1:Ncon

    Condi=eval(['Conditions.', Con{i}]);
    Z_condi_ON= Condi.ON.Z;
    Z_condi_OFF= Condi.OFF.Z;
    
    Z_abs=nan(8,1000);
    
    if Average

        % VL_M is now the average of the vector length of all cells from each Fly
        Z_abs(1,1:length(Z_condi_ON.T4A.VL_M))=abs(Z_condi_ON.T4A.VL_M);
        Z_abs(2,1:length(Z_condi_ON.T4B.VL_M))=abs(Z_condi_ON.T4B.VL_M);
        Z_abs(3,1:length(Z_condi_ON.T4C.VL_M))=abs(Z_condi_ON.T4C.VL_M);
        Z_abs(4,1:length(Z_condi_ON.T4D.VL_M))=abs(Z_condi_ON.T4D.VL_M);
        Z_abs(5,1:length(Z_condi_OFF.T5A.VL_M))=abs(Z_condi_OFF.T5A.VL_M);
        Z_abs(6,1:length(Z_condi_OFF.T5B.VL_M))=abs(Z_condi_OFF.T5B.VL_M);
        Z_abs(7,1:length(Z_condi_OFF.T5C.VL_M))=abs(Z_condi_OFF.T5C.VL_M);
        Z_abs(8,1:length(Z_condi_OFF.T5D.VL_M))=abs(Z_condi_OFF.T5D.VL_M);
        NT4=[NT4,length(Z_condi_ON.T4A.M)];
        NT5=[NT5,length(Z_condi_ON.T5A.M)];

    else
        Z_abs(1,1:length(Z_condi_ON.T4A.ALL))=abs(Z_condi_ON.T4A.ALL);
        Z_abs(2,1:length(Z_condi_ON.T4B.ALL))=abs(Z_condi_ON.T4B.ALL);
        Z_abs(3,1:length(Z_condi_ON.T4C.ALL))=abs(Z_condi_ON.T4C.ALL);
        Z_abs(4,1:length(Z_condi_ON.T4D.ALL))=abs(Z_condi_ON.T4D.ALL);
        Z_abs(5,1:length(Z_condi_OFF.T5A.ALL))=abs(Z_condi_OFF.T5A.ALL);
        Z_abs(6,1:length(Z_condi_OFF.T5B.ALL))=abs(Z_condi_OFF.T5B.ALL);
        Z_abs(7,1:length(Z_condi_OFF.T5C.ALL))=abs(Z_condi_OFF.T5C.ALL);
        Z_abs(8,1:length(Z_condi_OFF.T5D.ALL))=abs(Z_condi_OFF.T5D.ALL);
        NT4=[NT4,length(Z_condi_ON.T4A.ALL)+length(Z_condi_ON.T4B.ALL)+length(Z_condi_ON.T4C.ALL)+length(Z_condi_ON.T4D.ALL)];
        NT5=[NT5,length(Z_condi_OFF.T5A.ALL)+length(Z_condi_OFF.T5B.ALL)+length(Z_condi_OFF.T5C.ALL)+length(Z_condi_OFF.T5D.ALL)];
    end
    
   
    if Average
               
%       Z_all_i_T5=abs(cat(2,Z_condi_OFF.T5A.M,Z_condi_OFF.T5B.M,Z_condi_OFF.T5C.M,Z_condi_OFF.T5D.M));
        Z_all_i_T5=Z_condi_OFF.T5.VL_M;
        Z_T5(i,1:length(Z_all_i_T5))=Z_all_i_T5;
        
%       Z_all_i_T4=abs(cat(2,Z_condi_ON.T4A.M,Z_condi_ON.T4B.M,Z_condi_ON.T4C.M,Z_condi_ON.T4D.M));
        Z_all_i_T4=Z_condi_OFF.T4.VL_M;
        Z_T4(i,1:length(Z_all_i_T4))=Z_all_i_T4;
        
       
    else
               
        Z_all_i_T5=abs(cat(2,Z_condi_OFF.T5A.ALL,Z_condi_OFF.T5B.ALL,Z_condi_OFF.T5C.ALL,Z_condi_OFF.T5D.ALL));
        Z_T5(i,1:length(Z_all_i_T5))=Z_all_i_T5;

        
        Z_all_i_T4=abs(cat(2,Z_condi_ON.T4A.ALL,Z_condi_ON.T4B.ALL,Z_condi_ON.T4C.ALL,Z_condi_ON.T4D.ALL));
        Z_T4(i,1:length(Z_all_i_T4))=Z_all_i_T4;
    end
    
   Z_abs_allCond{i}= Z_abs'; 
   
end




%%

% Restructure Data 

LayerA_T4=[];   LayerA_T5=[];
LayerB_T4=[];   LayerB_T5=[];
LayerC_T4=[];   LayerC_T5=[];
LayerD_T4=[];   LayerD_T5=[];

for iii=1:Ncon
    LayerA_T4=[LayerA_T4,Z_abs_allCond{1,iii}(:,1)];
    LayerB_T4=[LayerB_T4,Z_abs_allCond{1,iii}(:,2)];
    LayerC_T4=[LayerC_T4,Z_abs_allCond{1,iii}(:,3)];
    LayerD_T4=[LayerD_T4,Z_abs_allCond{1,iii}(:,4)];
    
    LayerA_T5=[LayerA_T5,Z_abs_allCond{1,iii}(:,5)];
    LayerB_T5=[LayerB_T5,Z_abs_allCond{1,iii}(:,6)];
    LayerC_T5=[LayerC_T5,Z_abs_allCond{1,iii}(:,7)];
    LayerD_T5=[LayerD_T5,Z_abs_allCond{1,iii}(:,8)];
end
 
%% Suppl. Fig. 4 

F7=figure(7); 
set(F7, 'Position', [400 400 950 800])

sb1=subplot(4,1,1);
Num=[length(find(~isnan(LayerA_T4(:,1)))),length(find(~isnan(LayerA_T4(:,2)))),length(find(~isnan(LayerA_T4(:,3)))),length(find(~isnan(LayerA_T4(:,4)))),...
    length(find(~isnan(LayerA_T5(:,1)))),length(find(~isnan(LayerA_T5(:,2)))),length(find(~isnan(LayerA_T5(:,3)))),length(find(~isnan(LayerA_T5(:,4))))];
Label=[];
Con2=[Con;Con];
for nl=1:length(Con2)
    Label=[Label,strcat(Con2(nl),' (', num2str(Num(nl)), ')')];
end
boxplot([LayerA_T4,LayerA_T5],'notch', 'on', 'labels',Label)
sb1.Title.String= [T, '- LayerA'];


sb2=subplot(4,1,2);
Num=[length(find(~isnan(LayerB_T4(:,1)))),length(find(~isnan(LayerB_T4(:,2)))),length(find(~isnan(LayerB_T4(:,3)))),length(find(~isnan(LayerB_T4(:,4)))),...
    length(find(~isnan(LayerB_T5(:,1)))),length(find(~isnan(LayerB_T5(:,2)))),length(find(~isnan(LayerB_T5(:,3)))),length(find(~isnan(LayerB_T5(:,4))))];
Label=[];
Con2=[Con;Con];
for nl=1:length(Con2)
    Label=[Label,strcat(Con2(nl),' (', num2str(Num(nl)), ')')];
end
boxplot([LayerB_T4,LayerB_T5],'notch', 'on', 'labels',Label)
sb2.Title.String= [ '- LayerB'];


sb3=subplot(4,1,3);
Num=[length(find(~isnan(LayerC_T4(:,1)))),length(find(~isnan(LayerC_T4(:,2)))),length(find(~isnan(LayerC_T4(:,3)))),length(find(~isnan(LayerC_T4(:,4)))),...
    length(find(~isnan(LayerC_T5(:,1)))),length(find(~isnan(LayerC_T5(:,2)))),length(find(~isnan(LayerC_T5(:,3)))),length(find(~isnan(LayerC_T5(:,4))))];
Label=[];
Con2=[Con;Con];
for nl=1:length(Con2)
    Label=[Label,strcat(Con2(nl),' (', num2str(Num(nl)), ')')];
end
boxplot([LayerC_T4,LayerC_T5],'notch', 'on', 'labels',Label)
sb3.Title.String= [ '- LayerC'];


sb4=subplot(4,1,4);
Num=[length(find(~isnan(LayerD_T4(:,1)))),length(find(~isnan(LayerD_T4(:,2)))),length(find(~isnan(LayerD_T4(:,3)))),length(find(~isnan(LayerD_T4(:,4)))),...
    length(find(~isnan(LayerD_T5(:,1)))),length(find(~isnan(LayerD_T5(:,2)))),length(find(~isnan(LayerD_T5(:,3)))),length(find(~isnan(LayerD_T5(:,4))))];
Label=[];
Con2=[Con;Con];
for nl=1:length(Con2)
    Label=[Label,strcat(Con2(nl),' (', num2str(Num(nl)), ')')];
end
boxplot([LayerD_T4,LayerD_T5],'notch', 'on', 'labels',Label)
sb4.Title.String= [ '- LayerD'];


for i=1:4
    axes(eval(['sb', num2str(i)]))

    a = get(get(gca,'children'),'children');   % Get the handles of all the objects
    t = get(a,'tag');   % List the names of all the objects
    if Ncon==4
    %     set(F10, 'Position', [200 200 880 400])
        box1 = a(17);  box2= a(18); box3= a(19); box4 = a(20);  box5= a(21); box6= a(22); box7= a(23); box8= a(24); % The 7th object is the first box
        Median1=a(9); Median2=a(10);Median3=a(11);Median4=a(12); Median5=a(13); Median6=a(14);Median7=a(15);Median8=a(16);
        set(box1, 'Color', '[0.1 0.5 1]','Linewidth',1.5);
        set(box2, 'Color', '[0 0.5 0]','Linewidth',1.5); 
        set(box3, 'Color', '[0.75 0 0.75]','Linewidth',1.5); 
        set(box4, 'Color', '[0.5 0.5 0.5]','Linewidth',1.5); 

        set(box5, 'Color', '[0.1 0.5 1]','Linewidth',1.5);
        set(box6, 'Color', '[0 0.5 0]','Linewidth',1.5); 
        set(box7, 'Color', '[0.75 0 0.75]','Linewidth',1.5); 
        set(box8, 'Color', '[0.5 0.5 0.5]','Linewidth',1.5);

        set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');   set(Median4, 'Color', 'k');  set(Median5, 'Color', 'k');  set(Median6, 'Color', 'k'); set(Median7, 'Color', 'k'); set(Median8, 'Color', 'k');  %
        patch([4.5 10 10  4.5], [-0.1 -0.1 1.1 1.1], [0 0 0],'FaceAlpha', 0.2)

    elseif Ncon==3
    %     set(F2, 'Position', [200 200 800 400])
        box1 = a(13);  box2= a(14); box3= a(15); box4 = a(16);  box5= a(17); box6= a(18);  % The 7th object is the first box
        Median1=a(7); Median2=a(8);Median3=a(9);Median4=a(10); Median5=a(11);Median6=a(12);
        set(box1, 'Color', '[0 0.5 0]', 'Linewidth',2);  set(box2, 'Color', '[0.75 0 0.75]','Linewidth',1.5);  set(box3, 'Color', '[0.5 0.5 0.5]','Linewidth',1.5);  set(box4, 'Color', '[0 0.5 0]','Linewidth',1.5);  set(box5, 'Color', '[0.75 0 0.75]','Linewidth',1.5);  set(box6, 'Color', '[0.5 0.5 0.5]','Linewidth',1.5);
        set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');   set(Median4, 'Color', 'k');  set(Median5, 'Color', 'k');  set(Median6, 'Color', 'k');    %
        patch([3.5 10 10  3.5], [-0.1 -0.1 1.1 1.1], [0 0 0],'FaceAlpha', 0.2)

    end 
    set(gca,'YLim', [-0.01 1]);
    set(gca, 'FontSize', 12)

end 

%% Fig. 4b

F6 =figure(6);
Num=[NT4,NT5];
Label=[];
Con2=[Con;Con];
for nl=1:length(Con2)
    Label=[Label,strcat(Con2(nl),' (', num2str(Num(nl)), ')')];
end
boxplot([Z_T4;Z_T5]','notch', 'on', 'labels',Label)

F6.Children.Title.String=T;
a = F6.Children.Children.Children;    % Get the handles of all the objects
% t = get(a,'tag');   % List the names of all the objects
if Ncon==4
    set(F6, 'Position', [200 200 1000 400])
    box1 = a(17);  box2= a(18); box3= a(19); box4 = a(20);  box5= a(21); box6= a(22); box7= a(23); box8= a(24); % The 7th object is the first box
    Median1=a(9); Median2=a(10);Median3=a(11);Median4=a(12); Median5=a(13); Median6=a(14);Median7=a(15);Median8=a(16);
    set(box1, 'Color', '[0.1 0.5 1]','Linewidth',1.5);
    set(box2, 'Color', '[0 0.5 0]','Linewidth',1.5); 
    set(box3, 'Color', '[0.75 0 0.75]','Linewidth',1.5); 
    set(box4, 'Color', '[0.5 0.5 0.5]','Linewidth',1.5); 
    
    set(box5, 'Color', '[0.1 0.5 1]','Linewidth',1.5);
    set(box6, 'Color', '[0 0.5 0]','Linewidth',1.5); 
    set(box7, 'Color', '[0.75 0 0.75]','Linewidth',1.5); 
    set(box8, 'Color', '[0.5 0.5 0.5]','Linewidth',1.5);
    
    set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');   set(Median4, 'Color', 'k');  set(Median5, 'Color', 'k');  set(Median6, 'Color', 'k'); set(Median7, 'Color', 'k'); set(Median8, 'Color', 'k');  %
    F6=figure(6);
    hold on
    patch([4.5 10 10  4.5], [-0.1 -0.1 1.1 1.1], [0 0 0],'FaceAlpha', 0.2)

elseif Ncon==3
    set(F6, 'Position', [200 200 800 400])
    box1 = a(13);  box2= a(14); box3= a(15); box4 = a(16);  box5= a(17); box6= a(18);  % The 7th object is the first box
    Median1=a(7); Median2=a(8);Median3=a(9);Median4=a(10); Median5=a(11);Median6=a(12);
    set(box1, 'Color', '[0 0.5 0]', 'Linewidth',2);  set(box2, 'Color', '[0.75 0 0.75]','Linewidth',1.5);  set(box3, 'Color', '[0.5 0.5 0.5]','Linewidth',1.5);  set(box4, 'Color', '[0 0.5 0]','Linewidth',1.5);  set(box5, 'Color', '[0.75 0 0.75]','Linewidth',1.5);  set(box6, 'Color', '[0.5 0.5 0.5]','Linewidth',1.5);
    set(Median1, 'Color', 'k');  set(Median2, 'Color', 'k');  set(Median3, 'Color', 'k');   set(Median4, 'Color', 'k');  set(Median5, 'Color', 'k');  set(Median6, 'Color', 'k');    %
    F6=figure(6);
    hold on
    patch([3.5 10 10  3.5], [-0.1 -0.1 1.1 1.1], [0 0 0],'FaceAlpha', 0.2)

end 
set(F6.Children,'YLim', [-0.01 1]);
set(F6.Children, 'FontSize', 12)




%% 
 %Statistics:
%----------------------------

% Test for normal distribution 

% [h] = lillietest(Z_T4(1,:)) % can handle NaNs, H=0 means Data are normally distributed
% [h] = lillietest(Z_T4(2,:))
% [h] = lillietest(Z_T4(3,:))
% [h] = lillietest(Z_T4(4,:))
% 
% [h] = lillietest(Z_T5(1,:))
% [h] = lillietest(Z_T5(2,:))
% [h] = lillietest(Z_T5(3,:))
% [h] = lillietest(Z_T5(4,:))
% 
% [h] = lillietest(LayerA_T4(1,:))
% [h] = lillietest(LayerA_T4(2,:))
% [h] = lillietest(LayerA_T4(3,:))
% [h] = lillietest(LayerA_T4(4,:))
% 
% [h] = lillietest(LayerB_T4(1,:))
% [h] = lillietest(LayerB_T4(2,:))
% [h] = lillietest(LayerB_T4(3,:))
% [h] = lillietest(LayerB_T4(4,:))
% 
% [h] = lillietest(LayerC_T4(1,:))
% [h] = lillietest(LayerC_T4(2,:))
% [h] = lillietest(LayerC_T4(3,:))
% [h] = lillietest(LayerC_T4(4,:))

% 
% for c=1:Ncon
%     for l=1:8%nLayer/T4T5
%     [h]=lillietest(Z_abs_allCond{1,Ncon}(:,l))
%     end 
% end

% All groups are normally distributed except for one, C2C3sil T5, but Aslan
% said I can ignore that and still do an ANOVA alternative would be
% Kruskalwallis test

% Restructure Data for ANOVA

LayerA_T4=[];   LayerA_T5=[];
LayerB_T4=[];   LayerB_T5=[];
LayerC_T4=[];   LayerC_T5=[];
LayerD_T4=[];   LayerD_T5=[];

for iii=1:Ncon
    LayerA_T4=[LayerA_T4,Z_abs_allCond{1,iii}(:,1)];
    LayerB_T4=[LayerB_T4,Z_abs_allCond{1,iii}(:,2)];
    LayerC_T4=[LayerC_T4,Z_abs_allCond{1,iii}(:,3)];
    LayerD_T4=[LayerD_T4,Z_abs_allCond{1,iii}(:,4)];
    
    LayerA_T5=[LayerA_T5,Z_abs_allCond{1,iii}(:,5)];
    LayerB_T5=[LayerB_T5,Z_abs_allCond{1,iii}(:,6)];
    LayerC_T5=[LayerC_T5,Z_abs_allCond{1,iii}(:,7)];
    LayerD_T5=[LayerD_T5,Z_abs_allCond{1,iii}(:,8)];
end




% Collect Data for multiple ANOVA
alli=[];
g1i=[]; 
g1=[];  %Condition Identity
g2=[];  %Layer Identity
g3=[];  %T4T5 Identity
ALL=[]; %all values 

for CC=1:4
    CCi=LayerA_T4(~isnan(LayerA_T4(:,CC)),CC);
    alli=[alli;CCi];
    g1i=[g1i;ones(length(CCi),1)*CC];%Condition Identity
end 
g1=[g1; g1i];%Condition Identity
g2=[g2; ones(length(alli),1)*1];%Layer Identity
g3=[g3; ones(length(alli),1)*4];%T4T5 Identity
ALL=[ALL;alli];


alli=[];
g1i=[]; 
for CC=1:4
    CCi=LayerB_T4(~isnan(LayerB_T4(:,CC)),CC);
    alli=[alli;CCi];
    g1i=[g1i;ones(length(CCi),1)*CC];%Condition Identity
end 
g1=[g1; g1i];%Condition Identity
g2=[g2; ones(length(alli),1)*2];%Layer Identity
g3=[g3; ones(length(alli),1)*4];%T4T5 Identity 
ALL=[ALL;alli];

alli=[];
g1i=[]; 
for CC=1:4
    CCi=LayerC_T4(~isnan(LayerC_T4(:,CC)),CC);
    alli=[alli;CCi];
    g1i=[g1i;ones(length(CCi),1)*CC];%Condition Identity
end 
g1=[g1; g1i];%Condition Identity
g2=[g2; ones(length(alli),1)*3];%Layer Identity
g3=[g3; ones(length(alli),1)*4];%T4T5 Identity 
ALL=[ALL;alli];

alli=[];
g1i=[]; 
for CC=1:4
    CCi=LayerD_T4(~isnan(LayerD_T4(:,CC)),CC);
    alli=[alli;CCi];
    g1i=[g1i;ones(length(CCi),1)*CC];%Condition Identity
end 
g1=[g1; g1i];%Condition Identity
g2=[g2; ones(length(alli),1)*4];%Layer Identity
g3=[g3; ones(length(alli),1)*4];%T4T5 Identity 
ALL=[ALL;alli];


%T5
alli=[];
g1i=[]; 
for CC=1:4
    CCi=LayerA_T5(~isnan(LayerA_T5(:,CC)),CC);
    alli=[alli;CCi];
    g1i=[g1i;ones(length(CCi),1)*CC];%Condition Identity
end 
g1=[g1; g1i];%Condition Identity
g2=[g2; ones(length(alli),1)*1];%Layer Identity
g3=[g3; ones(length(alli),1)*5];%T4T5 Identity
ALL=[ALL;alli];

alli=[];
g1i=[]; 
for CC=1:4
    CCi=LayerB_T5(~isnan(LayerB_T5(:,CC)),CC);
    alli=[alli;CCi];
    g1i=[g1i;ones(length(CCi),1)*CC];%Condition Identity
end 
g1=[g1; g1i];%Condition Identity
g2=[g2; ones(length(alli),1)*2];%Layer Identity
g3=[g3; ones(length(alli),1)*5];%T4T5 Identity 
ALL=[ALL;alli];

alli=[];
g1i=[]; 
for CC=1:4
    CCi=LayerC_T5(~isnan(LayerC_T5(:,CC)),CC);
    alli=[alli;CCi];
    g1i=[g1i;ones(length(CCi),1)*CC];%Condition Identity
end 
g1=[g1; g1i];%Condition Identity
g2=[g2; ones(length(alli),1)*3];%Layer Identity
g3=[g3; ones(length(alli),1)*5];%T4T5 Identity 
ALL=[ALL;alli];

alli=[];
g1i=[]; 
for CC=1:4
    CCi=LayerD_T5(~isnan(LayerD_T5(:,CC)),CC);
    alli=[alli;CCi];
    g1i=[g1i;ones(length(CCi),1)*CC];%Condition Identity
end

g1=[g1; g1i];%Condition Identity
g2=[g2; ones(length(alli),1)*4];%Layer Identity
g3=[g3; ones(length(alli),1)*5];%T4T5 Identity 
ALL=[ALL;alli];

%% First I calculate a multiple ANOVA anovan

[~,~,stats] = anovan(ALL,{g1,g2,g3})
[c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');


%% Now the Anova for individual groups

figure
disp('Statistics for Z_T4')
Multcomp_Stats(Z_T4,Con,'ANOVA')


disp('Statistics for Z_T5')
Multcomp_Stats(Z_T5,Con,'ANOVA')



disp('Statistiks for T4_LayerA')
Multcomp_Stats(LayerA_T4',Con,'KKW')

disp('Statistiks for T4_LayerB')
Multcomp_Stats(LayerB_T4',Con,'KKW')

disp('Statistiks for T4_LayerC')
Multcomp_Stats(LayerC_T4',Con,'KKW')

disp('Statistiks for T4_LayerD')
Multcomp_Stats(LayerD_T4',Con,'KKW')


disp('Statistiks for T5_LayerA')
Multcomp_Stats(LayerA_T5',Con,'KKW')

disp('Statistiks for T5_LayerB')
Multcomp_Stats(LayerB_T5',Con,'KKW')

disp('Statistiks for T5_LayerC')
Multcomp_Stats(LayerC_T5',Con,'KKW')

disp('Statistiks for T5_LayerD')
Multcomp_Stats(LayerD_T5',Con,'KKW')



% [~,~,stats]=anova1(Z_T4',[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% % MCT= Multiple Comparison Test
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(Z_T4(1,:))));
%     N2=length(find(~isnan(Z_T4(1+iii,:))));
%     disp(['MCT T4: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(Z_T4(2,:))));
%     N2=length(find(~isnan(Z_T4(2+iii,:))));
%     disp(['MCT T4: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(Z_T4(3,:))));
%     N2=length(find(~isnan(Z_T4(3+iii,:))));
%     disp(['MCT T4: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end 
% 
% 
% [~,~,stats]=anova1(Z_T5',[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% % MCT= Multiple Comparison Test
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(Z_T5(1,:))));
%     N2=length(find(~isnan(Z_T5(1+iii,:))));
%     disp(['MCT T5: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(Z_T5(2,:))));
%     N2=length(find(~isnan(Z_T5(2+iii,:))));
%     disp(['MCT T5: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(Z_T5(3,:))));
%     N2=length(find(~isnan(Z_T5(3+iii,:))));
%     disp(['MCT T5: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end 

%% Again for Layers sep! 



% [~,~,stats]=anova1(LayerA_T4,[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% % MCT= Multiple Comparison Test
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(LayerA_T4(:,1))));
%     N2=length(find(~isnan(LayerA_T4(:,iii+1))));
%     disp(['MCT LayerA_T4: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(LayerA_T4(:,2))));
%     N2=length(find(~isnan(LayerA_T4(:,2+iii))));
%     disp(['MCT LayerA_T4: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(LayerA_T4(:,3))));
%     N2=length(find(~isnan(LayerA_T4(:,3+iii))));
%     disp(['MCT LayerA_T4: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end 
% 
% 
% 
% [~,~,stats]=anova1(LayerB_T4,[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(LayerB_T4(:,1))));
%     N2=length(find(~isnan(LayerB_T4(:,iii+1))));
%     disp(['MCT LayerB_T4: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(LayerB_T4(:,2))));
%     N2=length(find(~isnan(LayerB_T4(:,2+iii))));
%     disp(['MCT LayerB_T4: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(LayerB_T4(:,3))));
%     N2=length(find(~isnan(LayerB_T4(:,3+iii))));
%     disp(['MCT LayerB_T4: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end
% 
% 
% [~,~,stats]=anova1(LayerC_T4,[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(LayerC_T4(:,1))));
%     N2=length(find(~isnan(LayerC_T4(:,iii+1))));
%     disp(['MCT LayerC_T4: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(LayerC_T4(:,2))));
%     N2=length(find(~isnan(LayerC_T4(:,2+iii))));
%     disp(['MCT LayerC_T4: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(LayerC_T4(:,3))));
%     N2=length(find(~isnan(LayerC_T4(:,3+iii))));
%     disp(['MCT LayerC_T4: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end
% 
% 
% [~,~,stats]=anova1(LayerD_T4,[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(LayerD_T4(:,1))));
%     N2=length(find(~isnan(LayerD_T4(:,iii+1))));
%     disp(['MCT LayerD_T4: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(LayerD_T4(:,2))));
%     N2=length(find(~isnan(LayerD_T4(:,2+iii))));
%     disp(['MCT LayerD_T4: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(LayerD_T4(:,3))));
%     N2=length(find(~isnan(LayerD_T4(:,3+iii))));
%     disp(['MCT LayerD_T4: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end
% 

%% 
% [~,~,stats]=anova1(LayerA_T5,[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% % MCT= Multiple Comparison Test
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(LayerA_T5(:,1))));
%     N2=length(find(~isnan(LayerA_T5(:,iii+1))));
%     disp(['MCT LayerA_T5: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(LayerA_T5(:,2))));
%     N2=length(find(~isnan(LayerA_T5(:,2+iii))));
%     disp(['MCT LayerA_T5: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(LayerA_T5(:,3))));
%     N2=length(find(~isnan(LayerA_T5(:,3+iii))));
%     disp(['MCT LayerA_T5: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end 
% 
% 
% 
% [~,~,stats]=anova1(LayerB_T5,[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(LayerB_T5(:,1))));
%     N2=length(find(~isnan(LayerB_T5(:,iii+1))));
%     disp(['MCT LayerB_T5: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(LayerB_T5(:,2))));
%     N2=length(find(~isnan(LayerB_T5(:,2+iii))));
%     disp(['MCT LayerB_T5: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(LayerB_T5(:,3))));
%     N2=length(find(~isnan(LayerB_T5(:,3+iii))));
%     disp(['MCT LayerB_T5: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end
% 
% 
% [~,~,stats]=anova1(LayerC_T5,[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(LayerC_T5(:,1))));
%     N2=length(find(~isnan(LayerC_T5(:,iii+1))));
%     disp(['MCT LayerC_T5: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(LayerC_T5(:,2))));
%     N2=length(find(~isnan(LayerC_T5(:,2+iii))));
%     disp(['MCT LayerC_T5: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(LayerC_T5(:,3))));
%     N2=length(find(~isnan(LayerC_T5(:,3+iii))));
%     disp(['MCT LayerC_T5: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end
% 
% 
% [~,~,stats]=anova1(LayerD_T5,[], 'off'); % It ignores NaNs!! (I tested with the group option, removing all NaNs and get the same statistics
% [c,~,~,~] = multcompare(stats, 'CType', 'bonferroni','Display', 'off');
% 
% Pval=c(:,6);
% for iii=1:Ncon-1
%     N1=length(find(~isnan(LayerD_T5(:,1))));
%     N2=length(find(~isnan(LayerD_T5(:,iii+1))));
%     disp(['MCT LayerD_T5: ', Con{1}, '(N=', num2str(N1),')- ' Con{1+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(iii))])
% end 
% for iii=1:Ncon-2
%     N1=length(find(~isnan(LayerD_T5(:,2))));
%     N2=length(find(~isnan(LayerD_T5(:,2+iii))));
%     disp(['MCT LayerD_T5: ', Con{2}, '(N=', num2str(N1),')- ' Con{2+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(3+iii))])
% end 
% for iii=1:Ncon-3
%     N1=length(find(~isnan(LayerD_T5(:,3))));
%     N2=length(find(~isnan(LayerD_T5(:,3+iii))));
%     disp(['MCT LayerD_T5: ', Con{3}, '(N=', num2str(N1),')- ' Con{3+iii}, '(N=', num2str(N2),') p-value: ', num2str(Pval(5+iii))])
% end
% 
% 
% 
% 





end