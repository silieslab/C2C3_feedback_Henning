function [A, aPos, muXPos, muYPos, sigmaXPos, sigmaYPos, thetaPos, aNeg, muXNeg, muYNeg, sigmaXNeg, sigmaYNeg, thetaNeg, b, ...
    R_best_fitPos, R_best_fitNeg, ...
    tuning_widthXPos, tuning_widthYPos, tuning_widthXNeg, tuning_widthYNeg, ...
    rSquared, resnorm, residual, exitflag, output ] = ...
    FitGaussian2_2D( xdata, ydata, doInterp, method )

% modeled after Kenichi Ohki's fitting functions. this one does a double 2D
% Gaussian (difference of Gaussians)

if nargin < 3
    doInterp = 0;
end
if nargin < 4
    method = 'linear';
end

xDataX = xdata(1, :);
xDataY = xdata(2, :);
xStepX = max( diff( sort( xDataX ) ) );
xStepY = max( diff( sort( xDataY ) ) );

[maxResp, argMax] = max( ydata ); % assumes that conditions are stored along the last dimension
[minResp, argMin] = min( ydata ); % assumes that conditiosn are stored along the last dimension

% first guess
A0(1) = (maxResp - minResp) / 2;
A0(2) = xdata( 1, argMax ); % muXPos
A0(3) = xdata( 2, argMax ); % muYPos
A0(4) = xStepX; % prevent a divide-by-zero when evaluating Gaussian
A0(5) = xStepY; % prevent a divide-by-zero when evaluating Gaussian
A0(6) = 0;

A0(7) = (maxResp - minResp) / 2;
A0(8) = xdata( 1, argMin ); % muXNeg
A0(9) = xdata( 2, argMin ); % muYNeg
A0(10) = xStepX; % prevent a divide-by-zero when evaluating Gaussian
A0(11) = xStepY; % prevent a divide-by-zero when evaluating Gaussian
A0(12) = 0;

A0(13) = (maxResp + minResp) / 2;

lowerBound = [0 ...
    A0(2) - 2 * abs( xStepX ) ...
    A0(3) - 2 * abs( xStepY ) ...
    0 ...
    0 ...
    -inf ...
    0 ...
    A0(8) - 2 * abs( xStepX ) ...
    A0(9) - 2 * abs( xStepY ) ...
    0 ...
    0 ...
    -inf ...
    minResp - (maxResp - minResp)];
upperBound = [2 * A0(1) ...
    A0(2) + 2 * abs( xStepX ) ...
    A0(3) + 2 * abs( xStepY ) ...
    range( xDataX ) ... % 20 / (2 * ((2 * log( 2 )) ^ 0.5)) ... % "x" of x-t plot in units of degrees
    range( xDataY ) ... % 100 / (2 * ((2 * log( 2 )) ^ 0.5)) ... % "t" of x-t plot in units of ms
    inf ...
    2 * A0(7) ...
    A0(8) + 2 * abs( xStepX ) ...
    A0(9) + 2 * abs( xStepY ) ...
    range( xDataX ) ... % 20 / (2 * ((2 * log( 2 )) ^ 0.5)) ... % "x" of x-t plot in units of degrees
    range( xDataY ) ... % 100 / (2 * ((2 * log( 2 )) ^ 0.5)) ... % "t" of x-t plot in units of ms
    inf ...
    maxResp + (maxResp - minResp)];
upperBound(upperBound == lowerBound) = lowerBound(upperBound == lowerBound) + 1; % ensures that lowerBounds and upperBounds are not equal

options = optimset( 'Display', 'off' );

if doInterp
    % interpolate data to approximately double stimulus conditions
    [xDataXi, xDataYi] = meshgrid( [min( xDataX ) : xStepX / 2 : max( xDataX )], ...
        [min( xDataY ) : xStepY / 2 : max( xDataY )] );
    xDataXi = reshape( xDataXi, [1 size( [min( xDataX ) : xStepX / 2 : max( xDataX )], 2 ) * size( [min( xDataY ) : xStepY / 2 : max( xDataY )], 2 )] );
    xDataYi = reshape( xDataYi, [1 size( [min( xDataX ) : xStepX / 2 : max( xDataX )], 2 ) * size( [min( xDataY ) : xStepY / 2 : max( xDataY )], 2 )] );
    xdatai = [xDataXi; xDataYi];
    ydatai = interp2( xdata(1, :), xdata(2, :), ydata, xdatai(1, :), xdatai(2, :), method );

    xdata = xdatai;
    ydata = ydatai;
end

[A,resnorm,residual,exitflag,output] = lsqcurvefit( @Gaussian2_2D, A0, xdata, ydata, lowerBound, upperBound, options );

aPos = A(1);
muXPos = A(2);
muYPos = A(3);
sigmaXPos = A(4);
sigmaYPos = A(5);
thetaPos = A(6);
aNeg = A(7);
muXNeg = A(8);
muYNeg = A(9);
sigmaXNeg = A(10);
sigmaYNeg = A(11);
thetaNeg = A(12);
b = A(13);

R_best_fitPos = Gaussian2_2D( A, [muXPos ; muYPos] );
R_best_fitNeg = Gaussian2_2D( A, [muXNeg ; muYNeg] );

tuning_widthXPos = 2 * ((2 * log( 2 )) ^ 0.5) * sigmaXPos; % full width at half maximum
tuning_widthYPos = 2 * ((2 * log( 2 )) ^ 0.5) * sigmaYPos; % full width at half maximum

tuning_widthXNeg = 2 * ((2 * log( 2 )) ^ 0.5) * sigmaXNeg; % full width at half maximum
tuning_widthYNeg = 2 * ((2 * log( 2 )) ^ 0.5) * sigmaYNeg; % full width at half maximum

rSquared = 1 - resnorm / sum( (ydata - mean( ydata )) .^ 2 );

end
