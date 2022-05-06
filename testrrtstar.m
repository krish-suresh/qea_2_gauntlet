mapData = ones(408,445);

image = imread('occupancymap.png');
grayimage = rgb2gray(image);
bwimage = grayimage < 0.5;

mapData(5:end-4,5:end-4) = bwimage;

map = binaryOccupancyMap(mapData,'Resolution',100);
map_original = binaryOccupancyMap(mapData,'Resolution',100);
inflate(map, 0.1)

start = [4,3];
goal = [1.5,2];
goalThresh = 0.2;
maxNodes = 300;
maxDist = 0.2;
searchRadius = 0.3;
cost = containers.Map('KeyType','char','ValueType','double');
G = digraph();
G = addnode(G,mat2str(start));
cost(mat2str(start)) = 0;
bestDistToGoal = inf;
bestEnd = start;
for n=1:maxNodes
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
    if bestDistToGoal > distToGoal
        bestEnd = newNode;
        bestDistToGoal = distToGoal;
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
figure(1);
clf
hold on;
show(map_original);
plot(start(1),start(2),"r*");
plot(goal(1),goal(2),"g*");

for i=1:height(G.Edges)
    edge = G.Edges{i,1};
    n1 = eval(cell2mat(edge(1)));
    n2 = eval(cell2mat(edge(2)));
    plot([n1(1), n2(1)], [n1(2), n2(2)], 'b-o');
end


P = shortestpath(G,mat2str(start),mat2str(bestEnd));
waypoints = start;
for i=1:length(P)-1
    n1 = eval(cell2mat(P(i)));
    n2 = eval(cell2mat(P(i+1)));
    waypoints = [waypoints;n2];
    plot([n1(1), n2(1)], [n1(2), n2(2)], 'r-o');
end

axis padded