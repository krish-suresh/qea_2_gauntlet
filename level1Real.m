rosinitIfNotActive();
vel_topic = rospublisher("raw_vel");
visualize = true;
sim = false;
x_range = linspace(-2,3, 50);
y_range = linspace(-4,1.5, 50);
stopRobot(vel_topic);
if sim
placeNeato(0,0,1,0,0.1);
end
pause(1);
[X,Y]=meshgrid(x_range,y_range);
f = X.*0;
corners = [-0.936, -3.2824;
2.11200, -3.2824;
2.11200, 0.68;
-0.936, 0.68;];
for i=1:4
    f = addLineFlat(f,x_range,y_range,[corners(i,:);corners((mod(i,4)+1),:)],50, 5,  0.1, 1.2);
end
f = addSource(f,x_range,y_range,[-0.1, -1.0414], 60);
% f = addSource(f,x_range,y_range,[0, -1.0414], 50);
f = addSource(f,x_range,y_range,[1.2192,-0.3048], 20);
f = addSource(f,x_range,y_range,[1.3208,-2.03200], 20);
% 
% for i=1:size(corners,1)
%     f = addSource(f,x_range,y_range,corners(i,:), 30);
% end

sink_point = [0.3,-2.15900];

f = addSink(f,x_range,y_range,sink_point, 200);

[px,py] = gradient(f);

[t,M, start_angle] = continuousGradPath(x_range,y_range,px,py,[0,0], sink_point, 0.1, 0.3);
% M_discrete = discreteGradPath(x_range,y_range,px,py,[0,0], sink_point,100,0.3,1.1);

if visualize
    figure(1); %#ok<UNRCH> 
    contour(X,Y,f, 100); hold on
    plot(M(:,1),M(:,2),'r-')
    hold off;
    xlabel("x (meters)")
    ylabel("y (meters)")
        axis equal;

    figure(2);
    h = surf(X,Y,f);
    set(h,'LineStyle','none')
end

poses = followPath(vel_topic, [0,0,0], M, t, start_angle);

setWheelVel(vel_topic,0.12,0.08);
pause(5);
stopRobot(vel_topic);


