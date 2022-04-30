rosinitIfNotActive();

% data = preScanRoom();


% data = readmatrix("data.txt");


SCAN_RATE = 0.25; % Hz

pose = [0,0,0];
placeNeato(pose(1), pose(2),cos(pose(3)),sin(pose(3)),0.05);
pause(0.5);

raw_vel = rospublisher('raw_vel');
encoders = rossubscriber('encoders');
scan = rossubscriber('/scan');
% imu = rospublisher('imu');

setWheelVel(raw_vel, 0.2, 0.2)
room_data = [];
t = 0;
t_prev = 0;
last_scan_time = 0;
enc_last = readEncoders(encoders);
clf
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

plotRoom(room_data)
