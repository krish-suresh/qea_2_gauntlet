rosinitIfNotActive();
vel_topic = rospublisher("raw_vel");

visualize = false;
x_range = linspace(-2,3, 500);
y_range = linspace(-4,1.5, 500);
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
    f = addLine(f,x_range,y_range,[corners(i,:);corners((mod(i,4)+1),:)],50, 5);
end

f = addSource(f,x_range,y_range,[-0.25, -1], 0.6);
f = addSource(f,x_range,y_range,[1,-0.7], 0.4);
f = addSource(f,x_range,y_range,[1.41,-2], 0.4);

for i=1:size(corners,1)
    f = addSource(f,x_range,y_range,corners(i,:), 2);
end

sink_point = [0.75,-2.5];

f = addSink(f,x_range,y_range,sink_point, 4);

[px,py] = gradient(f);

[t,M, start_angle] = continuousGradPath(x_range,y_range,px,py,[0,0], sink_point, 0.5, 0.4);
M_discrete = discreteGradPath(x_range,y_range,px,py,[0,0], sink_point,100,0.3,1.1);

if visualize
    figure(1); %#ok<UNRCH> 
    contour(X,Y,f, 100); hold on
    plot(0,0,'b*');
    plot(M(:,1),M(:,2),'g*')
    plot(M_discrete(:,1),M_discrete(:,2),'r*')
    hold off
    
    figure(2);
    h = surf(X,Y,f);
    set(h,'LineStyle','none')
end


followPath(vel_topic, [0,0,0], M, t, start_angle);
