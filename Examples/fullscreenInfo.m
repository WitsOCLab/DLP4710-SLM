function [devices, resolutions] = fullscreenInfo()
%FULLSCREENINFO Returns info on available screen devices and corresponding
%resolutions.

ge = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment();
gds = ge.getScreenDevices();

devices = 1:length(gds);

resolutions = zeros(1,2,length(gds));

for index = devices
    resolutions(1,1,index) = gds(index).getDisplayMode().getHeight();
    resolutions(1,2,index) = gds(index).getDisplayMode().getWidth();
end

end

