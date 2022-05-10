function new_data = scanToGlobalFrame(scan)
    theta_range = deg2rad([0:359]');
    index=find(scan~=0);
    scan=scan(index);
    theta_range=theta_range(index);
    index=find(scan<2);
    scan=scan(index);
    theta_range=theta_range(index);

    origin_of_lidar_frame = [-0.084 0];
    new_data = [cos(theta_range(:)).*scan sin(theta_range(:)).*scan];

end

