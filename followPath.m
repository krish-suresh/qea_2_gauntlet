function followPath(vel_topic,pose, M, time, start_angle)

    turnToAngle(vel_topic, pose(3), start_angle, 0.1);
    return;
    time_delta = time(2:end,:)-time(1:end-1,:);
    T = (M(2:end,:)-M(1:end-1,:))./time_delta;
    T_hat = T./vecnorm(T')';
    time_delta = time(3:end,:)-time(2:end-1,:);
    N = (T_hat(2:end,:)-T_hat(1:end-1,:))./time_delta;
    N = [N,zeros(size(N,1),1)];
    T_hat = [T_hat,zeros(size(T_hat,1),1)];
    B = cross(N',T_hat(2:end, :)')';
    speed = vecnorm(T')';
    omega = -B(:,3);

    rostic;
    while true
        t = rostoc();
        if t > time(end)
            break
        end
        [~,nearest_t]=min(abs(time-t));
        vL = speed(nearest_t) - track_width/2*omega(nearest_t);
        vR = speed(nearest_t) + track_width/2*omega(nearest_t);
        setWheelVel(vel_topic,vL,vR);
    end

    stopRobot(vel_topic);
end