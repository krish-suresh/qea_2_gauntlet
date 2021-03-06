function new_data = scanToGlobalFrame(scan,pose)
    theta_range = deg2rad([0:359]');
    index=find(scan~=0);
    scan=scan(index);
    theta_range=theta_range(index);
    index=find(scan<3);
    scan=scan(index);
    theta_range=theta_range(index);

    origin_of_lidar_frame = [-0.084 0];
    data_in_l_frame = [cos(theta_range(:)).*scan sin(theta_range(:)).*scan ones(size(scan, 1),1)]';
    data_in_n_frame = [1 0 origin_of_lidar_frame(1);
                               0 1 origin_of_lidar_frame(2);
                               0 0 1]*data_in_l_frame;
    rotatedPoints = [cos(pose(3)) -sin(pose(3)) 0;
                     sin(pose(3)) cos(pose(3)) 0;
                     0 0 1]*data_in_n_frame;
    data_in_global_frame = [1 0 pose(1);
                               0 1 pose(2);
                               0 0 1]*rotatedPoints;
    new_data = data_in_global_frame(1:2,:)';
end

