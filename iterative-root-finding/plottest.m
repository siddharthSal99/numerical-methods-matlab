clear
clc
D = 0.025;

e = 0.2 * 10^-3; %mm
L = 2000;%m
z1 = 30; %m
g = 9.807;%m/s^2
v = 1.12 * 10 ^-6; %m/s
prr = e/D;
velo = @(x) (x^2)/(2*g) + ffactor(x*D/v,prr) * (L/D)*(x^2/(2*g)) - z1;
figure
fplot(velo,[0,5]);
hold on
plot([0,5],[0,0]);
