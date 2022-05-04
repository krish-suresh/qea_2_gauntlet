function M = discreteGradPath(x_range,y_range, px, py, start_pose, sink_point, n_max, lambda, delta)
    n = 0;
    r = start_pose';
    M = start_pose;
    while n<n_max && pdist([sink_point;r'],'euclidean')>0.3
        [~,x_idx]=min(abs(x_range-r(1)));
        [~,y_idx]=min(abs(y_range-r(2)));
        grad = -[px(y_idx,x_idx);py(y_idx,x_idx)];
        r = r + lambda*grad;
        lambda = lambda*delta;
        n = n+1;
        M = [M;r'];
    end
end

