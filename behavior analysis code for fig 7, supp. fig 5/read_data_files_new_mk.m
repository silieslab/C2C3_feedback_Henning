function out = read_data_files_new_mk(varargin)
oldFile=0;
%% reads in all the data files...

if length(varargin)
    if isempty(varargin{1})
        [dum,pathname]=uigetfile('*.txt','select a file in the folder to process...');
    else
        pathname = varargin{1};
    end;
end;
currdir = pwd;
%cd(pathname);

%posfile = [pathname , '_position_output.txt'];
%stimfile = [pathname, '_stimulus_output.txt'];
%inputfile = [pathname, '_flyarena.txt']
inputfile = pathname;

%disp(stimfile);

%[framenum, time, stimulus, stimx, stimy, stimtheta] = textread(stimfile,'%d %f %d %f %f %f');%ms: reading in the raw data
%[framenum, time, posx, posy, postheta] = textread(posfile,'%d %f %f %f %f','headerlines',3);

[firstvelx, firstvely, secondvelx, secondvely, firstposx, firstposy, secondposx,secondposy, elapsedtime, elapsedpatterntime, patternid, voltagex, voltagey, framex, framey, posfuncid] = textread(inputfile,'%d %d %d %d %d %d %d %d %f %f %d %d %d %d %d %d','headerlines',1);
if sum(posfuncid)==0
    oldFile=1;
end
    
% figure; 
% subplot(2,1,1)
% plot(elapsedtime,firstposx);
% subplot(2,1,2)
% plot(elapsedtime,secondposx);

%% extract time of the file creation
fileInfo = dir(inputfile);
timeStamp = fileInfo.date;
strings=regexp(timeStamp,'[\ \:]','split');
hour=str2num(strings{2});

%% calculate the position and velocity in cm. for this the dpi value of the mouse is needed
% for a dpi of 1600 use this line
% cmperdot = 2.54/1600;
% for a dpi of 1200 
% cmperdot = 2.54/1200;
cmperdot=1/160; %mk
%firstvelx(:) = 0;
vel = [ firstvelx'; firstvely'; secondvelx'; secondvely'];
pos = [ firstposx'; firstposy'; secondposx'; secondposy'];
velcm = cmperdot * vel;
poscm = cmperdot * pos;
%disp(size(velcm));


%% calculate the positions in the virtual plain of the fly, x ,y angle theta
%disp(velcm);
[x, y, theta, deltatheta, fwd, lat] = calculate_fly_position_mk(velcm); % this function takes the velocity, the radius of the ball  the angle between the mice, and the rotation of the two mice 
%disp(theta);
%%
%fpos = fopen(posfile);
%paramfilename = deblank(fgets(fpos));
%tmp=find((paramfilename == '\') + (paramfilename == '/')); tmp = max(tmp);
%paramfilenamelocal = deblank(paramfilename(tmp+1:end));
%worldfilename = deblank(fgets(fpos));
%timedate = deblank(fgets(fpos));
%fclose(fpos);

%stimuli = readparametersfile(paramfilenamelocal);

%cd(currdir);

%% compute fwd and lateral velocity from pos data (mm/s)

time = elapsedtime / 1000; % the input is in milliseconds, so just divide by 1000 to get it in seconds
patterntime = elapsedpatterntime / 1000; % same here

% vx=[0 diff(posx(:)')]*120;
% vy=[0 diff(posy(:)')]*120;

vx=[diff(x(:)')]./[diff(time')];
vy=[diff(y(:)')]./[diff(time')];
speed = (vx.^2 + vy.^2).^0.5;
disp(size(diff(vx)));
theta2 = theta(2:length(theta));
disp(size(diff(cos(theta2))));
%mk: do not calculate fwd and lat this way
% % fwd = cos(theta2).*vx + sin(theta2).*vy;   % dot product with heading of length 1
%lat = sqrt(speed.^2 - fwd.^2); % the remainder of the speed, but not direction?
% % lat = -sin(theta2).*vx + cos(theta2).*vy;  % this should give direction, too.
%format long;
%disp(diff(time'));


cd(currdir)
%% put all relevant parts in file structure...
%out.posfile = posfile;
%out.stimfile = stimfile;
%out.paramfilename = paramfilename;
%out.timedate = timedate;
%out.worldfilename = worldfilename;
%out.stimulusparams = stimuli;
out.inputfile = inputfile;

%out.data.framenum=1:length(firstvelx); % just take the length of a random entry in the file

out.data.time = time;
out.data.oldfile = oldFile;
out.data.stimulus = patternid; % this is the pattern id 
if oldFile==0
    out.data.posfunc = posfuncid; % this is the posfunc id 
end
out.data.stimx = framex;
out.data.stimy = framey;
out.data.deltatheta = deltatheta';
out.data.posx=x';
out.data.posy=y';
out.data.postheta = theta';
out.data.posspeed = speed';
out.data.posspeedx = vx';
out.data.posspeedy = vy';
out.data.posfwd = fwd';
out.data.poslat = lat';
out.data.creationTime=hour;

end

