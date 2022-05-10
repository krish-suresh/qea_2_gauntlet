rosinitIfNotActive

map = gauntletMap;

number_of_particles = 100;
particles = [];
weights = [];
i = 0;
while i<number_of_particles
    new_particle = [randWithinRange(map.XWorldLimits), randWithinRange(map.YWorldLimits),randWithinRange([-pi,pi])];
    if checkOccupancy(map,new_particle(1:2))
        continue;
    end
    i = i+1;
    particles = [particles;new_particle];
    weights = [weights;1/number_of_particles];
end


raw_vel = rospublisher('raw_vel');
encoders = rossubscriber('encoders');
scan = rossubscriber('/scan');
stopRobot(raw_vel);
placeNeato(0,0,1,0,0.2);
pause(1);
pose = [0,0,0];
t = 0;
t_prev = 0;
last_filter_time = 0;
last_plot_time = 0;
enc_last = readEncoders(encoders);

filter_interval = 2;
setWheelVel(raw_vel,0.1,0.1)
clf
show(map); hold on
plot(particles(:,1),particles(:,2),"b."); hold off;
rostic;
while true
    t = rostoc;
    t_delta = t-t_prev;
    enc_current = readEncoders(encoders);
    enc_delta = enc_current - enc_last;
    pose = updateOdometry(pose, enc_delta, t_delta);
    [particles,weights] = applyOdom(particles,pose,map, weights);
    if t-last_filter_time > filter_interval
        stopRobot(raw_vel);
        scan_data = readScan(scan);
        weights = particleLikelihoods(particles,map, scan_data);
        weights = normalizeWeights(weights);
        particles = resampleParticles(particles,weights);
        last_filter_time = t;
        setWheelVel(raw_vel,0.1,0.1);
    end
    if t-last_plot_time > 0.3
        show(map); hold on
        plot(pose(1),pose(2),"r*")
        plot(particles(:,1),particles(:,2),"b."); hold off;
        last_plot_time = t;
    end
    enc_last = enc_current;
    t_prev = t;
end