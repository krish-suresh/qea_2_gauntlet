function [bestCircle,bestInliers, bestOutliers, hasCircle] = ransacCircle(data,r,d,n)
    clf
%     scatter(x,y,"filled"); hold on;
    bestInliers = [];
    bestOutliers = [];
    bestCircle = [];
    bestPoints = [];
    hasCircle = true;
    for k=1:n
        points = datasample(data, 2, 'Replace', true);
        [xout, yout] = circcirc(points(1, 1), points(1, 2), r, points(2, 1), points(2, 2), r);
        if isnan(xout(1)) || pdist(points, "euclidean") < 0.1
            continue;
        end
        for i=1:size(xout,2)
            test_circle = [xout(i), yout(i)];
            shifted_data = data-test_circle;
            dists = vecnorm(shifted_data');
            index = (abs(dists-r) < d)';
            inliers = data(index, :);
            outliers = data(~index, :);
            if size(inliers, 1) > size(bestInliers, 1)
                size(inliers, 2);
                bestInliers = inliers;
                bestOutliers = outliers;
                bestCircle = [xout(i), yout(i)];
                bestPoints = points;
            end
        end
    end
end

