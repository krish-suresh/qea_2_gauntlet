function room = preScanRoom()
    sub = rossubscriber('/scan');
    
    poses = [0 0 0; 
            1.5 0 pi/4; 
            -0.5 0 pi/6; 
            -0.5 -2 pi;
            0.5 -1.5 pi/2;
            1.5 -2.5 3*pi/2;
            1.5 -1.25 1];
    theta_range = deg2rad([0:359]');
    
    scans = zeros(size(theta_range, 1), size(poses,1));
    
    for i = 1 : size(poses,1)
        placeNeato(poses(i,1),poses(i,2),cos(poses(i,3)),sin(poses(i,3)), 0.1)
        pause(0.5);
        scan_message = receive(sub);
        scans(:,i) = scan_message.Ranges(1:end-1);
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

