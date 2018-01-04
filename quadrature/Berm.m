%models and plots the shape of the berm with a given function and x
%distance from the sea shore
function [A,xc] = Berm
    %function to model the shape of a berm
    H = @(x) (0.1.*x + 0.01.*x.^2 - (1.48*10^-5)*x.^4).^(4/3);
    TolX = 10^-6; %set up a tolerance
    fprintf('Subintervals          Area           rerr\n')
    n = 2; %intialize th number of subintervals to 2
    prev = simp13(H,0,30,n); %first calculation of area with subintervals
    n = 2*n; %double the number of subintervals
    curr = simp13(H,0,30,n); %finds the new area with subintervals
    rerr = abs((prev - curr)/prev); %calculates the relative error of the change in area
    fprintf('%15.3f%15.3f%15.3e\n',n,curr,rerr)
    %loop repeats the above process until the rerr is within the tolerance
    while(rerr >= TolX)
        prev = simp13(H,0,30,n);
        n = 2*n;
        curr = simp13(H,0,30,n);
        rerr = abs((prev - curr)/prev); 
        fprintf('%15.3f%15.3f%15.3e\n',n,curr,rerr)
    end
    A = curr;
    %function for the moments of each x point
    moment = @(x) x.*(0.1.*x + 0.01.*x.^2 - (1.48*10^-5)*x.^4).^(4/3);
    %finds the sum of the moments of each xdata point
    moments = simp13(moment,0,30,n);
    xc = moments./A; %calculates centroid by moment and area
    fprintf('Area: %0.3f\nCentroid: %0.3f\nSubintervals: %0.3f',A,xc,n);
    figure %plotting the shape of the berm
    xdata = linspace(0,30,512);
    ydata = H(xdata);
    plot(xdata,ydata);
    ylabel('Height of Berm (m)')
    xlabel('Distance From Shore (m)')
    title('Shape of Berm')
end