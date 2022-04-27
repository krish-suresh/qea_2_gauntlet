function [bestCircle,bestInliers, bestOutliers] = ransacCircle(x,y,r,n,d)
    data = [x,y];
    clf
%     scatter(x,y,"filled"); hold on;
    bestInliers = [];
    bestOutliers = [];
    bestCircle = [];
    bestPoints = [];
    
    for k=1:n
        points = datasample([x,y], 2, 'Replace', false);
        [xout, yout] = circcirc(points(1, 1), points(1, 2), r, points(2, 1), points(2, 2), r);
        for i=1:size(xout,2)
            test_circle = [xout(i), yout(i)];
            shifted_data = [x, y]-test_circle;
            dists = vecnorm(shifted_data');
            index = abs(dists-r) < d;
            inliers = data(index);
            outliers = data(~index);
            if size(inliers, 2) > size(bestInliers, 2)
                size(inliers, 2);
                bestInliers = inliers;
                bestOutliers = outliers;
                bestCircle = [xout(i), yout(i)];
                bestPoints = points;
            end
        end
    end
end

