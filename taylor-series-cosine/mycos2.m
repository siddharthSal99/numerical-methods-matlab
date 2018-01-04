function [f] = mycos2(x)
%Usage: function [f] = mycos2(x)
%given the vector or scalar argument x, this function calculates and
%returns the taylor approimated value of cosine, using the properties of
%periodicity and symmetry of cosine to limit the input to 0 to pi/2.
%Uses the helper function mycos2helper(c) below

%also prints the value of x which takes the most number of terms to
%converge using the loop below. this is not part of the calculation of the
%value of cosine.
%uses helper function to calculate the returned value of f 
[f,~] = mycos2helper(x);

% on the interval [0,pi/2], and using 5000 pts, the values of cosine are
% determined and the number of terms.

%intialize the arrays for storing the argument values of cosine and the number of
%associated terms
j = linspace(0,0.5*pi,5000);
nterms = [];
sumvals  = [];
%using the helper function, the finds the values of X and the associated
%number of terms to converge
for c = j
    [f1,k] = mycos2helper(c);
    nterms = [nterms,k];
    sumvals = [sumvals, f1];
end
% finds the maximum value of the number of terms 
ind = find(nterms == max(nterms));
max_x = j(ind);
max_y = sumvals(ind);
max_terms = nterms(ind);
%formats the output, which is the value of the max number of terms, the X
%value, the Y value and the number of terms
fprintf('Max X: %10e \nMax Y: %10e \nMax Terms: %10e\n',max_x,max_y,max_terms);
end

function [f,k] = mycos2helper(x)
% returns the value of cos(x) using taylor approximation with nterms terms
% and minimal error 

%sanitize input; put input in range 0 to pi/2 by dividing with range and
%refactoring the input to have the correct sign when the value is computed
%this uses the number of cycles the argument runs through to shorten the
%input
fact2 = floor(x/(0.5*pi));
fact = floor(x / (pi));
x = x - fact2*0.5*pi;
quad = mod(fact2,8);
quadmask = mod(quad,2) ~= 0;
x(quadmask) = 0.5*pi - x(quadmask);
%initialize the loop. The loop stops when the approximated error is less
%than the machine precision. error is approximated by the ratio of the last
%term to the sum.
k = 0;
sum = ((-1)^k).*((x.^(2.*k))./(factorial(2.*k)));
keepGoing = true;
while(keepGoing)
    k = k + 1;
    next_term = ((-1).^k)*((x.^(2.*k))./(factorial(2.*k))); %uses same taylor calculation
    sum = sum + next_term;
    if abs(next_term) < eps*abs(sum)%fixes divide by zero error
        break;
    end
end
%since k starts at zero, the number of terms used is k + 1
k = k + 1;
%assigns a sign to the argument given the quadrant it existed in before.
sign = mod(fact2,4);
mask0 = sign == 0;
mask3 = sign == 3;
mask = mask0 | mask3;
sign(mask) = 1;
sign(~mask) = -1;
sum = abs(sum);
f = sign.*sum;


end

