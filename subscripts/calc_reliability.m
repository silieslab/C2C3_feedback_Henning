

function Rel=calc_reliability(avSignal1_CA, fstimval)



% This function calculates the correlation of the response across the two
% repitions of Stimulus for each ROI 

% This indicates how stable the recording was across time 
changes=diff(fstimval);

start_epoch=find(changes>0)+1;
end_epoch=find(changes<0);
        
dur=diff([start_epoch(1:length(end_epoch)),end_epoch]');
avdur=min(dur);
ep_all=nan(size(end_epoch,1), avdur); 
for pp=1:length(end_epoch)
    epoch=start_epoch(pp):start_epoch(pp)+avdur-1;
    ep_all(pp,:)=epoch;
end        


if size(ep_all,1)>1 % if two repetitions of the stimulus where recorded 
      
    for i=1:size(avSignal1_CA,1)    
        Rel(i)=corr(avSignal1_CA(i,ep_all(1,:))',avSignal1_CA(i,ep_all(2,:))');   
    end 
else
    Rel=[]; 
    print('Stimulus was not repeated twice')
end 



end 
