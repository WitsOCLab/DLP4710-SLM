% Pregenerates some frames to be displayed fullscreen and then times how
% long it takes to display these frames a number of times.
% 
% For 1080x1920 resolution my Ryzen 5 3600 with RTX 580 manages about 85
% FPS.

%% Adjust accordingly:
screenNumber = 1; 

%% Work the magic
[s,res] = fullscreenInfo();
imageSize = res(:,:,screenNumber); 

count = 60*3;
numFrames = 10;
frames = rand(imageSize(1), imageSize(2), numFrames); %frame range should be [0,1]

tic;
%waitStart(); %Uncomment to sync to specific period.
for index = 1:count
    %waitUntil(1/60); %Uncomment to sync to specific period.
    fullscreen(frames(:,:,mod(index,numFrames)+1), screenNumber);
end
t = toc;

closescreen(screenNumber);

fprintf('fullscreen works at %g frames per second!\n', count/t);