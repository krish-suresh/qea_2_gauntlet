function [lines,unfitData, hasCircle, circle, circlePoints] = detectObjectsRANSAC(data,lineTol, lineIterations, lineMaxGap, circleTol, circleIterations, circleRadius)
%DETECTOBJECTSRANSAC Detects and outputs list of lines and goal circle if
%found
%   Uses RANSAC to detect and fit lines that fulfill a specified gap
%   distance and min inlier count. Also tries to fit a circle 


    unfitData = [];
    lines = [];
    count = 0;
    hasCircle = false;
    circle = [];
    circlePoints = [];
    while count < 10
        [~, outliers, endpoints, hasLine] = ransacLine(data, lineTol, lineIterations, lineMaxGap, 0.25);
        if ~hasLine
            count = count +1;
            continue;
        end
        count = 0;
        data = outliers;
        lines = [lines, endpoints];
    end
    [circle,circlePoints, data, hasCircle] = ransacCircle(data,circleRadius,circleTol,circleIterations);    
    unfitData = data;
    
end

