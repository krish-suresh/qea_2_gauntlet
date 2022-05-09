function poses = followPath(vel_topic,pose, M, time, start_angle)
    track_width = 0.235;
    turnToAngle(vel_topic, pose(3), start_angle, 0.05);
    time_delta = time(2:end,:)-time(1:end-1,:);
    T = (M(2:end,:)-M(1:end-1,:))./time_delta;
    T_hat = T./vecnorm(T')';
    time_delta = time(3:end,:)-time(2:end-1,:);
    N = (T_hat(2:end,:)-T_hat(1:end-1,:))./time_delta;
    N = [N,zeros(size(N,1),1)];
    T_hat = [T_hat,zeros(size(T_hat,1),1)];
    B = cross(N',T_hat(2:end, :)')';
    speed = vecnorm(T')';
    speed = speed(2:end);
    omega = -B(:,3);
    time = time(3:end);
    encoders = rossubscriber("encoders");
    pose(3) = start_angle;
    t_prev = 0;
    enc_last = readEncoders(encoders);
    poses = pose;
    rostic;
    while true
        t = rostoc()
        if t > time(end)
            break
        end
        t_delta = t-t_prev;
        enc_current = readEncoders(encoders);
        enc_delta = enc_current - enc_last;
        pose = updateOdometry(pose, enc_delta, t_delta);
        poses = [poses;pose];
        [~,nearest_t]=min(abs(time-t));
        vL = speed(nearest_t) - track_width/2*omega(nearest_t);
        vR = speed(nearest_t) + track_width/2*omega(nearest_t);
        setWheelVel(vel_topic,vL,vR);
        enc_last = enc_current;
        t_prev = t;
    end

    stopRobot(vel_topic);
end