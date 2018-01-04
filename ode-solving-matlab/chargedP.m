%author: ssalunkhe3
%version 1.1
function [zNeutralM, zNeutralF, nBounce] = chargedP(q)
%q the charge of the particle
%zNeutralM the equilibrium position of the particle
%zneutralF the equilibrium calculated by fzero
%nBounce the number of times the particle hits the disk
if nargin == 0 
    q = 0.6e-7; %default value for charge
end
m = 0.01; % [kg], particle mass
R = 0.02; % [m], disk radius
Q = 0.6e-7; % [C], disk charge
g = 9.807; % [m/s^2], acceleration of gravity
e0 = 8.854e-12; % [C^2/(N.m^2)], vacuum permittivity
cR = 0.70; % [1], coefficient of restitution
k = 0.0366; % [N.s/m], viscous drag constant

K = (Q*q)/(2*pi*R^2*e0*m*g); %dimensionless emf
Cd = sqrt(R/g)*k/m; %dimensionless drag coeffiecient
%define the ode with a column vector composed of a system of first order
%eqs
    function dydx = odefun(x,y)
        dydx = [y(2);
            K*(1-y(1)/(sqrt(y(1).^2 + 1))) - 1 - Cd*y(2)];
    end
%equation for long term behavior of particle
eqPos = @(x) K*(1 - x/(sqrt(x^2 + 1))) - 1;
%find the eq position with fzero
if q < 3.6e-8
    zNeutralF = 0;
    zNeutralN = 0;
else
zNeutralF = fzero(eqPos,0);
end
%presets for solving the ode
options = odeset('RelTol',1.0e-6,'AbsTol',1.0e-8);
tspan = [0,100];
ic = [1;0];
%use the ode solver to gain the result
[t,y] = ode45(@odefun,tspan,ic,options);
t_end = t(end);
t_finalstart = t_end - 5.6;
t_finalcycle = t > t_finalstart;
y_finalcycle = y(t_finalcycle,1);
%isolate the last period of the particle motion and average them to get the
%value for the eq position
zNeutralM = mean(y_finalcycle);
if zNeutralM < 0
    zNeutralM = 0;
end

function [position,isterminal,direction] = myEventsFcn(t,y)
position = y(1); % The value that we want to be zero
isterminal = 0;  % Halt integration 
direction = -1;   % The zero can be approached from either direction
end
options = odeset('RelTol',1.0e-6,'AbsTol',1.0e-8,'Events',@myEventsFcn);
tfinal = 100;
tstart = 0;
nBounce = 0;
keepGoing = true;
tooSlow = true;
hold on;
subplot(2,1,2)
plot(t,y(:,2),'b');
title(sprintf('Velocity vs Time of Particle with Charge %0.4e',q));
xlabel('Time');
ylabel('Velocity');
subplot(2,1,1)
while(keepGoing & tooSlow)
[t,y,te,ye,ie] = ode45(@odefun,[tstart tfinal],ic,options);
if (~isempty(te)) %change the value of the start, and the plot time as the particle hits the disk
ic(1) = 0;
ic(2) = -ye(1,2).* cR;
if ~ishold
    hold on
end
if abs(ic(2)) < 1e-4
    y = zeros(size(y));
    t = linspace(min(t),max(t),length(t));
    tooSlow = false; %if the particle bounces too slowly, do not continue
end
nBounce = nBounce + 1; %count the number of bounces
tstart = te(1);
plot(t(t < tstart),y(t < tstart,1),'r');
else
    keepGoing = false; %if there are no more bounces
end

end

plot(t,y(:,1),'r');
title(sprintf('Position vs Time of Particle with Charge %0.4e',q));
xlabel('Time');
ylabel('Position');

end
