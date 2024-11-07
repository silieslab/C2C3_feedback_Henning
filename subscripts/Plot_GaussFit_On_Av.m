% Plot Gaussian Fit for the average STRFs 

function Plot_GaussFit_On_Av(Av_STRF,Norm,AllMinandMax)

% figure('Position', [500 400 1000 550]);
% subplot(2,4,1)
% 
% if Norm
%     RFi=(mean(Av_STRF.AllSTRFs_T4_L1,3))/max(max(mean(Av_STRF.AllSTRFs_T4_L1,3)));
% else
%     RFi=(mean(Av_STRF.AllSTRFs_T4_L1,3));
% end
%     
% [y,x]=find(RFi);
% z=[];
% for i=1:length(x)
%     z=[z,RFi(y(i),x(i))];
% end
% 
% xdata=[x,y]';
% ydata=z;
% 
% % Fit DoG with the function from Jonathan Leong
% [A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
%     R_best_fitPos, R_best_fitNeg, ...
%     tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
%     rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);
% 
% Z = Gaussian2_2D(A,xdata);
% Zreshaped=reshape(Z, [12 40]);
% 
% imagesc(Zreshaped)
%  newmap = darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
% %newmap =darkb2r(AllMinandMax.T4_L1(1),AllMinandMax.T4_L1(2));
% 
% colormap(gca, newmap);
% set(gca, 'xtick', [1 20 40])
% set(gca, 'xtickLabel', [-2 -1 0])
% text(5,12,['R2: ',num2str(rSquared)])
% 
% xlabel('time [s]')
% set(gca, 'ytick', [1 12])
% set(gca, 'ytickLabel', [{'Left'},{'Right'}])
% set(gca, 'FontSize', 12)
% title(['T4 Layer1 (N=', num2str(size(Av_STRF.AllSTRFs_T4_L1,3)),')'])
% 
% 
% 
% 
% 
% 
% % % 
% subplot(2,4,5)
% if Norm
%     RFi=(mean(Av_STRF.AllSTRFs_T5_L1,3))/max(max(mean(Av_STRF.AllSTRFs_T5_L1,3)));
% else
%     RFi=(mean(Av_STRF.AllSTRFs_T5_L1,3));
% end
% 
% 
% [y,x]=find(RFi);
% z=[];
% for i=1:length(x)
%     z=[z,RFi(y(i),x(i))];
% end
% 
% xdata=[x,y]';
% ydata=z;
% 
% % Fit DoG with the function from Jonathan Leong
% [A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
%     R_best_fitPos, R_best_fitNeg, ...
%     tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
%     rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);
% 
% Z = Gaussian2_2D(A,xdata);
% Zreshaped=reshape(Z, [12 40]);
% 
% imagesc(Zreshaped)
% newmap =darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
% %newmap =darkb2r(AllMinandMax.T5_L1(1),AllMinandMax.T5_L1(2));
% 
% colormap(gca, newmap);
% set(gca, 'xtick', [1 20 40])
% set(gca, 'xtickLabel', [-2 -1 0])
% text(5,12,['R2: ',num2str(rSquared)])
% 
% xlabel('time [s]')
% set(gca, 'ytick', [1 12])
% set(gca, 'ytickLabel', [{'Left'},{'Right'}])
% set(gca, 'FontSize', 12)
% title(['T5 Layer1 (N=', num2str(size(Av_STRF.AllSTRFs_T5_L1,3)),')'])
% 
% 
% 
% 
% 
% subplot(2,4,2)
% 
% if Norm
%     RFi=(mean(Av_STRF.AllSTRFs_T4_L2,3))/max(max(mean(Av_STRF.AllSTRFs_T4_L2,3)));
% else
%     RFi=(mean(Av_STRF.AllSTRFs_T4_L2,3));
% end
% 
% [y,x]=find(RFi);
% z=[];
% for i=1:length(x)
%     z=[z,RFi(y(i),x(i))];
% end
% 
% xdata=[x,y]';
% ydata=z;
% 
% % Fit DoG with the function from Jonathan Leong
% [A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
%     R_best_fitPos, R_best_fitNeg, ...
%     tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
%     rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);
% 
% Z = Gaussian2_2D(A,xdata);
% Zreshaped=reshape(Z, [12 40]);
% 
% imagesc(Zreshaped)
%  newmap = darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
% %newmap =darkb2r(AllMinandMax.T4_L2(1),AllMinandMax.T4_L2(2));
% 
% colormap(gca, newmap);
% set(gca, 'xtick', [1 20 40])
% set(gca, 'xtickLabel', [-2 -1 0])
% text(5,12,['R2: ',num2str(rSquared)])
% 
% xlabel('time [s]')
% set(gca, 'ytick', [1 12])
% set(gca, 'ytickLabel', [{'Left'},{'Right'}])
% set(gca, 'FontSize', 12)
% title(['T4 Layer2 (N=', num2str(size(Av_STRF.AllSTRFs_T4_L2,3)),')'])
% 
% 
% 
% 
% subplot(2,4,6)
% if Norm
%     RFi=(mean(Av_STRF.AllSTRFs_T5_L2,3))/max(max(mean(Av_STRF.AllSTRFs_T5_L2,3)));
% else
%     RFi=(mean(Av_STRF.AllSTRFs_T5_L2,3));
% end
% 
% 
% [y,x]=find(RFi);
% z=[];
% for i=1:length(x)
%     z=[z,RFi(y(i),x(i))];
% end
% 
% xdata=[x,y]';
% ydata=z;
% 
% % Fit DoG with the function from Jonathan Leong
% [A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
%     R_best_fitPos, R_best_fitNeg, ...
%     tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
%     rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);
% 
% Z = Gaussian2_2D(A,xdata);
% Zreshaped=reshape(Z, [12 40]);
% 
% imagesc(Zreshaped)
% newmap = darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
% %newmap =darkb2r(AllMinandMax.T5_L2(1),AllMinandMax.T5_L2(2));
% 
% colormap(gca, newmap);
% set(gca, 'xtick', [1 20 40])
% set(gca, 'xtickLabel', [-2 -1 0])
% text(5,12,['R2: ',num2str(rSquared)])
% 
% xlabel('time [s]')
% set(gca, 'ytick', [1 12])
% set(gca, 'ytickLabel', [{'Left'},{'Right'}])
% set(gca, 'FontSize', 12)
% title(['T5 Layer2 (N=', num2str(size(Av_STRF.AllSTRFs_T5_L2,3)),')'])
% 
%   
% 
% subplot(2,4,3)
% 
% 
% if Norm
%     RFi=(mean(Av_STRF.AllSTRFs_T4_L3,3))/max(max(mean(Av_STRF.AllSTRFs_T4_L3,3)));
% else
%     RFi=(mean(Av_STRF.AllSTRFs_T4_L3,3));
% end
% 
% [y,x]=find(RFi);
% z=[];
% for i=1:length(x)
%     z=[z,RFi(y(i),x(i))];
% end
% 
% xdata=[x,y]';
% ydata=z;
% 
% % Fit DoG with the function from Jonathan Leong
% [A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
%     R_best_fitPos, R_best_fitNeg, ...
%     tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
%     rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);
% 
% Z = Gaussian2_2D(A,xdata);
% Zreshaped=reshape(Z, [12 40]);
% 
% imagesc(Zreshaped)
% newmap = darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
% %newmap =darkb2r(AllMinandMax.T4_L3(1),AllMinandMax.T4_L3(2));
% 
% colormap(gca, newmap);
% set(gca, 'xtick', [1 20 40])
% set(gca, 'xtickLabel', [-2 -1 0])
% text(5,12,['R2: ',num2str(rSquared)])
% 
% xlabel('time [s]')
% set(gca, 'ytick', [1 12])
% set(gca, 'ytickLabel', [{'Up'},{'Down'}])
% set(gca, 'FontSize', 12)
% title(['T4 Layer3 (N=', num2str(size(Av_STRF.AllSTRFs_T4_L3,3)),')'])
% 
% 
% 
% subplot(2,4,7)
% 
% if Norm
%     RFi=(mean(Av_STRF.AllSTRFs_T5_L3,3))/max(max(mean(Av_STRF.AllSTRFs_T5_L3,3)));
% else
%     RFi=(mean(Av_STRF.AllSTRFs_T5_L3,3));
% end
% 
% [y,x]=find(RFi);
% z=[];
% for i=1:length(x)
%     z=[z,RFi(y(i),x(i))];
% end
% 
% xdata=[x,y]';
% ydata=z;
% 
% % Fit DoG with the function from Jonathan Leong
% [A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
%     R_best_fitPos, R_best_fitNeg, ...
%     tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
%     rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);
% 
% Z = Gaussian2_2D(A,xdata);
% Zreshaped=reshape(Z, [12 40]);
% 
% imagesc(Zreshaped)
% newmap = darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
% %newmap =darkb2r(AllMinandMax.T5_L3(1),AllMinandMax.T5_L3(2));
% 
% colormap(gca, newmap);
% set(gca, 'xtick', [1 20 40])
% set(gca, 'xtickLabel', [-2 -1 0])
% text(5,12,['R2: ',num2str(rSquared)])
% 
% xlabel('time [s]')
% set(gca, 'ytick', [1 12])
% set(gca, 'ytickLabel', [{'Up'},{'Down'}])
% set(gca, 'FontSize', 12)
% title(['T5 Layer3 (N=', num2str(size(Av_STRF.AllSTRFs_T5_L3,3)),')'])
% 
% 
% 
% subplot(2,4,4)
% 
% 
% if Norm
%     RFi=(mean(Av_STRF.AllSTRFs_T4_L4,3))/max(max(mean(Av_STRF.AllSTRFs_T4_L4,3)));
% else
%     RFi=(mean(Av_STRF.AllSTRFs_T4_L4,3));
% end
% 
% [y,x]=find(RFi);
% z=[];
% for i=1:length(x)
%     z=[z,RFi(y(i),x(i))];
% end
% 
% xdata=[x,y]';
% ydata=z;
% 
% % Fit DoG with the function from Jonathan Leong
% [A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
%     R_best_fitPos, R_best_fitNeg, ...
%     tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
%     rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);
% 
% Z = Gaussian2_2D(A,xdata);
% Zreshaped=reshape(Z, [12 40]);
% 
% imagesc(Zreshaped)
% newmap = darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
% %newmap =darkb2r(AllMinandMax.T4_L4(1),AllMinandMax.T4_L4(2));
% 
% colormap(gca, newmap);
% set(gca, 'xtick', [1 20 40])
% set(gca, 'xtickLabel', [-2 -1 0])
% text(5,12,['R2: ',num2str(rSquared)])
% 
% xlabel('time [s]')
% set(gca, 'ytick', [1 12])
% set(gca, 'ytickLabel', [{'Up'},{'Down'}])
% set(gca, 'FontSize', 12)
% title(['T4 Layer4 (N=', num2str(size(Av_STRF.AllSTRFs_T4_L4,3)),')'])
% 
% 
% subplot(2,4,8)
% 
% if Norm
%     RFi=(mean(Av_STRF.AllSTRFs_T5_L4,3))/max(max(mean(Av_STRF.AllSTRFs_T5_L4,3)));
% else
%     RFi=(mean(Av_STRF.AllSTRFs_T5_L4,3));
% end
% 
% [y,x]=find(RFi);
% z=[];
% for i=1:length(x)
%     z=[z,RFi(y(i),x(i))];
% end
% 
% xdata=[x,y]';
% ydata=z;
% 
% % Fit DoG with the function from Jonathan Leong
% [A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
%     R_best_fitPos, R_best_fitNeg, ...
%     tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
%     rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);
% 
% Z = Gaussian2_2D(A,xdata);
% Zreshaped=reshape(Z, [12 40]);
% 
% imagesc(Zreshaped)
% newmap = darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
% %newmap =darkb2r(AllMinandMax.T5_L4(1),AllMinandMax.T5_L4(2));
% 
% colormap(gca, newmap);
% set(gca, 'xtick', [1 20 40])
% set(gca, 'xtickLabel', [-2 -1 0])
% text(5,12,['R2: ',num2str(rSquared)])
% 
% xlabel('time [s]')
% set(gca, 'ytick', [1 12])
% set(gca, 'ytickLabel', [{'Up'},{'Down'}])
% set(gca, 'FontSize', 12)
% title(['T5 Layer4 (N=', num2str(size(Av_STRF.AllSTRFs_T5_L4,3)),')'])
% 


%% Average all LAyers

figure('Position', [500 400 230 390]);


subplot(2,1,1)

if Norm
    RFi=(mean(Av_STRF.AllSTRFs_T4_AllLayer,3))/max(max(mean(Av_STRF.AllSTRFs_T4_AllLayer,3)));
else
    RFi=(mean(Av_STRF.AllSTRFs_T4_AllLayer,3));
end

[y,x]=find(RFi);
z=[];
for i=1:length(x)
    z=[z,RFi(y(i),x(i))];
end

xdata=[x,y]';
ydata=z;

% Fit DoG with the function from Jonathan Leong
[A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
    R_best_fitPos, R_best_fitNeg, ...
    tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
    rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);

Z = Gaussian2_2D(A,xdata);
Zreshaped=reshape(Z, [12 40]);

imagesc(Zreshaped)
%newmap = darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
newmap =darkb2r(AllMinandMax.T4_AllLayer(1),AllMinandMax.T4_AllLayer(2));
colorbar
colormap(gca, newmap);
set(gca, 'xtick', [1 20 40])
set(gca, 'xtickLabel', [-2 -1 0])
text(5,12,['R2: ',num2str(rSquared)])

xlabel('time [s]')
set(gca, 'ytick', [1 12])
set(gca, 'ytickLabel', [{'Up'},{'Down'}])
set(gca, 'FontSize', 12)

title(['T4 AllLayer (N=', num2str(size(Av_STRF.AllSTRFs_T4_AllLayer,3)),')'])


subplot(2,1,2)

if Norm
    RFi=(mean(Av_STRF.AllSTRFs_T5_AllLayer,3))/max(max(mean(Av_STRF.AllSTRFs_T5_AllLayer,3)));
else
    RFi=(mean(Av_STRF.AllSTRFs_T5_AllLayer,3));
end

[y,x]=find(RFi);
z=[];
for i=1:length(x)
    z=[z,RFi(y(i),x(i))];
end

xdata=[x,y]';
ydata=z;

% Fit DoG with the function from Jonathan Leong
[A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
    R_best_fitPos, R_best_fitNeg, ...
    tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
    rSquared, resnorm, residual, exitflag, output ] =FitGaussian2_2D(xdata,ydata);

Z = Gaussian2_2D(A,xdata);
Zreshaped=reshape(Z, [12 40]);

imagesc(Zreshaped)
% newmap = darkb2r(min(min(Zreshaped)),max(max(Zreshaped)));
newmap =darkb2r(AllMinandMax.T5_AllLayer(1),AllMinandMax.T5_AllLayer(2));
colorbar
colormap(gca, newmap);
set(gca, 'xtick', [1 20 40])
set(gca, 'xtickLabel', [-2 -1 0])
text(5,12,['R2: ',num2str(rSquared)])

xlabel('time [s]')
set(gca, 'ytick', [1 12])
set(gca, 'ytickLabel', [{'Up'},{'Down'}])
set(gca, 'FontSize', 12)

title(['T5 AllLayer (N=', num2str(size(Av_STRF.AllSTRFs_T5_AllLayer,3)),')'])

