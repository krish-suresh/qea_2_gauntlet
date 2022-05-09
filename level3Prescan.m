rosinitIfNotActive();
vel_topic = rospublisher("raw_vel");

doScan = false;
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


% [lines,unfitData, hasCircle, circle, circlePoints]= detectObjectsRANSAC(data,0.02, 500, 0.2, 0.02,50,0.25);

if hasCircle
    sink_point = circle; 
    f = addSink(f,x_range,y_range,sink_point, 40);
end

for i=1:(size(lines, 2)/2)
    f = addLineFlat(f,x_range,y_range,[lines(:, i*2-1),lines(:, i*2)],50, 1, 0.021, 1.2);
end

[px,py] = gradient(f);

% [t,M, start_angle] = continuousGradPath(x_range,y_range,px,py,[0,0], sink_point, 0.5, 0.4);
% M_discrete = discreteGradPath(x_range,y_range,px,py,[0,0], sink_point,100,0.3,1.1);

stopRobot(vel_topic);
placeNeato(0,0,1,0,0.1);
pause(1);
% poses = followPath(vel_topic, [0,0,0], M, t, start_angle);

figure(1); %#ok<UNRCH> 
contour(X,Y,f, 100); hold on
plot(M(:,1),M(:,2),'r-')
if false
    plot(M_discrete(:,1),M_discrete(:,2),'bo')
    n = 20;
    quiver(x_range(1:n:end),y_range(1:n:end),px(1:n:end,1:n:end),py(1:n:end,1:n:end),5,'green','LineWidth',2)
    legend("", "Continuous Gradient Path", "Discrete Gradient Path", "")

else
    plot(poses(:,1),poses(:,2),'b-')
    legend("", "Continuous Gradient Path", "Wheel Odometry")
end
hold off
xlabel("x (meters)")
ylabel("y (meters)")

figure(2);
clf
h = surf(X,Y,f);
set(h,'LineStyle','none')
xlabel("x (meters)")
ylabel("y (meters)")
figure(3);
clf
hold on;
if ~isempty(unfitData)
    hunfit = scatter(unfitData(:,1),unfitData(:,2),'filled'); axis equal; 
end

for i=1:(size(lines, 2)/2)
    hline = plot(lines(:, i*2-1), lines(:, i*2),'r-');
end
if hasCircle
    if ~isempty(circlePoints)
%     scatter(circlePoints(:,1), circlePoints(:,2), "filled")
    end
    plot(circle(1), circle(2),"r*")
    hcircle = plotCircle(circle(1), circle(2), 0.25);
end
hleglines = [hunfit(1) hline(1) hcircle(1)];
hleg = legend(hleglines,"Unfitted Data","RANSAC Fitted Circle", "RANSAC Fitted Lines");
xlabel("x (meters)")
ylabel("y (meters)")
axis equal;
hold off;
