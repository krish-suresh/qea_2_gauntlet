function plotRoom(room_data, poses)
    filtered_data = filterAroundPoint(room_data, [0.75, -2.5], 0.35);
    [lines,unfitData] = detectLinesRANSAC(filtered_data,0.05, 500, 0.1, 0.25);
    clf
    hold on;
    if ~isempty(poses)
        plot(poses(:,1), poses(:,2), "-")
    end
%     scatter(room_data(:,1), room_data(:,2), "filled")
    for i=1:(size(lines, 2)/2)
        plot(lines(:, i*2-1), lines(:, i*2))
    end
    scatter(unfitData(:,1), unfitData(:,2));
    axis equal
    hold off
end