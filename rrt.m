function [reachedGoal,pathToGoal, G] = rrt(map,start,goal,goalThresh,maxNodes,maxDist)
    G = digraph();
    G = addnode(G,mat2str(start));
    bestDistToGoal = inf;
    bestEnd = start;
    reachedGoal = false;
    for n=1:maxNodes
        randomNode = [randWithinRange(map.XWorldLimits), randWithinRange(map.YWorldLimits)];
        nearestNode = start;
        minDist = inf;
        for i=1:height(G.Nodes)
            node = eval(cell2mat(G.Nodes{i,1}));
            dist = pdist([randomNode;node],'euclidean');
            if minDist > dist
                nearestNode = node;
                minDist = dist;
            end
        end
        ray = (randomNode - nearestNode);
        len = norm(ray);
        if len > maxDist
         ray = maxDist.*ray./len;
        end
        newNode = nearestNode + ray;
        if ~isnan(rayIntersection(map,[nearestNode,0],atan2(ray(2),ray(1)),maxDist))
            continue;
        end
        G = addnode(G,mat2str(newNode));
        G = addedge(G,mat2str(nearestNode),mat2str(newNode));
        distToGoal = pdist([newNode;goal],'euclidean');
        if bestDistToGoal > distToGoal
            bestEnd = newNode;
            bestDistToGoal = distToGoal;
        end
        if distToGoal < goalThresh
            reachedGoal = true;
%             break;
        end
    end

    P = shortestpath(G,mat2str(start),mat2str(bestEnd));
    pathToGoal = start;
    for i=1:length(P)-1
        n1 = eval(cell2mat(P(i)));
        n2 = eval(cell2mat(P(i+1)));
        pathToGoal = [pathToGoal;n2];
    end
end

