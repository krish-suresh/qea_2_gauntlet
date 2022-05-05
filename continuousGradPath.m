function [time, M, start_angle] = continuousGradPath(x_range,y_range, px, py, start_pose, sink_point, speed_scale, end_dist)
    [~,x_idx]=min(abs(x_range-start_pose(1)));
    [~,y_idx]=min(abs(y_range-start_pose(2)));
    g = -[px(y_idx,x_idx);py(y_idx,x_idx)];    
    start_angle = atan2(g(2),g(1));
    function [value, isterminal, direction] = event_func(~, X)
        value = pdist([X';sink_point],'euclidean') - end_dist;
        isterminal = 1;
        direction = 0;
    end

    function res = func(~,r)
        [~,x_idx]=min(abs(x_range-r(1)));
        [~,y_idx]=min(abs(y_range-r(2)));
        res = -[px(y_idx,x_idx);py(y_idx,x_idx)];
        res = speed_scale.*res./norm(res);

    end

    options = odeset('Events', @event_func);
    [time, M] = ode45(@func,[0, 500], start_pose, options);
end

