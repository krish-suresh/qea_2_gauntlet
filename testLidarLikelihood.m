rosinitIfNotActive

map = gauntletMap;

number_of_particles = 2;
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
particles = [0,0,0; 1,0,0];
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
clf
show(map); hold on
plot(particles(:,1),particles(:,2),"b."); 
scan_data = readScan(scan);
weights = particleLikelihoods(particles,map, scan_data);
weights
weights = normalizeWeights(weights)
hold off;