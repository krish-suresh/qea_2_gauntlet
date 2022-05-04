function turnToAngle(vel_topic, current_angle, target_angle, speed)
    track_width = 0.235;
    omega = 2*speed/(track_width);
    angle_delta = angleWrap(target_angle-current_angle);
    if angle_delta < 0
        speed = -speed;
    end
    setWheelVel(vel_topic,-speed, speed);
    pause(abs(angle_delta/omega));
    stopRobot(vel_topic);
end

