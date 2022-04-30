function [bestInlierSet,bestOutlierSet,bestEndPoints, hasLine] = ransacLine(points,lineTol, lineIterations, lineMaxGap, lineMinLen)    
    bestcandidates = [];
    bestInlierSet = zeros(0,2);
    bestOutlierSet = zeros(0,2);
    bestEndPoints = zeros(0,2);
    hasLine = false;
    if size(points, 1) == 0
        return;
    end
    for k=1:lineIterations
        while true
            candidates = datasample(points, 2, 'Replace', true);
            v=(candidates(1,:)-candidates(2,:))';
            if norm(v) > 0.05 && norm(v) < 1
                break;
            end
        end
        orthv= [-v(2); v(1)];
        orthv_unit=orthv/norm(orthv);
        diffs = points - candidates(2,:);
        orthdists=diffs*orthv_unit;
        inliers=abs(orthdists) < lineTol;
        biggestGap = max(diff(sort(diffs(inliers,:)*v/norm(v))));
        projectedCoordinate = diffs(inliers, :)*v/norm(v);
        endPoints = [min(projectedCoordinate); max(projectedCoordinate)]*v'/norm(v) + repmat(candidates(2, :), [2, 1]);
        if biggestGap < lineMaxGap  && sum(inliers) > size(bestInlierSet,1) && pdist(endPoints,'euclidean') > lineMinLen
    
            bestInlierSet=points(inliers,:);
            bestOutlierSet = points(~inliers, :); 
            bestcandidates=candidates;
    
            bestEndPoints = endPoints;
        end
    end
    
    hasLine = true;
    if isempty(bestEndPoints)
        hasLine = false;
        bestEndPoints=[NaN,NaN;NaN,NaN];
    end    
end

