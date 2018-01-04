function [Q] = diameterplot
%Usage: function Q = diameterplot
%Q = flow rates as a function of diameter in discrete values from 1 to 36"
dRange = 1:36; % range of pipe diameters
d2m = dRange .* 0.0254; % find the diameters in meters because SI is awesome and pipeflow is with respect to SI units
pipevec = zeros(size(d2m)); %preallocate memory fo the output vector
for j = dRange
    %calculate the average velocity for each value in dRange using the
    %pipefow functionlaod
    pipevec(j) = pipeflow(j * 0.0254);
end
Q = 264.172.* pi.* ((d2m./2).^2).* (pipevec*60);%calculate the flow rate using the equation Q = VA for each value in pipevec.
%this is in gal/min
figure
%plot the flowrate vs pipe diameter. Use this to find the pipe diameter for
%10K gal/min
plot(dRange,Q);
ylabel('Flow Rate');
xlabel('Pipe Diameter');
title('Flow Rate vs. Pipe Diameter');
%% Code for finding the diameter needed to supply 10K gal/min
% indup = find(Q < 10000);
% inddown = find(Q > 10000);
% diam1 = dRange(indup(end));
% Q(indup(end));
% Q(inddown(1));
% diam2 = dRange(inddown(1));
end