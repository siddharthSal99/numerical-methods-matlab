clear;
clc;
fprintf('%10s %10s %10s %10s\n','x','adj_x','fact');
for x = 0:pi/8:10*pi
fact = floor(x ./ (0.5*pi));
j = x - fact*0.5*pi;
j = abs(j);
fprintf('%10e %10e %5d\n',x,j,fact);
end