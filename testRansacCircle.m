% room_data = readmatrix("data.txt");
[circle,circlePoints, data, hasCircle] = ransacCircle(room_data,0.25,0.01,500); 
clf
plot(room_data(:,1),room_data(:,2),"."); hold on;
if hasCircle
    plotCircle(circle(1), circle(2), 0.25);
    plotCircle(circle(1), circle(2), 0.25-0.01);
    plotCircle(circle(1), circle(2), 0.25+0.01);
end

axis equal;