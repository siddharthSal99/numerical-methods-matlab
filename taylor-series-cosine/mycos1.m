function [y] = mycos1(x,nterms)
% usage: function [y] = mycos1(x,nterms)
%given the argument x (vector or scalar), and the number of terms, this
%function calculates and returns the taylor approximated value of cos(x) 
% with the given number of terms.

% cos(x) = sum of m from 0 to nterms of (-1)^m (x^2m)/(2m!)
sum = zeros(1,length(x));
%vectorized, sum the intermediate terms of the taylor approximation.
for k = 0:nterms
    sum = sum + ((-1.)^k).*((x.^(2.*k))./(factorial(2.*k)));
end
y = sum;
end

