function fullscreen(image, device_number)
%FULLSCREEN Display fullscreen true colour images
%   FULLSCREEN(C,N) displays matlab image matrix with range [0,1] on display number N
%   (which ranges from 1 to number of screens). Image matrix C must be
%   the exact resolution of the output screen since no scaling in
%   implemented. If fullscreen is activated on the same display
%   as the MATLAB window, use ALT-TAB to switch back. The size of image can be more or less than the screen resolution,
%   it will be cropped automatically, or simply displayed from [0,0] (the
%   top left corner if it is smaller. The range will automatically be
%   clamped to [0,1].
%
%   If FULLSCREEN(C,N) is called the second time, the screen will update
%   with the new image.
%
%   Use CLOSESCREEN() to exit fullscreen.
%
%   Requires Matlab 7.x (uses Java Virtual Machine), and has been tested on
%   Linux and Windows platforms.
%
%   Written by Pithawat Vachiramon, modified my Mitchell A. Cox.
%
%   Update (27/2/17)
%   - Allow more than one fullscreen windows (per screen).
%
%   Update (23/3/09):
%   - Uses temporary bitmap file to speed up drawing process.
%   - Implemeted a fix by Alejandro Camara Iglesias to solve issue with
%     non-exclusive-fullscreen-capable screens.
%
%	Original: https://www.mathworks.com/matlabcentral/fileexchange/23404-fullscreen-1-1

global fullscreenData;

if (length(fullscreenData) >= device_number)
    frame_java = fullscreenData(device_number).frame_java;
    icon_java = fullscreenData(device_number).icon_java;
    device_number_java = fullscreenData(device_number).device_number_java;
else
    frame_java = {};
    icon_java = {};
    device_number_java = {};
end

if ~isequal(device_number_java, device_number)
    try frame_java.dispose(); end
    frame_java = [];
    device_number_java = device_number;
end

if ~isequal(class(frame_java), 'javax.swing.JFrame')
    ge = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment();
    gds = ge.getScreenDevices();
    height = gds(device_number).getDisplayMode().getHeight();
    width = gds(device_number).getDisplayMode().getWidth();
    
    if range(image) > 1
        warning(strcat('fullscreen image should be [0,1] but is [',num2str(min(min(image)),1),',', num2str(max(max(image))), '].'));
    end
    if ~isequal(size(image,1),height)
        warning(['Fullscreen image should have verticle resolution of ' num2str(height)]);
    elseif ~isequal(size(image,2),width)
        warning(['Fullscreen image should have horizontal resolution of ' num2str(width)]);
    end
    
    frame_java = javax.swing.JFrame(gds(device_number).getDefaultConfiguration());
    bounds = frame_java.getBounds();
    frame_java.setUndecorated(true);
    frame_java.setAlwaysOnTop(true); % MC: should stop minimizing on lost focus. See: http://stackoverflow.com/questions/32048428/keep-the-jframe-open-on-a-dual-monitor-configuration-in-java
    icon_java = javax.swing.ImageIcon(im2java(image));
    label = javax.swing.JLabel(icon_java);
    frame_java.getContentPane.add(label);
    %gds(device_number).setFullScreenWindow(frame_java); % MC: this is a problem
    frame_java.setSize(width, height);
    frame_java.setLocation( bounds.x, bounds.y );
else
    icon_java.setImage(im2java(image));
end
frame_java.pack
frame_java.repaint
frame_java.show

fullscreenData(device_number).frame_java = frame_java;
fullscreenData(device_number).icon_java = icon_java;
fullscreenData(device_number).device_number_java = device_number_java;

end