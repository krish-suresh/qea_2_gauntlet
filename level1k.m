rosinitIfNotActive();
visualize = false;
x_range = linspace(-2,3, 500);
y_range = linspace(-4,1.5, 500);

[X,Y]=meshgrid(x_range,y_range);
f = X.*0;
corners = [-1.5, -3.37;
2.5, -3.37;
2.5, 1;
-1.5, 1;];
for i=1:4
    f = addLine(f,x_range,y_range,[corners(i,:);corners((mod(i,4)+1),:)],50, 20);
end

objects = [-0.25, -1;1,-0.7;1.41,-2];
for i=1:size(objects,1)
    f = addSource(f,x_range,y_range,objects(i,:), 0.3);
end

for i=1:size(corners,1)
    f = addSource(f,x_range,y_range,corners(i,:), 1);
end

sink_point = [0.75,-2.5];

f = addSink(f,x_range,y_range,sink_point, 4);

[px,py] = gradient(f);

[t,M, start_angle] = continuousGradPath(x_range,y_range,px,py,[0,0], sink_point);
M_discrete = discreteGradPath(x_range,y_range,px,py,[0,0], sink_point,100,0.3,1.1);

if visualize
    figure(1); %#ok<UNRCH> 
    contour(X,Y,f, 100); hold on
    plot(0,0,'b*');
    plot(M(:,1),M(:,2))
    plot(M_discrete(:,1),M_discrete(:,2),'r*')
    hold off
    
    figure(2);
    h = surf(X,Y,f);
    set(h,'LineStyle','none')
end

vel_topic = rosmessage("raw_vel");

followPath(vel_topic, current_pose, M, t, start_angle);
