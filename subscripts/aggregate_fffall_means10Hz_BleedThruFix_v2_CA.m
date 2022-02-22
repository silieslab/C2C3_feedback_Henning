function out = aggregate_fffall_means10Hz_BleedThruFix_v2_CA(in)
% modified aggregate_fff_means10Hz_5s_G6
% no data correction (removed bad indices, mot_counts, replace by
% median), no more subtracting the polynomial, changed stimulus to start on
% first value of epoch and not last of old epoch.
% marion, 08/13/2015
%
% Yvette: use istim to figure out where the stim changes and replace that
% frame with an average between the previous and the following....
%

dxi_all = zeros(length(in),1);
%determine the epoch length
for ii=1:length(in)
        s=in(ii).istim;
        xi=find(diff(s(1:end))<0)+1; % trigger on going to dark...
        dxi = mean(diff(xi));
        dxi_all(ii,:)=dxi;
end
epochlength = round(mean(dxi_all));
dur = epochlength*1.3; %no longer *1.3



rats_T4=zeros(length(in),dur);
rats_T5=zeros(length(in),dur);

stims=rats_T4;

name = cell(length(in),1);
for ii=1:length(in)
        s=in(ii).istim;
        xi=find(diff(s(1:end-dur))<0)+1; % trigger on going to dark... diff(s) is -1 then
        mr_T4=nan(length(xi),dur);
        mr_T5=nan(length(xi),dur);

        ms=zeros(length(in),dur);
        
        iavSignal1_T4 = in(ii).idFSignal1_T4;   % I (MH) changed this here again from iratio to idSignal1 (because we dont calculate a ratio any more)
        iavSignal1_T5 = in(ii).idFSignal1_T5;   % I (MH) changed this here again from iratio to idSignal1 (because we dont calculate a ratio any more)
%     
        iavSignal1_T4_L1 = in(ii).idFSignal1_T4_L1;   
        iavSignal1_T5_L1 = in(ii).idFSignal1_T5_L1;  
        iavSignal1_T4_L2 = in(ii).idFSignal1_T4_L2;   
        iavSignal1_T5_L2 = in(ii).idFSignal1_T5_L2;  
        iavSignal1_T4_L3 = in(ii).idFSignal1_T4_L3;   
        iavSignal1_T5_L3 = in(ii).idFSignal1_T5_L3;  
        iavSignal1_T4_L4 = in(ii).idFSignal1_T4_L4;   
        iavSignal1_T5_L4 = in(ii).idFSignal1_T5_L4;  
% 




%         iavSignal1_T4 = iavSignal1_T4./mean(iavSignal1_T4)-1; %calculating dF/F with F being the mean of the whole trace 
%         iavSignal1_T5 = iavSignal1_T5./mean(iavSignal1_T5)-1; %calculating dF/F with F being the mean of the whole trace 

        
    for jj=1:length(xi)
        temp_T4 = iavSignal1_T4(xi(jj):xi(jj)+dur-1); 
        temp_T5 = iavSignal1_T5(xi(jj):xi(jj)+dur-1); 
        
        temp_T4_L1 = iavSignal1_T4_L1(xi(jj):xi(jj)+dur-1); 
        temp_T5_L1 = iavSignal1_T5_L1(xi(jj):xi(jj)+dur-1); 
        temp_T4_L2 = iavSignal1_T4_L2(xi(jj):xi(jj)+dur-1); 
        temp_T5_L2 = iavSignal1_T5_L2(xi(jj):xi(jj)+dur-1); 
        temp_T4_L3 = iavSignal1_T4_L3(xi(jj):xi(jj)+dur-1); 
        temp_T5_L3 = iavSignal1_T5_L3(xi(jj):xi(jj)+dur-1); 
        temp_T4_L4 = iavSignal1_T4_L4(xi(jj):xi(jj)+dur-1); 
        temp_T5_L4 = iavSignal1_T5_L4(xi(jj):xi(jj)+dur-1); 
        
                
        mr_T4(jj,:)=temp_T4;
        mr_T5(jj,:)=temp_T5;
        
        mr_T4_L1(jj,:)=temp_T4_L1;
        mr_T5_L1(jj,:)=temp_T5_L1;
        mr_T4_L2(jj,:)=temp_T4_L2;
        mr_T5_L2(jj,:)=temp_T5_L2;
        mr_T4_L3(jj,:)=temp_T4_L3;
        mr_T5_L3(jj,:)=temp_T5_L3;
        mr_T4_L4(jj,:)=temp_T4_L4;
        mr_T5_L4(jj,:)=temp_T5_L4;
        
        
        temp=in(ii).istim(xi(jj):xi(jj)+dur-1);
%         temp=temp-min(temp); temp=temp/(max(temp));
        ms(jj,:)=temp;
    end
%     figure; subplot(2,1,1); plot(mr_T4'); subplot(2,1,2); plot(mr_T5'); title(in(ii).name); 
    rats_T4(ii,:)=mean(mr_T4(1:length(xi),:),1); %averaging over stimulus repititions
    rats_T5(ii,:)=mean(mr_T5(1:length(xi),:),1); %averaging over stimulus repititions

    rats_T4_L1(ii,:)=mean(mr_T4_L1(1:length(xi),:),1); 
    rats_T5_L1(ii,:)=mean(mr_T5_L1(1:length(xi),:),1); 
    rats_T4_L2(ii,:)=mean(mr_T4_L2(1:length(xi),:),1); 
    rats_T5_L2(ii,:)=mean(mr_T5_L2(1:length(xi),:),1); 
    rats_T4_L3(ii,:)=mean(mr_T4_L3(1:length(xi),:),1); 
    rats_T5_L3(ii,:)=mean(mr_T5_L3(1:length(xi),:),1); 
    rats_T4_L4(ii,:)=mean(mr_T4_L4(1:length(xi),:),1); 
    rats_T5_L4(ii,:)=mean(mr_T5_L4(1:length(xi),:),1); 


    
    
    stims(ii,:)=mean(ms(1:length(xi),:),1);
%     neuron(ii)=in(ii).cell;
%     flyID(ii)=in(ii).flyID;
    name{ii}=in(ii).name;
%     center{ii}=in(ii).center; %ms added
%     clear mr ms;
end
% neuron = [in.cell];
flyID = [in.flyID];

out.rats_T4=rats_T4;
out.rats_T5=rats_T5;

out.rats_T4_L1=rats_T4_L1;
out.rats_T5_L1=rats_T5_L1;
out.rats_T4_L2=rats_T4_L2;
out.rats_T5_L2=rats_T5_L2;
out.rats_T4_L3=rats_T4_L3;
out.rats_T5_L3=rats_T5_L3;
out.rats_T4_L4=rats_T4_L4;
out.rats_T5_L4=rats_T5_L4;

out.stims=stims;
% out.neuron=neuron;
out.flyID=flyID;
out.name=name;
% out.center=center; %ms added



