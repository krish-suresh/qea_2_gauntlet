rosinitIfNotActive();
vel_topic = rospublisher("raw_vel");

doScan = true;
visualize = true;


x_range = linspace(-2,3, 500);
y_range = linspace(-4,1.5, 500);
stopRobot(vel_topic);
placeNeato(0,0,1,0,0.1);
pause(1);
[X,Y]=meshgrid(x_range,y_range);
f = X.*0;

if doScan
    data = preScanRoom();
end


[lines,unfitData, hasCircle, circle, circlePoints]= detectObjectsRANSAC(data,0.02, 500, 0.2, 0.02,50,0.25);

if hasCircle
    sink_point = circle; 
    f = addSink(f,x_range,y_range,sink_point, 10);
end

for i=1:(size(lines, 2)/2)
    f = addLinePropToLen(f,x_range,y_range,[lines(:, i*2-1),lines(:, i*2)],50, 1);
end

[px,py] = gradient(f);

[t,M, start_angle] = continuousGradPath(x_range,y_range,px,py,[0,0], sink_point, 0.5, 0.4);
% M_discrete = discreteGradPath(x_range,y_range,px,py,[0,0], sink_point,100,0.3,1.1);

figure(1);
clf
contour(X,Y,f, 100); hold on
plot(0,0,'b*');
plot(M(:,1),M(:,2),'g*')
% plot(M_discrete(:,1),M_discrete(:,2),'r*')
hold off

figure(2);
clf
h = surf(X,Y,f);
set(h,'LineStyle','none')

figure(3);
clf
hold on;
if ~isempty(unfitData)
scatter(unfitData(:,1),unfitData(:,2),'filled'); axis equal; 
end
for i=1:(size(lines, 2)/2)
    plot(lines(:, i*2-1), lines(:, i*2))
end
if hasCircle
    if ~isempty(circlePoints)
    scatter(circlePoints(:,1), circlePoints(:,2), "filled")
    end
    plotCircle(circle(1), circle(2), 0.25);
end
axis equal;
hold off;
% stopRobot(vel_topic);
% placeNeato(0,0,1,0,0.1);
% pause(1);
% followPath(vel_topic, [0,0,0], M, t, start_angle);