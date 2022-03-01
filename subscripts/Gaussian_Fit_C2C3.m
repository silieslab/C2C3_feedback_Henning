function FWHM=Gaussian_Fit_C2C3(SpEx_Az_Max,SpEx_El_Max); 
%This function fits gaussians to the maximum spatial receptive field 
FWHM_Az=[];
FWHM_El=[];
for i=1:length(SpEx_Az_Max)
 
    % DATA       
    fm = SpEx_Az_Max(:,i)';    
    xm = [1:12]*5;  %xm = xm';   

    % FIT GAUSSIAN
    f = fit(xm.',fm.','gauss1');
%     figure; plot(f,xm,fm)
%     hold on 
%     plot(xm,fm)

    % CALC FWHM = full width half maximum = sigma(c1) * 2.3548; 
    FWHM_Az=[FWHM_Az, f.c1*2.3548]; 
   
end 

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
FWHM=nan(2,50); 
FWHM(1,1:length(FWHM_Az))=FWHM_Az; 
FWHM(2,1:length(FWHM_El))=FWHM_El; 





end 
