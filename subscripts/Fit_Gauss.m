%% This script fits Two multivariate Gaussians on individual STRFs


function [GausfitInfo,DATAi_wFit]=Fit_Gauss(RF_DATA,NCon, P,Predicition_thres2,Rel_thres,AllMinandMax_abs,AllMinandMax_absFit)
% Input:
%RF_Data=   structure with STRFs, Condition that you want to fit!
%NCon=      Condition that you want to use
%P=         Logical for plotting


GausfitInfo.RsqT4=[];
GausfitInfo.RsqT5=[];

GausfitInfo.SpOFFT4=[];
GausfitInfo.SpOFFT5=[];

GausfitInfo.tempOFFT4=[];
GausfitInfo.tempOFFT5=[];

GausfitInfo.timetoPeakT4=[];
GausfitInfo.timetoPeakT5=[];

GausfitInfo.Peak_amplitudeT4=[];
GausfitInfo.Peak_amplitudeT5=[];

GausfitInfo.HalfwidthMaxT4_X=[];
GausfitInfo.HalfwidthMaxT5_X=[];

GausfitInfo.HalfwidthMaxT4_Y=[];
GausfitInfo.HalfwidthMaxT5_Y=[];

GausfitInfo.SigmaX_T4=[];
GausfitInfo.SigmaX_T5=[];

GausfitInfo.SigmaY_T4=[];
GausfitInfo.SigmaY_T5=[];

GausfitInfo.theta_T4=[];
GausfitInfo.theta_T5=[];

GausfitInfo.LayerID_T4=[];
GausfitInfo.LayerID_T5=[];


DATAi= RF_DATA{1,NCon};



for iFly=1:length(DATAi.DATA)
    
    if isfield(DATAi.DATA{1,iFly},'Az')
        
        AllRF=DATAi.DATA{1,iFly}.Az.STRFs;
        CellT=DATAi.DATA{1,iFly}.Az.T4T5;
        LayerT=DATAi.DATA{1,iFly}.Az.Layer;
        
        FitRsq=nan(1,size(AllRF,1)); %for storage of data
        ALLRF_fits=nan(size(AllRF,1),12,40);
        
        for NRF=1:size(AllRF,1)
            Corrcoef=DATAi.DATA{1,iFly}.Az.corrcoefs(1,NRF);
            RELi=DATAi.DATA{1,iFly}.Az.REL(NRF);
            
            if Corrcoef>=Predicition_thres2 && RELi>=Rel_thres
                
                
                RFi=(reshape(AllRF(NRF,:,:),[40,12]));
                RFi=RFi';
                RFi=flipud(RFi);
                
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
                
                % Save fitting information
                
                if CellT(NRF)==4
                    
                    GausfitInfo.RsqT4=[GausfitInfo.RsqT4,rSquared];
                    GausfitInfo.SpOFFT4=[GausfitInfo.SpOFFT4,(muYNeg-muYPos)*5];
                    GausfitInfo.timetoPeakT4=[GausfitInfo.timetoPeakT4,[muXPos/20-2; muXNeg/20-2 ]];
                    GausfitInfo.Peak_amplitudeT4=[GausfitInfo.Peak_amplitudeT4,[ aPos; aNeg ]];
                    GausfitInfo.HalfwidthMaxT4_X=[GausfitInfo.HalfwidthMaxT4_X,[ tuning_widthXPos;  tuning_widthXNeg ]];
                    GausfitInfo.HalfwidthMaxT4_Y=[GausfitInfo.HalfwidthMaxT4_Y,[ tuning_widthYPos;  tuning_widthYNeg ]];
                    GausfitInfo.SigmaX_T4=[GausfitInfo.SigmaX_T4,[sigmaXPos; sigmaXNeg]];
                    GausfitInfo.SigmaY_T4=[GausfitInfo.SigmaY_T4,[sigmaYPos; sigmaYNeg]];
                    GausfitInfo.theta_T4=[GausfitInfo.theta_T4,[thetaPos; thetaNeg]];
                    GausfitInfo.LayerID_T4=[GausfitInfo.LayerID_T4,LayerT(NRF)];
                    
                    
                elseif CellT(NRF)==5
                    
                    GausfitInfo.RsqT5=[GausfitInfo.RsqT5,rSquared];
                    GausfitInfo.SpOFFT5=[GausfitInfo.SpOFFT5,(muYNeg-muYPos)*5];
                    GausfitInfo.timetoPeakT5=[GausfitInfo.timetoPeakT5,[muXPos/20-2; muXNeg/20-2 ]]; %divided by framerate to get s
                    GausfitInfo.Peak_amplitudeT5=[GausfitInfo.Peak_amplitudeT5,[ aPos;  aNeg ]];
                    GausfitInfo.HalfwidthMaxT5_X=[GausfitInfo.HalfwidthMaxT5_X,[ tuning_widthXPos;  tuning_widthXNeg ]];
                    GausfitInfo.HalfwidthMaxT5_Y=[GausfitInfo.HalfwidthMaxT5_Y,[ tuning_widthYPos;  tuning_widthYNeg ]];
                    GausfitInfo.SigmaX_T5=[GausfitInfo.SigmaX_T5,[sigmaXPos; sigmaXNeg]];
                    GausfitInfo.SigmaY_T5=[GausfitInfo.SigmaY_T5,[sigmaYPos; sigmaYNeg]];
                    GausfitInfo.theta_T5=[GausfitInfo.theta_T5,[thetaPos; thetaNeg]];
                    GausfitInfo.LayerID_T5=[GausfitInfo.LayerID_T5,LayerT(NRF)];
                    
                end
                
                % Plot the original STRF with the Fitted Gaussian
                
                Z = Gaussian2_2D(A,xdata);
                Zreshaped=reshape(Z, [12 40]);
                
                if P
                    F1=figure
                     set(F1,'Position',[600 600 800 300])

                    subplot(1,2,1)
                    imagesc(RFi)
%                     newmap = b2r(min(min(RFi)),max(max(RFi)));
                    newmap = darkb2r(eval(['AllMinandMax_abs.T', num2str(CellT(NRF)),'_L',num2str(LayerT(NRF)),'(1)']),eval(['AllMinandMax_abs.T', num2str(CellT(NRF)),'_L',num2str(LayerT(NRF)),'(2)']));


                    colormap(gca, newmap)
                    title(['T',num2str(CellT(NRF)), '- Layer', num2str(LayerT(NRF))])
                    set(gca, 'xtick', [1 20 40])
                    set(gca, 'xtickLabel', [-2 -1 0])
                    
                    
                    subplot(1,2,2)
                    imagesc(Zreshaped)
%                     newmap = b2r(min(min(Zreshaped)),max(max(Zreshaped)));
                    newmap = darkb2r(eval(['AllMinandMax_absFit.T', num2str(CellT(NRF)),'_L',num2str(LayerT(NRF)),'(1)']),eval(['AllMinandMax_absFit.T', num2str(CellT(NRF)),'_L',num2str(LayerT(NRF)),'(2)']));

                    colormap(gca, newmap);
                    set(gca, 'xtick', [1 20 40])
                    set(gca, 'xtickLabel', [-2 -1 0])
                    text(5,12,['R2: ',num2str(rSquared)])
                    colorbar
                    
                     saveas(F1, ['/Users/Miri/Desktop/STRF_Fits/Con',num2str(NCon),'-T',num2str(CellT(NRF)), '- Layer', num2str(LayerT(NRF)),'Fly',num2str(iFly),'Cell',num2str(NRF), '.pdf'])
                    
                end
                
                
                
                
                FitRsq(NRF)=rSquared;
                ALLRF_fits(NRF,:,:)=Zreshaped;
                
            end %if Corrcoef
            
        end %NRF
        
        DATAi.DATA{1,iFly}.Az.GausfitInfo.FitRsq=FitRsq;
        DATAi.DATA{1,iFly}.Az.GausfitInfo.ALLRF_fits=ALLRF_fits;
        
        
    end %field AZ
     %% 
    if isfield(DATAi.DATA{1,iFly},'El')
        
        AllRF=DATAi.DATA{1,iFly}.El.STRFs;
        CellT=DATAi.DATA{1,iFly}.El.T4T5;
        LayerT=DATAi.DATA{1,iFly}.El.Layer;
        
        FitRsq=nan(1,size(AllRF,1)); %for storage of data
        ALLRF_fits=nan(size(AllRF,1),12,40);
        
        for NRF=1:size(AllRF,1)
            Corrcoef=DATAi.DATA{1,iFly}.El.corrcoefs(1,NRF);
            RELi=DATAi.DATA{1,iFly}.El.REL(NRF);
            
            if Corrcoef>=Predicition_thres2 && RELi>=Rel_thres
                
                RFi=(reshape(AllRF(NRF,:,:),[40,12]));
                RFi=RFi';
                
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
                
                % Save fitting information
                
                
                if CellT(NRF)==4
                    
                    GausfitInfo.RsqT4=[GausfitInfo.RsqT4,rSquared];
                    GausfitInfo.SpOFFT4=[GausfitInfo.SpOFFT4,(muYNeg-muYPos)*5];
                    GausfitInfo.timetoPeakT4=[GausfitInfo.timetoPeakT4,[muXPos/20-2; muXNeg/20-2 ]];
                    %                    GausfitInfo.Peak_amplitudeT4=[GausfitInfo.Peak_amplitudeT4,[ R_best_fitPos;  R_best_fitNeg ]];
                    GausfitInfo.Peak_amplitudeT4=[GausfitInfo.Peak_amplitudeT4,[ aPos;  aNeg ]];
                    
                    GausfitInfo.HalfwidthMaxT4_X=[GausfitInfo.HalfwidthMaxT4_X,[ tuning_widthXPos;  tuning_widthXNeg ]];
                    GausfitInfo.HalfwidthMaxT4_Y=[GausfitInfo.HalfwidthMaxT4_Y,[ tuning_widthYPos;  tuning_widthYNeg ]];
                    GausfitInfo.SigmaX_T4=[GausfitInfo.SigmaX_T4,[sigmaXPos; sigmaXNeg]];
                    GausfitInfo.SigmaY_T4=[GausfitInfo.SigmaY_T4,[sigmaYPos; sigmaYNeg]];
                    GausfitInfo.theta_T4=[GausfitInfo.theta_T4,[thetaPos; thetaNeg]];
                    GausfitInfo.LayerID_T4=[GausfitInfo.LayerID_T4,LayerT(NRF)];
                    
                    
                elseif CellT(NRF)==5
                    
                    GausfitInfo.RsqT5=[GausfitInfo.RsqT5,rSquared];
                    GausfitInfo.SpOFFT5=[GausfitInfo.SpOFFT5,(muYNeg-muYPos)*5];
                    GausfitInfo.timetoPeakT5=[GausfitInfo.timetoPeakT5,[muXPos/20-2; muXNeg/20-2 ]];
                    GausfitInfo.Peak_amplitudeT5=[GausfitInfo.Peak_amplitudeT5,[  aPos;  aNeg  ]];
                    GausfitInfo.HalfwidthMaxT5_X=[GausfitInfo.HalfwidthMaxT5_X,[ tuning_widthXPos;  tuning_widthXNeg ]];
                    GausfitInfo.HalfwidthMaxT5_Y=[GausfitInfo.HalfwidthMaxT5_Y,[ tuning_widthYPos;  tuning_widthYNeg ]];
                    GausfitInfo.SigmaX_T5=[GausfitInfo.SigmaX_T5,[sigmaXPos; sigmaXNeg]];
                    GausfitInfo.SigmaY_T5=[GausfitInfo.SigmaY_T5,[sigmaYPos; sigmaYNeg]];
                    GausfitInfo.theta_T5=[GausfitInfo.theta_T5,[thetaPos; thetaNeg]];
                    GausfitInfo.LayerID_T5=[GausfitInfo.LayerID_T5,LayerT(NRF)];
                    
                end
                
                
                %                 tempONsetT4=[];
                %                 tempONsetT5=[];
                
                % Plot the original STRF with the Fitted Gaussian
                Z = Gaussian2_2D(A,xdata);
                Zreshaped=reshape(Z, [12 40]);
                if P
                    F2=figure
                    set(F2,'Position',[600 600 800 300])

                    subplot(1,2,1)
                    imagesc(RFi)
%                     newmap = b2r(min(min(RFi)),max(max(RFi)));
                    newmap = darkb2r(eval(['AllMinandMax_abs.T', num2str(CellT(NRF)),'_L',num2str(LayerT(NRF)),'(1)']),eval(['AllMinandMax_abs.T', num2str(CellT(NRF)),'_L',num2str(LayerT(NRF)),'(2)']));

                    colormap(gca, newmap)
                    title(['T',num2str(CellT(NRF)), '- Layer', num2str(LayerT(NRF))])
                    set(gca, 'xtick', [1 20 40])
                    set(gca, 'xtickLabel', [-2 -1 0])
                    
                    
                    subplot(1,2,2)
                    imagesc(Zreshaped)
%                     newmap = b2r(min(min(Zreshaped)),max(max(Zreshaped)));
                    newmap = darkb2r(eval(['AllMinandMax_absFit.T', num2str(CellT(NRF)),'_L',num2str(LayerT(NRF)),'(1)']),eval(['AllMinandMax_absFit.T', num2str(CellT(NRF)),'_L',num2str(LayerT(NRF)),'(2)']));

                    colormap(gca, newmap);
                    set(gca, 'xtick', [1 20 40])
                    set(gca, 'xtickLabel', [-2 -1 0])
                    text(5,12,['R2: ',num2str(rSquared)])
                    colorbar
                    saveas(F2, ['/Users/Miri/Desktop/STRF_Fits/Con',num2str(NCon),'-T',num2str(CellT(NRF)), '- Layer', num2str(LayerT(NRF)),'Fly',num2str(iFly),'Cell',num2str(NRF), '.pdf'])
                    
                end
                
                
                FitRsq(NRF)=rSquared;
                ALLRF_fits(NRF,:,:)=Zreshaped;
                
                %                  a = A(1);
                %                 muX = A(2);
                %                 muY = A(3);
                %                 sigmaX = A(4);
                %                 sigmaY = A(5);
                %                 theta = A(6);
                %                 b = A(13);
                %
                %                 theta = theta * pi / 180;
                %
                %                 p =  (cos( theta ) ^ 2) / ( 2 * sigmaX ^ 2 ) + (sin( theta ) ^ 2) / ( 2 * sigmaY ^ 2 );
                %                 q = -(sin( 2 * theta )) / ( 4 * sigmaX ^ 2 ) + (sin( 2 * theta )) / ( 4 * sigmaY ^ 2 );
                %                 r =  (sin( theta ) ^ 2) / ( 2 * sigmaX ^ 2 ) + (cos( theta ) ^ 2) / ( 2 * sigmaY ^ 2 );
                %
                %                 % Gauss1=eval(a * exp( -(p * ((x - muX) .^ 2) + 2 * q * (x - muX) .* (y - muY) + r * ((y - muY) .^ 2)) ) + b);
                %
                %
                %                 Gauss1 =@(x,y) (a * exp( -(p * ((x - muX) .^ 2) + 2 * q * (x - muX) .* (y - muY) + r * ((y - muY) .^ 2)) )+b);
                %
                %                 subplot(1,3,3)
                %                 fcontour(Gauss1)%,[g.XLim g.YLim])
                %
                %                 set(gca, 'XLim', [0 50]);
                %                 set(gca, 'YLim', [0 12]);
                %                 %
                %                 a2 = A(7);
                %                 muX2 = A(8);
                %                 muY2 = A(9);
                %                 sigmaX2 = A(10);
                %                 sigmaY2 = A(11);
                %                 theta2 = A(12);
                %
                %
                %
                %                 p2 =  (cos( theta2 ) ^ 2) / ( 2 * sigmaX2 ^ 2 ) + (sin( theta2 ) ^ 2) / ( 2 * sigmaY2 ^ 2 );
                %                 q2 = -(sin( 2 * theta2 )) / ( 4 * sigmaX2 ^ 2 ) + (sin( 2 * theta2 )) / ( 4 * sigmaY2 ^ 2 );
                %                 r2 =  (sin( theta2 ) ^ 2) / ( 2 * sigmaX2 ^ 2 ) + (cos( theta2 ) ^ 2) / ( 2 * sigmaY2 ^ 2 );
                %
                %                 Gauss2 =@(x,y) (a2 * exp( -(p2 * ((x - muX2) .^ 2) + 2 * q2 * (x - muX2) .* (y - muY2) + r2 * ((y - muY2) .^ 2)) ) + b);
                %                 hold on
                %                 fcontour(Gauss2)
                
                
%                 
%                                 if  CellT(NRF)==5 && LayerT(NRF)==1
%                                     AllSTRFs_T5_L1=cat(3,AllSTRFs_T5_L1,RFi_shift);
%                 
%                                 elseif CellT(NRF)==5 && LayerT(NRF)==2
%                                     AllSTRFs_T5_L2=cat(3,AllSTRFs_T5_L2,RFi_shift);
%                 
%                                 elseif CellT(NRF)==4 && LayerT(NRF)==1
%                                     AllSTRFs_T4_L1=cat(3,AllSTRFs_T4_L1,RFi_shift);
%                 
%                                 elseif CellT(NRF)==4 && LayerT(NRF)==2
%                                     AllSTRFs_T4_L2=cat(3,AllSTRFs_T4_L2,RFi_shift);
%                                 end
                %
                
            end
        end
        DATAi.DATA{1,iFly}.El.GausfitInfo.FitRsq=FitRsq;
        DATAi.DATA{1,iFly}.El.GausfitInfo.ALLRF_fits=ALLRF_fits;
    end
    
end

DATAi_wFit=DATAi;


