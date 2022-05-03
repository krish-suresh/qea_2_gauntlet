function driveToSink(pose, , velTopic)
    vL = speed(nearest_t) - track_width/2*omega(nearest_t);
    vR = speed(nearest_t) + track_width/2*omega(nearest_t);
    setWheelVel(velTopic, vL,vR);
end

