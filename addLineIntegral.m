function out = addLineIntegral(equation,x_range, y_range, endPoints, scale)
    dist = pdist(endPoints,'euclidean');
    
    slope = (endPoints(2,2)-endPoints(1,2)) ./ (endPoints(2,1)-endPoints(1,1));
    if ~isinf(slope)
        intercept = endPoints(1,2) - (slope .* endPoints(1,1));
    end
    a = endPoints(1,1);

    function res = fun(u) 
        [x,y]=meshgrid(x_range,y_range);
        if (endPoints(2,1)-endPoints(1,1)) ~= 0
            res = log(sqrt((x-u).^2+(y-(slope*u + intercept)).^2));
        else
            res = log(sqrt((x-a).^2+(y-u).^2));
        end
    end

    if (endPoints(2,1)-endPoints(1,1)) ~= 0
        line = -integral(@fun, min(endPoints(1,1),endPoints(2,1)), max(endPoints(1,1),endPoints(2,1)), 'ArrayValued', 1)./dist;
    else
        line = -integral(@fun, min(endPoints(1,2),endPoints(2,2)), max(endPoints(1,2),endPoints(2,2)), 'ArrayValued', 1)./dist;
    end

    out = (line.*scale) + equation;
end