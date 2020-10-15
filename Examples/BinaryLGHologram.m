% Generates and displayes a Laguerre-Gauss beam with a binary grating for
% use on a DMD.
% Written by: Mitchell A. Cox, CC-BY-SA-4.0 License
% Reference: https://github.com/WitsOCLab/DLP4710-SLM

% Parameters:
pixelSize = 5.4e-6; %m
sizeXY = [1024 1024]; % [1920 1080] for DMD
dmdScreenNumber = 1;

LGell = 1;
LGp = 1;
w0 = 1e-3; %m

gratingAngle = 45;
gratingPeriod = 100e-6; %m

% -------------------------------------------------------------------------

% Create a meshgrid to work off:
x = pixelSize .* (-sizeXY(1)/2:(sizeXY(1)/2-1)); 
y = pixelSize .* (-sizeXY(2)/2:(sizeXY(2)/2-1)); 
[X,Y] = meshgrid(x,y);
[phi, r] = cart2pol(X,Y);

% Generate an LG beam: ----------------------------------------------------
RhoSquareOverWSquare = r.^2 ./ w0.^2; %optimisation since we always use the squares

% We don't use the built in MATLAB laguerreL as it is super slow
% Factorials replaced by n! = gamma(n+1) for speed

La = Laguerre(LGp, abs(LGell), 2*RhoSquareOverWSquare);
Clg = sqrt((2*gamma(LGp+1)) ./ (pi * gamma(abs(LGell)+LGp+1)));
E = Clg .* (sqrt(2)*sqrt(RhoSquareOverWSquare)).^abs(LGell) .* exp(-RhoSquareOverWSquare) .* La .* exp(-1i*LGell*phi);

%imagesc(angle(E)); % Check the phase
%imagesc(abs(E).^2); % Check the intensity

% Add a grating: ----------------------------------------------------------
theta = pi/180 .* gratingAngle;
plane = sin(theta) .* X + cos(theta) .* Y;

phase = angle(E);
w = asin(abs(E)/max(max(abs(E))));
binaryGrating = 0.5 + 0.5*sign(cos((2*pi)*plane/gratingPeriod + phase) - cos(w)); 

% Display: ----------------------------------------------------------------

imagesc(binaryGrating);
set(gca,'dataAspectRatio',[1 1 1]);

% Display on the DMD
%fullscreen(binaryGrating, dmdScreenNumber);
