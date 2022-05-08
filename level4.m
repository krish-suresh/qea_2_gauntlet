rosinitIfNotActive

map = gauntletMap();
map_original = map;

inflate(map, 0.17)

start = [0,0];
goal = [0.75,-2.5];
goalThresh = 0.4;
maxNodes = 100;
maxDist = 0.3;
searchRadius = 0.4;
% [reached, pathToGoal, G] = rrt(map,start,goal,goalThresh,maxNodes,maxDist);
[reached, pathToGoal, G] = rrtStar(map,start,goal,goalThresh,maxNodes,maxDist,searchRadius);

raw_val = rospublisher("raw_vel");
encoders = rossubscriber("encoders");
controller = controllerPurePursuit;
stopRobot(raw_val);
placeNeato(0,0,1,0);
controller.Waypoints = pathToGoal;
controller.MaxAngularVelocity = 1;
controller.LookaheadDistance = 0.4;
controller.DesiredLinearVelocity = 0.2;

pose = [0,0,0];
t_prev = 0;
d = 0.235;
enc_last = readEncoders(encoders);
t = 0;
max_t = 20;

if true
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

end

pause(1);

rostic;
while abs(pdist([pose(1:2); goal], "euclidean")) > goalThresh
    t = rostoc();
    if t > max_t
        break;
    end
    [v,w] = controller(pose);
    t_delta = t-t_prev;
    enc_current = readEncoders(encoders);
    enc_delta = enc_current - enc_last;
    pose = updateOdometry(pose, enc_delta, t_delta);
    vL = v - d/2*w;
    vR = v + d/2*w;
    setWheelVel(raw_val, vL, vR);
    enc_last = enc_current;
    t_prev = t;
end
stopRobot(raw_val)