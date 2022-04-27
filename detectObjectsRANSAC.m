function [lines,unfitData, hasCircle, circle] = detectObjectsRANSAC(data,lineTol, lineIterations, lineMaxGap, circleTol, circleIterations, circleRadius)
%DETECTOBJECTSRANSAC Detects and outputs list of lines and goal circle if
%found
%   Uses RANSAC to detect and fit lines that fulfill a specified gap
%   distance and min inlier count. Also tries to fit a circle 

    lines = [];
    while true
        [~, outliers, endpoints, hasLine] = ransacLine(data, lineTol, lineIterations, lineMaxGap);
        if ~hasLine
            break
        end
        data = outliers;
        lines = [lines, endpoints];
    end

    [circle,~, unfitData, hasCircle] = ransacCircle(data,circleRadius,circleTol,circleIterations);
    
end

