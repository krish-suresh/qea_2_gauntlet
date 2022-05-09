rosinitIfNotActive();
vel_topic = rospublisher("raw_vel");
visualize = true;
if visualize
    room_data = preScanRoom();
end
x_range = linspace(-2,3, 50);
y_range = linspace(-4,1.5, 50);
stopRobot(vel_topic);
placeNeato(0,0,1,0,0.1);
pause(1);
[X,Y]=meshgrid(x_range,y_range);
f = X.*0;
corners = [-1.5, -3.37;
2.5, -3.37;
2.5, 1;
-1.5, 1;];
for i=1:4
    f = addLineFlat(f,x_range,y_range,[corners(i,:);corners((mod(i,4)+1),:)],50, 10,  0.1, 1.5);
end

f = addSource(f,x_range,y_range,[-0.25, -1], 3);
f = addSource(f,x_range,y_range,[1,-0.7], 3);
f = addSource(f,x_range,y_range,[1.41,-2], 3);
% 
% for i=1:size(corners,1)
%     f = addSource(f,x_range,y_range,corners(i,:), 2);
% end

sink_point = [0.75,-2.5];

f = addSink(f,x_range,y_range,sink_point, 40);

[px,py] = gradient(f);

[t,M, start_angle] = continuousGradPath(x_range,y_range,px,py,[0,0], sink_point, 0.4, 0.4);
% M_discrete = discreteGradPath(x_range,y_range,px,py,[0,0], sink_point,100,0.3,1.1);
% poses = followPath(vel_topic, [0,0,0], M, t, start_angle);

if visualize
    figure(1); %#ok<UNRCH> 
    contour(X,Y,f, 100); hold on
    plot(M(:,1),M(:,2),'r-')
    if false
        plot(M_discrete(:,1),M_discrete(:,2),'bo')
        quiver(x_range,y_range,px,py,5,'green','LineWidth',2)
        legend("", "Continuous Gradient Path", "Discrete Gradient Path","")

    else
        plot(poses(:,1),poses(:,2),'b-')
        legend("", "Continuous Gradient Path", "Wheel Odometry")
    end
    hold off
    xlabel("x (meters)")
    ylabel("y (meters)")
    figure(2);
    h = surf(X,Y,f);
    set(h,'LineStyle','none')
    xlabel("x (meters)")
    ylabel("y (meters)")
    figure(3);
    scatter(room_data(:,1),room_data(:,2),'filled');
    xlabel("x (meters)")
    ylabel("y (meters)")
    axis equal;
end


