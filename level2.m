rosinitIfNotActive();

% data = preScanRoom();
scatter(data(:,1), data(:,2), "filled");
axis equal;

[lines,unfitData, hasCircle, circle] = detectObjectsRANSAC(data,0.2, 10, 0.2, 0.05, 10, 0.25)