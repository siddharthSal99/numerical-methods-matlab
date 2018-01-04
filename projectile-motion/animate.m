%Siddharth Salunkhe
%Georgia Institute of Technology
%ME 2016 section E, Professor Mark Smith
%Last Updated: 8/27/2017
function[] = animate(dart_xData,dart_yData,targ_xData,targ_yData,goalX,goalY,t)
%usage: animate(dart_xData,dart_yData,targ_xData,targ_yData,goalX,goalY,t)
%takes in the [x,y] params for the trajectory of a falling target and a
%thown dart and animates their respective paths in a matlab plot using the animatedline
%object.
    hold on
    box; grid;
    %create the animated line objects; one for the target, one for the dart
    h = animatedline('color','g'); 
    i = animatedline('color','r');
    %plotting the initial points of the marker that follows the trajectory
    %of the animatedline.
    d_mark = plot(dart_xData(1),dart_yData(1),'color','g','marker', 'x');
    t_mark = plot(targ_xData(1),targ_yData(1),'color','r','marker', 'x');
    %plot the location of the goal
    plot(goalX,goalY,'color','b','marker','o');
    %set the axes bounds and grid layout specifications
    axis([-2,12,-2,12]) ;
    box; grid;
    %loop through each of the [x,y] data for the dart and target, and add
    %the most recent point to the end of the animated line, as well as
    %update the position of the marker. Pause at the end, to show the
    %animatedline motion
    for k = 1:length(t) 
      addpoints(h,dart_xData(k),dart_yData(k));
      addpoints(i,targ_xData(k),targ_yData(k));
      d_mark.XData = dart_xData(k);
      d_mark.YData = dart_yData(k);
      t_mark.XData = targ_xData(k);
      t_mark.YData = targ_yData(k);
      drawnow update 
      pause(0.03);
    end
    hold off
end