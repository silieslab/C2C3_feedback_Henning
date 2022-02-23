function z = Gaussian1_2D(A, xdata)

% Gaussian function
% A: parameters of the Gaussian function
%       A(1) = a, 
%       A(2) = muX, A(3) = muY
%       A(4) = sigmaX, A(5) = sigmaY
%       A(6) = theta
%       A(7) = b
%       z = a * exp( -(p(x-muX)^2 + 2q(x-muX)(y-muY) + r(y-muY)^2)) + b
% xdata: a vector which contains x values

a = A(1);
muX = A(2);
muY = A(3);
sigmaX = A(4);
sigmaY = A(5);
theta = A(6);
b = A(7);

x = xdata( 1, : );
y = xdata( 2, : );

theta = theta * pi / 180;

p =  (cos( theta ) ^ 2) / ( 2 * sigmaX ^ 2 ) + (sin( theta ) ^ 2) / ( 2 * sigmaY ^ 2 );
q = -(sin( 2 * theta )) / ( 4 * sigmaX ^ 2 ) + (sin( 2 * theta )) / ( 4 * sigmaY ^ 2 );
r =  (sin( theta ) ^ 2) / ( 2 * sigmaX ^ 2 ) + (cos( theta ) ^ 2) / ( 2 * sigmaY ^ 2 );

z = a * exp( -(p * ((x - muX) .^ 2) + 2 * q * (x - muX) .* (y - muY) + r * ((y - muY) .^ 2)) ) + b;
