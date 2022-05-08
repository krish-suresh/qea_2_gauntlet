map = gauntletMap();
map_original = map;
inflate(map, 0.15)

start = [0,0];
goal = [0.75,-2.5];
goalThresh = 0.4;
maxNodes = 200;
maxDist = 0.5;
searchRadius = 0.4;

[reached, pathToGoal, G] = rrtStar(map,start,goal,goalThresh,maxNodes,maxDist,searchRadius, false);
