function [lapLength1, lapLength2] = RaceCourse
%function RaceCourse returns the nominal lengths of the race course from
%the given data points and a cubic spline.
img = imread('racecourse.png');
image(img);
%the scale is 120 pixels long which corresponds to 1109 ft or 338 m
scale_ft = 1109/120;
%racetrack data is stored as an excel file: extract the x and y coordinates
[num,txt,raw] = xlsread('RaceCourseData.xlsx');
xData = num(1:end,1);
yData = num(1:end,2);
hold on;
%plot the data as red circles
plot(xData,yData,'ro');
%call the helper function to get the distance around the track and apply
%the scale
sumdist = cdist(xData,yData);
distInFeet = sumdist * scale_ft;
%convert the distance in feet to miles
lapLength1 = distInFeet / 5280;
fprintf('Number of points: %d\nLength in feet: %0.3f\nLength in Miles: %0.3f\n\n',length(xData),distInFeet,lapLength1)
t_coarse = 1:length(xData);%coarse abscissa of the parameter value t
t_fine = linspace(1,length(xData),2001); %finer abscissa over the same interval
xfit = interp1(t_coarse,xData,t_fine,'spline');%fit the xData to the parameter with the interp1 cubic spline
yfit = interp1(t_coarse,yData,t_fine,'spline');%fit the yData to the parameter with the interp1 cubic spline


plot(xfit,yfit,'-r','LineWidth',3);%plot the newly fit x and y data
sumdistSpl = cdist(xfit,yfit);%find the distance around the track of the interpolated racetrack curve
distInFeetSpl = sumdistSpl * scale_ft;%convert to feet and miles
lapLength2 = distInFeetSpl / 5280;
fprintf('Number of points: %d\nLength in feet: %0.3f\nLength in Miles: %0.3f\n',length(xfit),distInFeetSpl,lapLength2)
fprintf('Difference between the calculated lengths: %0.3f feet\n',(lapLength2 - lapLength1)*5280);


end
%Helper function takes in x and y data points and finds the cumulative sum
%of the distances between the points.
function [d] = cdist(xData,yData) 
    d = 0; 
    for n = 1:length(xData) - 1
        prev = [xData(n),yData(n)];
        curr = [xData(n + 1),yData(n + 1)];
        d = d + sqrt((prev(2) - curr(2))^2 + (prev(1) - curr(1))^2);
    end
end