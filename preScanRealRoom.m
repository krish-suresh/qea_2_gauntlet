function room = preScanRealRoom()    
    poses = [0 0 0; 
            1.4732 -1.1684 0; 
            0.6604 -1.6256 0; 
            -0.381 -1.8161 0;
            -0.3302 -2.8702 0;
            0.7366 -0.6985 0;];
    theta_range = deg2rad([0:359]');
    
    scans = zeros(size(theta_range, 1), size(poses,1));
    
    for i = 1 : size(poses,1)
        scans(:,i) = readmatrix("data/scan"+int2str(i)+".csv");
    end 
    origin_of_lidar_frame = [-0.084 0];
    room = zeros(size(scans, 1)*size(poses,1), 2);
    for i = 1 : size(poses,1)
        data_in_l_frame = [cos(theta_range(:)).*scans(:,i) sin(theta_range(:)).*scans(:,i) ones(size(scans, 1),1)]';
        data_in_n_frame = [1 0 origin_of_lidar_frame(1);
                                   0 1 origin_of_lidar_frame(2);
                                   0 0 1]*data_in_l_frame;
        rotatedPoints = [cos(poses(i, 3)) -sin(poses(i, 3)) 0;
                         sin(poses(i, 3)) cos(poses(i, 3)) 0;
                         0 0 1]*data_in_n_frame;
        data_in_global_frame = [1 0 poses(i,1);
                                   0 1 poses(i,2);
                                   0 0 1]*rotatedPoints;
        room((i-1)*size(theta_range, 1)+1:i*size(theta_range, 1),:) = data_in_global_frame(1:2,:)';
    end
end

