function [V] = pipeflow(D)
%Usage: function V = pipeflow(D). 
%V = average velocity of the pipe flow
%D = pipe diameter
%This function returns the average velocity in a pipe as a function of
%Diameter. The constants used in calculating this are from data of a steel
%pipe
%% Storing the constants along with their units
e = 0.2 * 10^-3; %mm
L = 2000;%m
z1 = 30; %m
g = 9.807;%m/s^2
v = 1.12 * 10 ^-6; %m/s
prr = e/D;
%% Evaluating the average velocity
v0 = [D,17*D]; % set bounds for the velocity in terms of the diameter
velo = @(x) (x^2)/(2*g) + ffactor(x*D/v,prr) * (L/D)*(x^2/(2*g)) - z1; %make function handle for the average velocity equation
options = optimset('TolX',10*eps);% settings for the fzero function call.
V = fzero(velo,v0,options); % Get the value of V with the root finding process of fzero.
 

end