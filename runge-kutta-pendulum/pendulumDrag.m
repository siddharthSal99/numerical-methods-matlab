function [t, y, tdamp] = pendulumDrag(Cd)
if nargin == 0
Cd = 0.2;
end
g = 9.807; % [m/s^2], acceleration of gravity
L = 2; % [m], length
rhoA = 1.23; % [kg/m^3], air density
rhoB = 10.0; % [kg/m^3], bob density
D = 0.12; % [m], bob diameter


    function [dydx] = odefun(x,y)
       t1 = -1*(g/L)*sin(y(1));
       t2 = (3/4)*(Cd) *(rhoA/rhoB)*(L/D)*sign(y(2))*(y(2)^2);
       y_2prime = t1 - t2;
       dydx = [y(2);
               y_2prime];
           
    end
t = 0:0.005:40;
y0 = [2;0];
y = odeRK3(@odefun,t,y0);

figure;

%time history
subplot(2,1,1);
plot(t,y(1,:));
xlabel('t');
ylabel('theta');

%phase plot
subplot(2,1,2);
plot(y(1,:),y(2,:));
hold on;
plot(y(1,1),y(2,1),'ro');
xlabel('y_1');
ylabel('y_2');
th = y(1,end);
i = length(y(1,:));
while(abs(th) < 0.1)
th = y(1,i);
i = i - 1;
end
tdamp = t(i);
fprintf('tdamp: %0.3f\n',tdamp)
end