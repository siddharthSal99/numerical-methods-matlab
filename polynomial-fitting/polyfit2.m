function [P] = polyfit2(x,y)
if(length(x) ~= length(y))
    error('input arguments must be the same length vectors');
end
[rx,cx] = size(x);
[ry,cy] = size(y);
if(all([rx,ry,cx,cy] ~= 1))
    error('input arguments must be one dimensional vectors');
end
if(rx == 1)
    x = x';
end
if(ry == 1)
    y = y';
end
n = length(x);
V = ones(n);
V(:,n - 1) = x;
for k = n - 2: -1: 1
    V(:,k) = x.*V(:,k+1);
end
p = V \ y;
end