function W = work()
x = [3.0 3.5 4.5 6.5 8.5]'; % volume
y = [150 120 85 55 38]'; % pressure

m = length(x); %find the order of polynom
V = Vandermonde2(x); %get the vandermonde matrix for pressure
p = V \ y; %coefficients

%integrate

absc = linspace(3.0,8.5,201);
V_fine = Vandermonde2(absc,m - 1);
y_fine = V_fine * p;
coeffs = p'; 
intcoeffs = coeffs./(length(coeffs):-1:1); %find nuemrical integgrral
ic = 3.^[length(p):-1:1];
y_shift = intcoeffs * ic';

intcoeffs = [intcoeffs, -1 * y_shift];
V_int = Vandermonde2(absc',5);

y_int = V_int * intcoeffs';

%% this line: messed me up!
vals = V * coeffs';
%%


subplot(2,1,1)
plot(x,y,'kx')
hold on
plot(absc,y_fine,'r');
xlabel('Volume');
ylabel('Pressure');
title('Volume vs pressure with interpolation');


subplot(2,1,2)
plot(absc,y_int); 
xlabel('Volume');
ylabel('Work')
title('Work vs Volume')


W = y_int(end);
end