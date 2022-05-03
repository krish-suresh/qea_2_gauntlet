function [lines,unfitData] = detectLinesRANSAC(data,lineTol, lineIterations, lineMaxGap, lineMinLen)
%DETECTOBJECTSRANSAC Detects and outputs list of lines and goal circle if
%found
%   Uses RANSAC to detect and fit lines that fulfill a specified gap
%   distance and min inlier count. Also tries to fit a circle 


    unfitData = [];
    lines = [];
    count = 0;
    while count < 10
        [~, outliers, endpoints, hasLine] = ransacLine(data, lineTol, lineIterations, lineMaxGap, lineMinLen);
        if ~hasLine
            count = count +1
            continue;
        end
        count = 0;
        data = outliers;
        lines = [lines, endpoints];
    end
    unfitData = data;
end

