function out = accumulatebyindex(timeseries,indices, signs,before, after);

%% error check
% if (indices(1) <= before)
%     indices=indices(2:end);
% end
% if (length(timeseries) - indices(end) < after)
%     indices = indices(1:end - 1);
% end
% 
choose=find((indices > before) & (indices < length(timeseries) - after));
indices=indices(choose);
%ms: this gets rid of basically nothing, just checks if there is enough space
%for before (e.g. 0.2s = 24 in indices) and after (e.g. 2.1 = 254 in
%indices) for a given index, which could only cut off the first (?) or the
%last


%% do algorithm
for i=1:length(indices)
    out(i,:)=timeseries(indices(i)-before:indices(i)+after) * signs(i);
end

% ms: this takes a given index = start of an epoch, and adds "before" to it
% before the epoch start (often 0.2s) and "after" after the epoch start.
% Thus, the length of pdata only depends on the timing variable set (often
% timing = [0.2 2.1], means the full trace will be 2.3 s, with the epoch
% start at 0.2