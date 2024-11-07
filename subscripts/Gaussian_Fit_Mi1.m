function FWHM=Gaussian_Fit_Mi1(SpEx_El_Max) 
%This function fits gaussians to the maximum spatial receptive field 

FWHM_El=[];
% for i=1:length(SpEx_Az_Max)
%  
%     % DATA       
%     fm = SpEx_Az_Max(:,i)';    
%     xm = [1:12]*5;  %xm = xm';   
% 
%     % FIT GAUSSIAN
%     f = fit(xm.',fm.','gauss1');
% %     figure; plot(f,xm,fm)
% %     hold on 
% %     plot(xm,fm)
% 
%     % CALC FWHM = full width half maximum = sigma(c1) * 2.3548; 
%     FWHM_Az=[FWHM_Az, f.c1*2.3548]; 
%    
% end 

for i=1:length(SpEx_El_Max)
 
    % DATA       
    fm = SpEx_El_Max(:,i)';    
    xm = [1:12]*5;  %xm = xm';   

    % FIT GAUSSIAN
    f = fit(xm.',fm.','gauss1');
%     figure; plot(f,xm,fm)
%     hold on 
%     plot(xm,fm)

    % CALC FWHM = full width half maximum = sigma(c1) * 2.3548; 
    FWHM_El=[FWHM_El, f.c1*2.3548]; 
   
end 

% PLOT 
% Put Data together
FWHM=nan(1,50); 
FWHM(1,1:length(FWHM_El))=FWHM_El; 

% figure; 
% bar(nanmean(FWHM,2))
% set(gca,'XTickLabel', {'Az','El'})
% hold on ; errorbar([1,2],[nanmean(FWHM,2)],[nanstd(FWHM')]./sqrt([size(FWHM,2),size(FWHM,2)]), 'o')
% ylabel('FWHM')
% set(gca, 'FontSize', 12) 


figure; 
boxplot(FWHM', 'notch', 'on' )
set(gca,'XTickLabel', {'Az','El'})
ylabel('FWHM')
set(gca, 'FontSize', 12) 


end 
