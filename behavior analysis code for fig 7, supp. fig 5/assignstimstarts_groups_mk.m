function [stimstartsbytype,stimsignsbytype] = assignstimstarts_groups_mk(stimulusOut,posfuncOut,patterns,...
                                               posfuncs,maxt,pat_id,patNames,fps_id,funcNames)
%% assigns all the stim starts, etc., and the sign to multiply if multiple exist with same value, different signs...
% this function groups the data according to pattern name as well as position function name

funcStr1='position_function_ramp_';
funcStr2='.mat';
% stimstarts = find(diff(stimulus)>0);
stimstarts = find(abs(diff(stimulusOut))>0); %% allows 0 to be used as stim -- should work with previous stuff
if (length(stimulusOut) - stimstarts(end) < maxt)   %% 3 seconds to care about it...
    stimstarts = stimstarts(1:end-1);
end
%ms: this is just to check, if the last epoch is too short (which it almost
%certainly is), easier would just be: stimstarts = stimstarts(1:end-1);
stimID = stimulusOut(stimstarts+1);  %% ID for each one -- 1 to ??
[stimallIDS, ~, stimindices] = unique(stimID);
funcID = posfuncOut(stimstarts+1);  %% ID for each one -- 1 to ??
[funcallIDS, ~, funcindices] = unique(funcID);

stimstartsbytype=cell(length(patterns),1);
stimsignsbytype=cell(length(patterns),1);
for i=1:length(patterns) 
    stimstartsbytype{i}=[];
    stimsignsbytype{i}=[];
    for j=1:length(patterns{i}) %ms: groups{i} can have several elements, if we pool epochs!!
        patId=unique(pat_id(strcmp(patterns{i}(j),[patNames{:}])));
        funcId=unique(fps_id(strcmp([funcStr1,posfuncs{i}{j},funcStr2],[funcNames{:}])));
        qPat=find(stimallIDS == abs(patId)); % changed this up, so that it doesn't assume stimallIDS starts at 1; can include 0 -- CORRECT NOW
        choose4pat=find(stimindices == qPat);
        qfunc=find(funcallIDS == funcId); % mk: same done for posfunc
        choose4func=find(funcindices == qfunc);
        choose=intersect(choose4pat,choose4func);
        stimstartsbytype{i} = [stimstartsbytype{i},stimstarts(choose(:))'+1]; %% first index (== frame number) of each stimulus
        %mk: specifying signs from the pattern name (l/r)
        if regexp(patterns{i}{j},'_l_')
            sign=-1;
        else
            sign=1;
        end
        
        if patId~=0
            stimsignsbytype{i} = [stimsignsbytype{i},sign*ones(1,length(choose))];
        else
            stimsignsbytype{i} = [stimsignsbytype{i},ones(1,length(choose))]; % case of 0 -- 110222
        end
    end
end

end