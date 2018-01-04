function [f] = ffactor(Re,eD)
%Usage: function f = ffactor(Re,eD)
%Re: Reynolds drag number
%eD: roughness/Diameter ratio of pipe
%this function calculates the friction coeffiecient in a pipe using
%the colebrook formula and iteating using the newton-raphson root finding
%method. An initial value is assigned to f, and then iterated to
%convergence.

%If only one argument is given, the default value for eD is given to be 0
if nargin == 1
    eD = 0;
end
%Error regions are defined for invalid values of Re and eD (less than 0)
if Re < 0 || eD < 0
    error('Invalid value: inputs cannot be less than 0');
end
%If the Re is greater than 10^8 and eD is less than 0.05,a wwarning is
%issued because the colebrook formula may not hold true.
if Re > 10^8 || eD > 0.05
    warning('Warning: input values are above usual range');
end
%if the Reynolds number is less than 2100, laminar flow can be assumed.
%This means that the friction coeffieicent is 64/Re
if Re <= 2100 
    f = 64 / Re;
    return;
else
    %else set the initial value of f to the given formula.
    f = 1.325/((log(eD/3.7+5.74/(Re^0.9)))^2);
    
end
%Count the iterations with a counter
iter = 0;
%use a function handle for the colebrook formula as an anonymous function
fun = @(x) 1/sqrt(x) + 2.0*(log10(eD/3.7 + 2.51/(Re*sqrt(x))));
%The painstakingly hand-calculated derivative is also expressed as a function handle for newton raphson iteration 
fp = @(x) -0.5*(x)^(-3/2) + 2.0*(1/(log(10)*(eD/3.7 + 2.51/(Re*sqrt(x)))))*(-2.51/Re)*(-0.5)*(x^(-3/2));        
f_prev = f;
% fprintf('f_prev         f          fun(f)        funder(f)          rerr\n')
while(iter < 20)
%The iteration itself is self-contained within the function.
%________Newton_Raphson iteration sequence:__________________
        val = fun(f); %find value of function
        valp = fp(f); %find value of derivative
        f = f - val/valp; %calculate the new root estimate
        rerr = abs((f - f_prev)/(f)); %find the relative error of the root
        if rerr < 10*eps %if the rerr is within 10 *eps, then it has converged
            return;
        else
            f_prev = f; %else, store the curr value and move to the next iteration
        end
%____________________________________________________________
% fprintf('%6.3f       %6.3f         %6f        %6f       %6f\n',f_prev,f,val,valp,rerr)
end
error('Did not converge'); %if it did not converge, error.
end