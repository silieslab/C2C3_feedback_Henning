function out = aggregate_fffall_means10Hz_BleedThruFix_v2(in)
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



rats=zeros(length(in),dur);
stims=rats;

mr=zeros(length(in),dur);
ms=zeros(length(in),dur);
name = cell(length(in),1);
for ii=1:length(in)
        s=in(ii).istim;
        xi=find(diff(s(1:end-dur))<0)+1; % trigger on going to dark... diff(s) is -1 then
        idSignal1 = in(ii).idSignal1;   % I (MH) changed this here again from iratio to idSignal1 (because we dont calculate a ratio any more)
        
        idSignal1 = idSignal1./mean(idSignal1)-1; %calculating dF/F with F being the mean of the whole trace 
        d_idSignal1 = idSignal1; %now longer subtracting polynomials
        
    for jj=1:length(xi)
        temp = d_idSignal1(xi(jj):xi(jj)+dur-1); 

        
%         % ****************************************************************
%         % Find the place during this time period where istim changes from 0
%         % to 1 specifically[0 1 1], at that frame replace the trace value
%         % using average of the previous and following frame -YEF 9/2015
%         % 
% 
%         stim_epoch = in(ii).istim(xi(jj):xi(jj)+dur-1);
%         
%         % loop over stim_epochs and find index where 0 1 1, ON epoch start
%         for i=1:(length(stim_epoch)-3)
%             if sum(stim_epoch(i:i+2) == [0 1 1]) == 3
%                 index_string = i;
%                 break;
%             end
%         end
%         ON_start_frame = index_string+1;
% 
%         % Replace frame at the transition from OFF to ON with average of previous and
%         % following frame
%         temp(ON_start_frame) = (temp(ON_start_frame - 1) + temp(ON_start_frame + 1))/2;
%         
%         % loop over stim_epochs and find index where 1 0 0, OFF epoch start
%         for i=1:length(stim_epoch-3)
%             if sum(stim_epoch(i:i+2) == [1 0 0]) == 3
%                 index_string2 = i;
%                 break;
%             end
%         end
% 
%         OFF_start_frame = index_string2+1;
%          % Replace frame at the transition from ON to OFF with average of previous and
%         % following frame
%         temp(OFF_start_frame) = (temp(OFF_start_frame - 1) + temp(OFF_start_frame + 1))/2;
%         % *****************************************************************
        
        mr(jj,:)=temp;
        
        temp=in(ii).istim(xi(jj):xi(jj)+dur-1);
%         temp=temp-min(temp); temp=temp/(max(temp));
        ms(jj,:)=temp;
    end
    rats(ii,:)=mean(mr(1:length(xi),:),1); %averaging over stimulus repititions
    stims(ii,:)=mean(ms(1:length(xi),:),1);
%     neuron(ii)=in(ii).cell;
%     flyID(ii)=in(ii).flyID;
    name{ii}=in(ii).name;
%     center{ii}=in(ii).center; %ms added
%     clear mr ms;
end
neuron = [in.cell];
flyID = [in.flyID];

out.rats=rats;
out.stims=stims;
out.neuron=neuron;
out.flyID=flyID;
out.name=name;
% out.center=center; %ms added



