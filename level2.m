rosinitIfNotActive();

% data = preScanRoom();


% data = readmatrix("data.txt");


SCAN_RATE = 1; % Hz

pose = [0,0,0];
placeNeato(pose(1), pose(2),cos(pose(3)),sin(pose(3)),0.05);
pause(0.5);

raw_vel = rospublisher('raw_vel');
encoders = rossubscriber('encoders');
scan = rossubscriber('/scan');
% imu = rospublisher('imu');

setWheelVel(raw_vel, 0.2, 0.1)
room_data = [];
t = 0;
t_prev = 0;
last_scan_time = 0;
enc_last = readEncoders(encoders);

rostic;
while t<5
    t = rostoc();
    t_delta = t-t_prev;
    enc_current = readEncoders(encoders);
    enc_delta = enc_current - enc_last;
    pose = updateOdometry(pose, enc_delta, t_delta);
%     pose = updateOdometryIMU(pose, enc_delta, t_delta, imu);
    if t-last_scan_time > SCAN_RATE
        scan_data = readScan(scan);
        room_data = scanToGlobalFrame(scan_data,pose,room_data);
        last_scan_time = t;
    end
    enc_last = enc_current;
    t_prev = t;
end
stopRobot(raw_vel);

circleTol = 0.01;
[lines,unfitData, hasCircle, circle, circlePoints] = detectObjectsRANSAC(room_data,0.03, 1000, 0.3, circleTol, 1000, 0.25);
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