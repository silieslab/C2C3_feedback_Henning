function out=process_stimuli_mk(data,timing,patterns,posfuncs,dirPath,metaFlies)

BEFORE = round(120*timing(1));
AFTER = round(120*timing(2));

%% Extracting response features per fly per stimulus

in=data;
if isfield(in,'pdata')
    in=rmfield(in,'pdata');
end
out=in;

for fnum = 1:length(data)
    in=data(fnum);
    load([dirPath, metaFlies(fnum).name]);
    [stimstartsbytype,stimsignsbytype]=assignstimstarts_groups_mk(in.data.stimulus,in.data.posfunc,patterns,posfuncs,AFTER,pat_id,patNames,fps_id,funcNames);

    out(fnum).pdata.stimstartsbytype=stimstartsbytype;
    out(fnum).pdata.stimsignsbytype=stimsignsbytype;

    for i=1:length(patterns)
        out(fnum).pdata.acc_dtheta{i}=accumulatebyindex([0 diff(in.data.postheta(:)')]*120,stimstartsbytype{i},stimsignsbytype{i},BEFORE,AFTER); % could mean subtract here?
        out(fnum).pdata.acc_dfwd{i}=accumulatebyindex(in.data.posfwd*120,stimstartsbytype{i},abs(stimsignsbytype{i}),BEFORE,AFTER);
        out(fnum).pdata.acc_dlat{i}=accumulatebyindex(in.data.poslat*120,stimstartsbytype{i},stimsignsbytype{i},BEFORE,AFTER);
        out(fnum).pdata.acc_stim{i} =accumulatebyindex(in.data.stimulus,stimstartsbytype{i},stimsignsbytype{i},BEFORE,AFTER);
        out(fnum).pdata.acc_posspeed{i} = abs(accumulatebyindex(in.data.posspeed,stimstartsbytype{i},stimsignsbytype{i},BEFORE,AFTER));%ms, walking
        out(fnum).pdata.acc_posspeedy{i} = abs(accumulatebyindex(in.data.posspeedy,stimstartsbytype{i},stimsignsbytype{i},BEFORE,AFTER));%mk, fwd walking
        out(fnum).pdata.acc_posspeedx{i} = abs(accumulatebyindex(in.data.posspeedx,stimstartsbytype{i},stimsignsbytype{i},BEFORE,AFTER));%mk, lat walking
        out(fnum).pdata.acc_posturn{i}=abs(accumulatebyindex([0 diff(in.data.postheta(:)')]*120,stimstartsbytype{i},stimsignsbytype{i},BEFORE,AFTER)); %ms, turning
    end

    %ms:  calculate mean translational speed for prestimulus interval
    for i = 1:length(patterns)
        temp = mean(mean(out(fnum).pdata.acc_dfwd{i}(:,24))); %averages over all instances and over the first 24 time points (full pre-stim interval)
%         disp(temp);
        transSpeed(i)=temp;
    end
    transSpeed = mean(transSpeed); %averages over groups


    disp(['FLY ' num2str(fnum) ' ROTmean = ' num2str(mean([0 diff(in.data.postheta(:)')]*120)) ' ROTsd = ' num2str(std([0 diff(in.data.postheta(:)')]*120)) ...
        '; SPEEDmean = ' num2str(mean(in.data.posspeed(:))) ' SPEEDsd = ' num2str(std(in.data.posspeed)) ' transSPEED =' num2str(transSpeed)]);    
end
end





