rosinitIfNotActive();

% data = preScanRoom();


% data = readmatrix("data.txt");


SCAN_RATE = 0.1; % s

pose = [0,0,0];
poses = pose;
placeNeato(pose(1), pose(2),cos(pose(3)),sin(pose(3)),0.05);
pause(0.5);

raw_vel = rospublisher('raw_vel');
encoders = rossubscriber('encoders');
scan = rossubscriber('/scan');
% imu = rospublisher('imu');

setWheelVel(raw_vel, 0.15, 0.07)
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
        filtered_new_data = scanToGlobalFrame(scan_data,pose);
        filtered_new_data = filterAroundPoint(filtered_new_data, [0.75, -2.5], 0.35);
%         filtered_new_data = filterClosePointsKnn(room_data, filtered_new_data, 0.05);
%         room_data = [room_data; filtered_new_data]; %#ok<AGROW> 
        room_data = uniquetol([room_data;filtered_new_data], 0.01, 'ByRows', true);
        last_scan_time = t;
    end
    enc_last = enc_current;
    t_prev = t;
    poses = [poses;pose]; %#ok<AGROW> 
end
stopRobot(raw_vel);

plotRoom(room_data)
