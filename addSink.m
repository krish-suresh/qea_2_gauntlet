function out = addSink(equation,x_range, y_range,point, scale)
    [x,y]=meshgrid(x_range,y_range);
    out = equation + log(sqrt((x-(point(1))).^2+(y-(point(2))).^2)).*scale;
end

