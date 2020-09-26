function closescreen(device_number)
%CLOSESCREEN Dispose FULLSCREEN() window
% Original Source: https://www.mathworks.com/matlabcentral/fileexchange/23404-fullscreen-1-1
global fullscreenData
frame_java = fullscreenData(device_number).frame_java;
try frame_java.dispose(); 
end