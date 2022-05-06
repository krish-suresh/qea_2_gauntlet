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
maxNodes = 100;
maxDist = 0.3;
searchRadius = 0.1;
G = digraph();
G = addnode(G,mat2str(start));
bestDistToGoal = inf;
bestEnd = start;
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
    G = addedge(G,mat2str(newNode),mat2str(nearestNode)); % TODO add search radius check
    distToGoal = pdist([newNode;goal],'euclidean');
    if bestDistToGoal > distToGoal
        bestEnd = newNode;
        bestDistToGoal = distToGoal;
    end
    if distToGoal < goalThresh
        break;
    end
end
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


P = shortestpath(G,mat2str(bestEnd),mat2str(start));
waypoints = bestEnd;
for i=1:length(P)-1
    n1 = eval(cell2mat(P(i)));
    n2 = eval(cell2mat(P(i+1)));
    waypoints = [waypoints;n2];
    plot([n1(1), n2(1)], [n1(2), n2(2)], 'r-o');
end

axis padded
