function z = Gaussian2_2D( A, xdata )

% Difference of Gaussian functions
% A: parameters of the Gaussian function
%       A(1) = a_1, 
%       A(2) = muX_1, A(3) = muY_1
%       A(4) = sigmaX_1, A(5) = sigmaY_1
%       A(6) = theta_1
%       A(7) = a_2, 
%       A(8) = muX_2, A(9) = muY_2
%       A(10) = sigmaX_2, A(11) = sigmaY_2
%       A(12) = theta_2
%       A(13) = b
%       z = a_1 * exp( -(p_1(x-muX_1)^2 + 2q_1(x-muX_1)(y-muY_1) + r_1(y-muY_1)^2)) - a_2 * exp( -(p_2(x-muX_2)^2 + 2q_2(x-muX_2)(y-muY_2) + r_2(y-muY_2)^2)) + b
% xdata: a vector which contains x values

z = Gaussian1_2D( [A(1 : 6) 0], xdata ) - ...
    Gaussian1_2D( [A(7 : 12) 0], xdata ) + ...
    A(13);
