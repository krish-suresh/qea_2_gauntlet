[lines,unfitData, hasCircle, circle, circlePoints]= detectObjectsRANSAC(room_data,0.15, 1000, 0.22, 0.1,500,0.381);
clf
hold on;
% scatter(room_data(:,1), room_data(:,2), "filled")
for i=1:(size(lines, 2)/2)
    plot(lines(:, i*2-1), lines(:, i*2))
end
scatter(unfitData(:,1), unfitData(:,2));

if hasCircle
    scatter(circlePoints(:,1), circlePoints(:,2), "filled")

    plotCircle(circle(1), circle(2), 0.381);
end

axis equal
hold off