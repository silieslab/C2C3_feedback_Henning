

%% NEW from Janelia website http://emanalysis.janelia.org/flyem_tables.php  (03.02.2021)
% 'home' against 'other'    add 'instance' to columns visible to see if the column identy of the neuron connection

%% Outputs from C2: 

L1=[25,0;21,0;31,0; 31,0; 30,0;17,0;24,0]
L2=[14,0;9,0;21,0;20,0;19,0;9,0;12,0]
L3=[4,0;3,0;5,0;10,0;11,0;0,0;0,0]
L4=[0,23;0,2;1,0;0,0;0,6;0,9;0,8]
L5=[36,9;21,0;29,1;25,0;28,0;21,0;24,0]
Mi1=[17,0;15,0;21,0;17,0;10,0;9,1;16,0]
Tm1=[13,0;4,0;4,0;3,0;8,0;10,0;6,0]
T1=[5,0;1,0;9,0;3,0;9,0;8,0;3,0]
C3=[4,0;0,0;3,0;0,0;1,0;1,0;0,0]
Mi4=[4,0;0,0;3,0;0,0;1,0;1,0;0,0]
TM9=[0,0;8,0;4,0;2,0;0,0;0,0;0,0]

figure
C2Can=[mean(L5);mean(L1);mean(Mi1);mean(L2);mean(L4);mean(Tm1);mean(T1);mean(L3);mean(TM9);mean(C3);mean(Mi4)]
C2CanLabel={'L5','L1','Mi1','L2','L4','Tm1','T1','L3','TM9','C3','Mi4'}
bar(C2Can,'stacked')
set(gca, 'XTickLabel', C2CanLabel)
title('Postsynaptic to C2')
ylabel('# average synaptic counts (N=7cloumns)')
hold on 
errorbar([mean(sum(L5,2));mean(sum(L1,2));mean(sum(Mi1,2));mean(sum(L2,2));mean(sum(L4,2));mean(sum(Tm1,2));mean(sum(T1,2));mean(sum(L3,2));mean(sum(TM9,2));mean(sum(C3,2));mean(sum(Mi4,2))],...
    [std(sum(L5,2));std(sum(L1,2));std(sum(Mi1,2));std(sum(L2,2));std(sum(L4,2));std(sum(Tm1,2));std(sum(T1,2));std(sum(L3,2));std(sum(TM9,2));std(sum(C3,2));std(sum(Mi4,2))]/sqrt(7), 'ko')

legend('within column' , 'to other coulmns', 'ste of all connections across the 7 columns')


%% Outputs from C3: 

L2=[67,0;70,0;89,0;57,0;65,0;60,0;65,0]
L5=[22,0;18,0;15,1;15,0;10,0;9,0;13,0]
Mi1=[1,0;0,0;5,0;1,0;1,0;2,0;7,0]
T1=[180,1;175,0;190,0;125,0;144,0;161,0;155,0]
Mi9=[17,1;8,0;22,0;11,0;7,0;14,1;14,0]
Tm1=[30,0;23,0;21,0;21,0;18,0;19,0;15,0]
Tm4=[5,35;3,7;9,1;6,14;0,10;3,15;6,21]
Tm20=[17,0;11,0;6,0;8,0;7,0;4,0;6,0]
T4=[0,15;0,9;0,10;2,8;2,8;0,14;3,12]
Tm9=[4,0;8,0;2,0;2,0;1,0;3,0;1,0]
Mi4=[3,0;2,0;0,0;3,0;0,0;2,0;0,0]


figure
C3Can=[mean(T1);mean(L2);mean(Tm1);mean(Tm4);mean(L5);mean(Mi9);mean(T4);mean(Tm20);mean(Tm9);mean(Mi4); mean(Mi1)]
C3CanLabel={'T1','L2','Tm1','Tm4','L5','Mi9','T4','Tm20','Tm9','Mi4','Mi1'}
bar(C3Can,'stacked')
set(gca, 'XTickLabel', C3CanLabel)
title('Postsynaptic to C3')
ylabel('# average synaptic counts (N=7cloumns)')
hold on 
errorbar([mean(sum(T1,2));mean(sum(L2,2));mean(sum(Tm1,2));mean(sum(Tm4,2));mean(sum(L5,2));mean(sum(Mi9,2));mean(sum(T4,2));mean(sum(Tm20,2));mean(sum(TM9,2));mean(sum(Mi4,2));mean(sum(Mi1,2))],...
    [std(sum(T1,2));std(sum(L2,2));std(sum(Tm1,2));std(sum(Tm4,2));std(sum(L5,2));std(sum(Mi9,2));std(sum(T4,2));std(sum(Tm20,2));std(sum(TM9,2));std(sum(Mi4,2));std(sum(Mi1,2))]/sqrt(7), 'ko')

legend('within column' , 'to other coulmns', 'ste of all connections across the 7 columns')

%% Inputs to C2: 

L1=[57,0;56,0;60,0;54,0;56,0]
L5=[12,18;7,11;15,15;4,30;9,26]
Mi1=[1,10;12,7;7,12;7,3;7,10]


figure
C2Can=[mean(L1);mean(L5);mean(Mi1)]
C2CanLabel={'L1','L5','Mi1'}
bar(C2Can,'stacked')
set(gca, 'XTickLabel', C2CanLabel)
title('Presynaptic to C2')
ylabel('# average synaptic counts (N=7cloumns)')
hold on 
errorbar([mean(sum(L1,2));mean(sum(L5,2));mean(sum(Mi1,2))],...
    [std(sum(L1,2));std(sum(L5,2));std(sum(Mi1,2))]/sqrt(5), 'ko')

legend('within column' , 'to other coulmns', 'ste of all connections across the 7 columns')


%% Inputs to C3: 

L1=[105,0;96,0;97,0]
L5=[11,4;7,4;13,0]
Mi1=[16,0;10,0;12,0]
L3=[9,0;7,0;6,0]
Tm4=[2,9;2,3;0,12]



figure
C3Can=[mean(L1);mean(L5);mean(Mi1); mean(Tm4);mean(L3)]
C3CanLabel={'L1','L5','Mi1', 'Tm4','L3'}
bar(C3Can,'stacked')
set(gca, 'XTickLabel', C3CanLabel)
title('Presynaptic to C3')
ylabel('# average synaptic counts (N=7cloumns)')
hold on 
errorbar([mean(sum(L1,2));mean(sum(L5,2));mean(sum(Mi1,2));mean(sum(Tm4,2));mean(sum(L3,2))],...
    [std(sum(L1,2));std(sum(L5,2));std(sum(Mi1,2));std(sum(Tm4,2));std(sum(L3,2))]/sqrt(3), 'ko')

legend('within column' , 'to other coulmns', 'ste of all connections across the 7 columns')


