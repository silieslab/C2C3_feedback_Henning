
%Inputs to C2 / C3
addpath(genpath('Connectivity'))
addpath(genpath('subscripts'))

NeuronType='C3'
Direction='output'
[N,presynaptic_ID,counts,postsynaptic_ID,partner_ID,name,top_nt,super_class,cell_class]...
    =textread([NeuronType,'_neurons_',Direction,'_count_annotated.txt'],...
    '%f %f %f %f %f %s %s %s %s\r',...
    'headerlines',1,'delimiter','\t');%MS: %s reads a white space or delimiter separated string, %f a floating-point value


% Filter by more than 3 synapses
FilterIDs=counts>3;
counts=counts(FilterIDs);
postsynaptic_ID=postsynaptic_ID(FilterIDs);
name=name(FilterIDs);

cellnames=unique(name);

NCIDs=unique(postsynaptic_ID);
Outputs=nan(length(NCIDs),length(cellnames));

for NCells=1:length(NCIDs)
    
    Namei=NCIDs(NCells);
    
    Ind=find(postsynaptic_ID==Namei); %Indices of reappearance of the same neuron ID (C2 or C3)
    SynapseCounts=counts(Ind);
    
    Pre_CellIDi=name(Ind);% Will contain the names of all neurons postsynaptic to Neuron with the current ID 'Namei'  
    Pre_CellID_unique=unique(Pre_CellIDi);
    
    %CellIDicount=nan(length(Pre_CellID_unique),1);
    for Cellt=1:length(cellnames)       
       IND_Cellrep=strcmp(cellnames(Cellt),Pre_CellIDi);
       
       Outputs(NCells,Cellt)=sum(SynapseCounts(IND_Cellrep));
    end 
  
end



[~,x]=sort(nanmean(Outputs,1));

x_rev=x([length(x):-1:1]);
Outputs_sorted=Outputs(:,x_rev);
% I_rev=I([length(x):-1:1]);
PostsynTypes_sorted=cellnames(x_rev);
 
Occurance=Outputs_sorted>0;
Occurance_M=mean(Occurance,1);

Ind_select=find(Occurance_M>0.7);
PostsynTypes_sorted_AB05=PostsynTypes_sorted(Ind_select);

% 
% figure; boxplot(Outputs_sorted,'Labels',PostsynTypes_sorted)
% set(gca, 'XTickLabelRotation',45)


figure('Position',[200 200 600 800]); 
subplot(2,1,1)
% boxplot(Outputs_sorted(:,Ind_select),'Labels',PostsynTypes_sorted_AB05)

violinplot(Outputs_sorted(:,Ind_select),PostsynTypes_sorted_AB05)

set(gca, 'XTickLabelRotation',45)
ylabel('Synaptic count')
if strcmp(Direction,'output') 
    xlabel('Postsynaptic neuron')
elseif strcmp(Direction,'input') 
    xlabel('Presynaptic neuron')
end 

title([NeuronType,', N=',num2str(size(NCIDs,1)),', Absolute count per neuron type (syn>3, occurance > 70% of all ',NeuronType,')'])


%Relative Counts

RelativeOutputs=Outputs_sorted./sum(Outputs_sorted,2);
subplot(2,1,2)
%boxplot(RelativeOutputs(:,Ind_select),'Labels',PostsynTypes_sorted_AB05)
violinplot(RelativeOutputs(:,Ind_select),PostsynTypes_sorted_AB05)

set(gca, 'XTickLabelRotation',45)
ylabel('Synaptic count (%)')
if strcmp(Direction,'output') 
    xlabel('Postsynaptic neuron')
elseif strcmp(Direction,'input') 
    xlabel('Presynaptic neuron')
end
title([NeuronType,', N=',num2str(size(NCIDs,1)),', Relative count per neuron type (syn>3, occurance > 70% of all ',NeuronType,')'])

%%
