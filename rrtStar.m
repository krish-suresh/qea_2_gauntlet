function [reachedGoal,pathToGoal, G] = rrtStar(map,start,goal,goalThresh,maxNodes,maxDist, searchRadius)
    tic;
    cost = containers.Map('KeyType','char','ValueType','double');
    G = digraph();
    G = addnode(G,mat2str(start));
    cost(mat2str(start)) = 0;
    bestCostToGoal = inf;
    bestEnd = start;
    reachedGoal = false;
    for n=1:maxNodes
        n
        randomNode = [randWithinRange(map.XWorldLimits), randWithinRange(map.YWorldLimits)];
        nearestNode = start;
        minDist = inf;
        % find nearest node
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
         len = maxDist;
        end
    
        newNode = nearestNode + ray;
        if ~isnan(rayIntersection(map,[nearestNode,0],atan2(ray(2),ray(1)),maxDist))
            continue;
        end
        
        nearNodes = [];
        for i=1:height(G.Nodes)
            node = eval(cell2mat(G.Nodes{i,1}));
            dist = pdist([newNode;node],'euclidean');
            if searchRadius > dist
                nearNodes = [nearNodes;node];
            end
        end
        optimalNode = nearestNode;
        optimalNodeIdx = 1;
        if size(nearNodes, 1) > 1
            % set optimalNode equal to nearNode with min cost
            minCost = inf;
            for j=1:size(nearNodes,1)
                if minCost>cost(mat2str(nearNodes(j,:)))
                    optimalNode = nearNodes(j,:);
                    minCost = cost(mat2str(nearNodes(j,:)));
                    optimalNodeIdx = j;
                end
            end
        end
        G = addnode(G,mat2str(newNode));
        G = addedge(G,mat2str(optimalNode),mat2str(newNode), len);
        cost(mat2str(newNode)) = len + cost(mat2str(optimalNode));
        distToGoal = pdist([newNode;goal],'euclidean');
        if distToGoal < goalThresh
            if bestCostToGoal > cost(mat2str(newNode))
                bestEnd = newNode
                bestCostToGoal = cost(mat2str(newNode));
                reachedGoal = true;
            end
        end
        %rewire other neighbors
        if size(nearNodes, 1) > 1
            nearNodes(optimalNodeIdx,:) = []; % remove connected Node
            for j=1:size(nearNodes,1)
                if cost(mat2str(nearNodes(j,:))) > (cost(mat2str(newNode))+len)
                    newEdgeDist = pdist([newNode;nearNodes(j,:)],'euclidean');                
                    p = predecessors(G,mat2str(nearNodes(j,:)));
                    G = rmedge(G,char(p),mat2str(nearNodes(j,:)));
                    G = addedge(G,mat2str(newNode),mat2str(nearNodes(j,:)),newEdgeDist);
                    cost(mat2str(nearNodes(j,:))) = (cost(mat2str(newNode))+len);
                end
            end
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

