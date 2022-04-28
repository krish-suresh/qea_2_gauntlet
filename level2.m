% rosinitIfNotActive();

% data = preScanRoom();


data = readmatrix("data.txt");
circleTol = 0.05;
[lines,unfitData, hasCircle, circle, circlePoints] = detectObjectsRANSAC(data,0.01, 1000, 0.1, circleTol, 1000, 0.25);
clf
hold on;
% scatter(dpata(:,1), data(:,2));


% plotCircle(circle(1),circle(2), 0.25);
for i=1:(size(lines, 2)/2)
    plot(lines(:, i*2-1), lines(:, i*2))
end
scatter(unfitData(:,1), unfitData(:,2));
plot(circle(1),circle(2), "o")
plotCircle(circle(1),circle(2),0.25);
axis equal;