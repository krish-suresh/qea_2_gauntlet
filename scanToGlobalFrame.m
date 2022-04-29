function room_data = scanToGlobalFrame(scan,pose, room_data)
    theta_range = deg2rad([0:359]');
        
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
    room_data = [room_data; data_in_global_frame(1:2,:)'];
end

