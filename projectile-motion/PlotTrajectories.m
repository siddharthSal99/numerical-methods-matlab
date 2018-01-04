%Siddharth Salunkhe
%Georgia Institute of Technology
%ME 2016 section E, Professor Mark Smith
%Last Updated: 8/27/2017
function result = PlotTrajectories(alpha, V, doAnimate)
%initialize intitial conditions for location of target, dart and goal. also
%define g as  universal gravitational accerleration constant
dartX = 0;
dartY = 10;
goalX = 10;
goalY = 5; 
targX = 10;
targY = 10;
g = 9.80655;
%if no third argument is given, default it to false
if nargin == 2
    doAnimate = true;
end
%set the end points for parameter t and create 100 points of the parameter
%t to generate paths for the dart and the target
% x = V*cos(alpha)*t, y = -g*t.^2 + V*sin(alpha)*t
t_f = 10./(V*cosd(alpha));
t = linspace(0,t_f);
%using kinematics formulas, calculate the intermittent positions of the
%dart and target using time parameter vector t and store them in vectors
dart_xData =  V.*cosd(alpha).*t + dartX;
dart_yData = dartY + V.*sind(alpha).*t - 0.5.*g.*t.^2;
targ_xData = linspace(targX,targX,length(t));
targ_yData = targY - 0.5.*g.*t.^2;

%call the animate function, if the user wants to  animate the trajectory
if doAnimate
   animate(dart_xData,dart_yData,targ_xData,targ_yData,goalX,goalY,t); 
end

%find th result of the trajctory, if the dart hit the target, goal, none or
%both within an error of one centimeter using the last point on the vector
if(abs(dart_yData(end) - targ_yData(end)) < 0.01)
    if(abs(dart_yData(end) - goalY) < 0.01)
        result = 'Hit, and on goal.';
    else
        if(dart_yData(end) > goalY)
            result = 'Hit, but too high.';
        else
            result = 'Hit, but too low.';
        end
    end
else
    result = 'Sorry, missed it.';
end

end