rosinitIfNotActive

raw_val = rospublisher("raw_vel");
encoders = rossubscriber("encoders");
controller = controllerPurePursuit;
placeNeato(0,0,1,0);
controller.Waypoints = waypoints;
controller.MaxAngularVelocity = 1;
controller.LookaheadDistance = 1;
controller.DesiredLinearVelocity = 0.2;
pose = [waypoints(1,:),0];
t_prev = 0;
d = 0.235;
enc_last = 0;
t = 0;

rostic;
while t < 10
    t = rostoc();
    [v,w] = controller(pose);
    t_delta = t-t_prev;
    enc_current = readEncoders(encoders);
    enc_delta = enc_current - enc_last;
    pose = updateOdometry(pose, enc_delta, t_delta);
    vL = v - d/2*w;
    vR = v + d/2*w;
    setWheelVel(raw_val, vL, vR);
    enc_last = enc_current;
    t_prev = t;
end
stopRobot(raw_val)