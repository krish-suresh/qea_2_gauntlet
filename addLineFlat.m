function out = addLineFlat(equation,x_range, y_range, endPoints, n, scale, shortScale, flatVal)
    if (endPoints(2,1)-endPoints(1,1)) ~= 0
        slope = (endPoints(2,2)-endPoints(1,2)) ./ (endPoints(2,1)-endPoints(1,1));
        intercept = endPoints(1,2) - (slope .* endPoints(1,1));
        a = linspace(endPoints(1,1), endPoints(2,1), n);
        b = slope.*a + intercept;
    else
        b = linspace(endPoints(1,2), endPoints(2,2), n);
        a = repmat(endPoints(1,1),n,1);
    end
    s_range = (linspace(-flatVal,flatVal,n).^2)+1;
    line = zeros([length(y_range),length(x_range)]);
    for i = 1:length(a)
        [x,y]=meshgrid(x_range,y_range);
        line = line - log(sqrt((x-(a(i))).^2+(y-(b(i))).^2)).*s_range(i);%.*(1/n);
    end
    dist = pdist(endPoints,'euclidean');
    if dist < 1
        scale = shortScale;
    end
    out = (line.*scale) + equation;
end