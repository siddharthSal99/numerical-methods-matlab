function P = polyval(coeff,xq)
[rx,cx] = size(coeff);
[ry,cy] = size(xq);
if(all([rx,ry,cx,cy] ~= 1))
    error('input arguments must be one dimensional vectors');
end
if(rx == 1)
    coeff = coeff';
end
if(ry == 1)
    xq = xq';
end
n = length(xq);
m = length(coeff);
V = ones(n,m);
V(:,n - 1) = x;
for k = n - 2: -1: 1
    V(:,k) = x.*V(:,k+1);
end
P = V * coeff;
end