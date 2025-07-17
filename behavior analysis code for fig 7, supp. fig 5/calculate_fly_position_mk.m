function [ x, y, theta, delta_theta, fwd, lat ] = calculate_fly_position_mk( velocity)
%CALCULATE_FLY_POSITION calculate the position of the fly
%   Calculate the position of the fly in a virtual plain, this function
%   takes the velocity of the two mice, the radius of the ball the fly is
%   sitting on, the angle between the mice and the angle the mice are
%   oriented in respect to the ball. The angle theta is the angle when
%   viewn from above. l.s. added 07.2015

radius = 0.3; % for a ball with the radius of 3 mm
miceangle = pi/4; % the mice are probably in a 90 degree angle

theta = zeros(1,length(velocity));
deltatheta = zeros(1,length(velocity));
x(1) = 0;
y(1) = 0;
%for i = 2:length(velocity)
%if velocity(1,i) ~= 0 
%     disp();
%end
%end


for i = 2:length(velocity)
    %if 0 ~= velocity(1,i)
    % disp(velocity(1,i))
    %end
    
    delta_theta(i)= -(velocity(1,i)+ velocity(3,i))/(2*radius); %in radians
    fwd(i)= -(velocity(2,i)+ velocity(4,i))*cos(miceangle); %in cm
    lat(i)= -(velocity(2,i)- velocity(4,i))*sin(miceangle); %in cm
    theta(i) = theta(i-1) + delta_theta(i); %in radians
    delta_x = sin(theta(i))*cos(miceangle)*(velocity(2,i)+velocity(4,i)) + cos(theta(i))*sin(miceangle)*(velocity(4,i)-velocity(2,i));
    delta_y = -cos(theta(i))*cos(miceangle)*(velocity(2,i)+velocity(4,i)) + sin(theta(i))*sin(miceangle)*(velocity(4,i)-velocity(2,i));
    x(i) = x(i-1) + delta_x;
    y(i) = y(i-1) + delta_y;
end

end

