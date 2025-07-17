function [ind,inderr]=plot_pdata_traces(in,genotype,varargin)

% goes through all flies and compiles data into useful sets...
N=length(in);
M=length(in(1).pdata.acc_dtheta);

if length(varargin)
    if iscell(varargin{1})
        xq=varargin{1};
        xpts=[1:M];
    else
        xq=[];
        xpts=varargin{1};
    end
else
    xq=[];
    xpts=[1:M];
end
if length(varargin)>1
    tlims=varargin{2};
else
    tlims=[0.83,1.08];
end


for i=1:M
    acc_dtheta{i}=[];
    acc_stim{i}=[];
    acc_dfwd{i}=[];
end
for gnum=1:M
    for fnum=1:N
        
        q=size(in(fnum).pdata.acc_dtheta{gnum},1);
        
        acc_dtheta{gnum}=[acc_dtheta{gnum};in(fnum).pdata.acc_dtheta{gnum}];
        
        acc_stim{gnum}=[acc_stim{gnum};in(fnum).pdata.acc_stim{gnum}];
        acc_nums(fnum,gnum)=q;
        
        acc_dfwd{gnum}=[acc_dfwd{gnum};in(fnum).pdata.acc_dfwd{gnum}];
    end
    
    
    rectdv{gnum}=acc_dtheta{gnum};
end

figure;
cm=[0 0 0; 0.15 0.15 0.15; 0.30 0.30 0.30; 0.45 0.45 0.45; 0.60 0.60 0.60; 0.75 0.75 0.75; 0.9 0.9 0.9];
close;
t=[1:size(in(1).pdata.acc_dtheta{1},2)]/120;


%% conditioned mean rot
figure;

for gnum=1:M
    subplot(3,1,1);
    plot(t,acc_stim{1}(1,:));
    set(gca,'xlim',[min(t),max(t)]);
    hold on
    %plot(0.7:0.3:2.2,[3 3 3 3 3 3],'r')
    plot(0.7:0.15:1.45,[3 3 3 3 3 3],'r')
%     plot(0.7:0.05:0.95,[3 3 3 3 3 3],'r')
    ylabel('stimulus');
    title(['rotation for all instances']);
    hold off
    
    subplot(3,1,[2 3]); hold on;
    if 1
        h=plot_err_patch(t,mean(rectdv{gnum},1),...
            std(rectdv{gnum},[],1)/sqrt(size(rectdv{gnum},1)),...
            cm(gnum,:),cm(gnum,:)+0.1);
    else
        h=plot(t,mean(rectdv{gnum},1),'color',cm(gnum,:));
    end
    plot(t,zeros(size(t)),'-k');
    legtext{gnum}=['group ' num2str(gnum) '; instances = ' num2str(size(rectdv{gnum},1))];
    leghand(gnum)=h;
    set(gca,'xlim',[min(t),max(t)]);
    xlabel('time (s)');
    ylabel('mean rotation (rads/s)');
    [sigstrength(gnum),ind]=max(mean(rectdv{gnum},1));
    sigerr(gnum)=std(rectdv{gnum}(:,ind),[],1)/sqrt(size(rectdv{gnum},1));
    ylim([-1.2 2.0]);
end
legend(leghand,legtext);

figure;
chooseinds=find((t>tlims(1)).*(t<tlims(2)));
for gnum=1:M
    subplot(3,1,1);
    plot(t,acc_stim{1}(1,:));
    set(gca,'xlim',[min(t),max(t)]);
    hold on
    %plot(0.7:0.3:2.2,[3 3 3 3 3 3],'r')
    plot(0.7:0.15:1.45,[3 3 3 3 3 3],'r')
%     plot(0.7:0.05:0.95,[3 3 3 3 3 3],'r')
    ylabel('stimulus');
    title(['rotation, mean of each fly']);
  
    subplot(3,1,[2 3]); hold on;
    for fnum=1:N
        h=plot(t,mean(in(fnum).pdata.acc_dtheta{gnum},1),'color',cm(gnum,:));
        mrot(gnum,fnum,:)=mean(in(fnum).pdata.acc_dtheta{gnum},1);
%         mrotind(gnum,fnum)=-sum(mrot(gnum,fnum,chooseinds))*180/pi/120; % no idea why this was (-). Mybe because they didn't change sign during preprocessing.
        mrotind(gnum,fnum)=sum(mrot(gnum,fnum,chooseinds))*180/pi/120;%mk
    end
    plot(t,zeros(size(t)),'-k');
    legtext{gnum}=['group ' num2str(gnum)];
    leghand(gnum)=h;
    set(gca,'xlim',[min(t),max(t)]);
    xlabel('time (s)');
    ylabel('mean rotation (rads/s)');
    ylim([-1 2.0]);
end
if length(xq)
    legend(leghand,xq);
else
    legend(leghand,legtext);
end

figure;
for gnum=1:M
    subplot(3,1,1);
    plot(t,acc_stim{1}(1,:));
    set(gca,'xlim',[min(t),max(t)]);
    hold on
%     plot(0.7:0.3:2.2,[3 3 3 3 3 3],'r')
    plot(0.7:0.15:1.45,[3 3 3 3 3 3],'r')
%     plot(0.7:0.05:0.95,[3 3 3 3 3 3],'r')
    ylabel('stimulus');
    title(['rotation by fly']);
    
    subplot(3,1,[2 3]); hold on;
    h=plot_err_patch(t,mean(squeeze(mrot(gnum,:,:)),1),...
            std(squeeze(mrot(gnum,:,:)),[],1)/sqrt(N),...
            cm(gnum,:),cm(gnum,:)+0.1);
    plot(t,zeros(size(t)),'-k');
    legtext{gnum}=['group ' num2str(gnum)];
    leghand(gnum)=h;
    set(gca,'xlim',[min(t),max(t)]);
    xlabel('time (s)');
    ylabel('mean rotation (rads/s)');
    ylim([-1.2 2.5]);
end
if length(xq)
    legend(leghand(1:M),xq(1:M));
else
    legend(leghand,legtext);
end

if length(varargin)
    if iscell(varargin{1})
        xq=varargin{1};
        xpts=[1:M];
    else
        xq=[];
        xpts=varargin{1};
    end
else
    xq=[];
    xpts=[1:M];
end
%% mk: same figure as above, without stimulus subplot and with stimulus grey patch
figure;
hold on;
boxHeightplus=max(max(mean(mrot,2)))+0.3;
boxHeightminus=min(min(mean(mrot,2)))-0.2;
stimBox1=patch([0.7,0.7,1.2,1.2],[boxHeightminus,boxHeightplus,boxHeightplus,boxHeightminus],'k','FaceAlpha',.2,'EdgeColor','none');
stimBox2=patch([1.2,1.2,1.7,1.7],[boxHeightminus,boxHeightplus,boxHeightplus,boxHeightminus],'k','FaceAlpha',.35,'EdgeColor','none');
for gnum=1:M
    h=plot_err_patch(t,mean(squeeze(mrot(gnum,:,:)),1),...
            std(squeeze(mrot(gnum,:,:)),[],1)/sqrt(N),...
            cm(gnum,:),cm(gnum,:)+0.1);
    plot(t,zeros(size(t)),'-k');
    legtext{gnum}=['group ' num2str(gnum)];
    leghand(gnum)=h;
end
set(gca,'xlim',[min(t),max(t)]);
xlabel('time (s)','FontSize',14,'FontWeight','bold');
ylabel('mean rotation (rads/s)');
ylim([min(min(mean(mrot,2)))-0.2 max(max(mean(mrot,2)))+0.3]);
set(gca,'FontSize',14)
set(gca,'FontWeight','bold')
title(sprintf(['Rotation by fly, ',genotype,', N=',num2str(N)]));

if length(xq)
    legend(leghand(1:M),xq(1:M));
else
    legend(leghand,legtext);
end

if length(varargin)
    if iscell(varargin{1})
        xq=varargin{1};
        xpts=[1:M];
    else
        xq=[];
        xpts=varargin{1};
    end
else
    xq=[];
    xpts=[1:M];
end