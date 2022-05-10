function pose = getPoseDelta(pose, enc_delta, t_delta)
    v_wheels = enc_delta/t_delta;
    v = mean(v_wheels);
    w = (v_wheels(2)-v_wheels(1))/0.235;

    pose(1) = v(1)*cos(pose(3))*t_delta;
    pose(2) = v(1)*sin(pose(3))*t_delta;
    pose(3) = w*t_delta;
end


