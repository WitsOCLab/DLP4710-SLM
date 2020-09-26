function waitUntil(periodSeconds)
%WAITUNTIL Call waitStart() before this to start the timer. waitUntil(seconds) then pauses execution
% until the specified period has elapsed since the last call.

global lastTime

while toc < (lastTime+periodSeconds) 
end

lastTime = toc;

end

