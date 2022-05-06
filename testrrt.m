mapData = ones(200,400);

mapData(5:end-4,5:end-4) = 0;

mapData(1:100,150:155) = 1;

map = binaryOccupancyMap(mapData,'Resolution',100);
inflate(map, 0.1)

start = [1,1];
goal = [3,1];
goalThresh = 0.1;
maxNodes = 30;
maxDist = 0.5;
searchRadius = 0.3;
G = graph();
G = addnode(G,mat2str(start));

% TODO randomly sample goal node
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
    if pdist([randomNode;node],'euclidean') < goalThresh
        break;
    end
end

clf
hold on;
show(map);
plot(start(1),start(2),"r*");
plot(goal(1),goal(2),"g*");

for i=1:height(G.Edges)
    edge = G.Edges{i,1};
    n1 = eval(cell2mat(edge(1)));
    n2 = eval(cell2mat(edge(2)));
    plot([n1(1), n2(1)], [n1(2), n2(2)], 'b-o');
end

axis padded
