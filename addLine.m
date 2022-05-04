function out = addLine(equation,x_range, y_range, endPoints, n, scale)
    if (endPoints(2,1)-endPoints(1,1)) ~= 0
        slope = (endPoints(2,2)-endPoints(1,2)) ./ (endPoints(2,1)-endPoints(1,1));
        intercept = endPoints(1,2) - (slope .* endPoints(1,1));
        a = linspace(endPoints(1,1), endPoints(2,1), n);
        b = slope.*a + intercept;
    else
        b = linspace(endPoints(1,2), endPoints(2,2), n);
        a = repmat(endPoints(1,1),n,1);
    end
    line = zeros([length(y_range),length(x_range)]);
    for i = 1:length(a)
        [x,y]=meshgrid(x_range,y_range);
        line = line - log(sqrt((x-(a(i))).^2+(y-(b(i))).^2)).*(1/n);
    end
    out = (line.*scale) + equation;
end