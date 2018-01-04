function [w_bottle, zdirGlass, z_min, volCokeFull] = CokeBottle
%Usage 
left = [593 580 573 581 586 580 575 585 614 625 627 630];%points on left side of bottle
right = [743 754 761 752 748 753 759 749 720 709 706 703];%points on right side of bottle
fill  = [649 634 596 552 526 440 360 275 181 130  89  40];%height of bottle parameter

sf = 195/609;%scale factor mm/pixels

a = imread('cokebottlesketch.jpg'); %read image
imshow(a);%display image
hold on;
plot(left,fill,'ro',right,fill,'ro'); %plot the left and right points on the coke image

h_spline = (fill(1):-1:fill(end));%spline aling the z direction of the image
dir1_spline = interp1(fill,left,h_spline,'spline');%spline aling the left side of the bottle
dir2_spline = interp1(fill,right,h_spline,'spline');%spline along the right side
plot(dir1_spline,h_spline,'r',dir2_spline,h_spline,'r');%spline along the bottom 
hold off;

r = (right-left)*(sf/2);%r coords of the bottle
z = (fill(1) - fill)*sf;%z coords off the bottle pts

t = 3.0;            % Wall thickness.
dg = 2500.0e-6;   % Glass density [g/mm^3].
dc = 1000.0e-6;   % Coke density [g/mm^3].

outer = griddedInterpolant(z,r,'spline'); %function for the spline of the r-z coords
inner = @(l) outer(l) - t;%function for the inner radius of the bottle

bottomR  = @(x) outer(x).^2;%bottom radius in r-z
bottomZ = @(x) x.*outer(x).^2;%bottom radius z-coords

sideR  = @(x) outer(x).^2 - inner(x).^2;%side radius in r coords
sideZ = @(x) x.*sideR(x);%side radius in z coords

innerR   = @(x) inner(x).^2;% inner radius sqaured
innerZ  = @(x) x.*inner(x).^2;%inner z squared

w_bottom  = dg*pi*dint(bottomR,0,t,16,'simp');%weight of the bottom
zw_bottom = dg*pi*dint(bottomZ,0,t,16,'simp');%z weight of the bottom

w_side  = dg*pi*dint(sideR,t,z(end),80,'simp');%weight of the side
zw_side = dg*pi*dint(sideZ,t,z(end),80,'simp');%zw weight of the side

w_bottle = w_bottom + w_side; %w of the bottle is bottom + side
zw_glass = zw_bottom + zw_side;%z weight of bottle is bottom + side
zdirGlass = zw_glass/w_bottle;
fprintf('          Mass of bottle : %7.2f g\n',w_bottle);
fprintf('Center of mass of bottle : %7.2f mm\n\n',zdirGlass);

level = 150;% start the fill level at 150
fill = (t:level);        % Using steps of 1 mm.   
w_coke = zeros(size(fill)); %initialize variables
zw_coke = zeros(size(fill));
w_cm = zeros(size(fill));
zw_cm(1) = zdirGlass;


n = 2;
%loop to find the number of intervals to find the iterations
for k = 2:length(fill)    
    w_coke(k)  = w_coke(k-1) + dc*pi*dint(innerR,fill(k-1),fill(k),n,'simp');
    zw_coke(k) = zw_coke(k-1) + dc*pi*dint(innerZ,fill(k-1),fill(k),n,'simp');
    zw_cm(k) = (zw_glass + zw_coke(k))/(w_bottle + w_coke(k));
end

figure;
plot(fill - t,zw_cm)
xlabel('depth of coke');
ylabel('center of mass');
title('Center of Mass vs Depth of Coke');

[z_min, kmin] = min(zw_cm);
fill_min = fill(kmin);
fprintf('  Minimum Centre of Mass : %7.2f mm\n',z_min);
fprintf('          depth : %7.2f mm\n\n',fill_min - t);

volCokeFull = w_coke(end)/dc/1000.0;          % Volume in ml
voloz = volCokeFull*33.8140226e-03;            % Volume in ounces 
fprintf('     full coke = %7.2f mm\n',fill(end) - t);
fprintf('           Mass of coke = %7.2f g\n',w_coke(end));
fprintf('         Volume of coke = %7.2f ml\n',volCokeFull);
fprintf('         Volume of coke = %7.2f oz\n\n',voloz);


fprintf('_____BOTTLE_____________________________\n')
fprintf('Trapezoidal rule:\n')
fprintf('  Subintervals on bottom: 512\n Subintervals on side: 2560 \n');

fprintf('Simpson''s rule:\n')
fprintf('  Subintervals on bottom: 16\n Subintervals on side: 80\n');

fprintf('_____FILLING_UP_COKE_____________________________\n')
fprintf('Trapezoidal rule:\n')
fprintf('  16 subintervals with 1mm step size => 2352 intervals total\n');

fprintf('Simpson''s rule:\n')
fprintf('  2 subintervals with 1mm step size => 294 intervals total\n');

end