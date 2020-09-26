function  waitStart()
%WAITSTART Call at the beginning of code synced with waitPeriod.

global lastTime

tic;
lastTime = toc;

end

