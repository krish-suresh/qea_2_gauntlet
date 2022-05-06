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
maxNodes = 200;
maxDist = 0.3;
searchRadius = 0.4;

[reached, pathToGoal, G] = rrtStar(map,start,goal,goalThresh,maxNodes,maxDist,searchRadius);

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


for i=1:size(pathToGoal,1)-1
    n1 = pathToGoal(i,:);
    n2 = pathToGoal(i+1,:);
    plot([n1(1), n2(1)], [n1(2), n2(2)], 'r-o');
end
title("RRT*")
axis padded
hold off