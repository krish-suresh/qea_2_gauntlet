function plotRoom(room_data)
    [lines,unfitData] = detectLinesRANSAC(room_data,0.05, 500, 0.1, 0.25);
    clf
    hold on;
%     scatter(room_data(:,1), room_data(:,2), "filled")
    for i=1:(size(lines, 2)/2)
        plot(lines(:, i*2-1), lines(:, i*2))
    end
    scatter(unfitData(:,1), unfitData(:,2));
    axis equal
    hold off
end