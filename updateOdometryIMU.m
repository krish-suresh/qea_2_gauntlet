function pose = updateOdometryIMU(pose, enc_delta, t_delta, imu)
    [imuMsg,~,~] = receive(imu,10);
    heading = quat2eul([imuMsg.Orientation.X, imuMsg.Orientation.Y, imuMsg.Orientation.Z, imuMsg.Orientation.W]);

    v_wheels = enc_delta/t_delta;
    v = mean(v_wheels);
    pose(1) = pose(1)+v(1)*cos(pose(3))*t_delta;
    pose(2) = pose(2)+v(1)*sin(pose(3))*t_delta;
    pose(3) = heading;
end

