function plotPath(map,start,goal,G,pathToGoal)

figure(1);
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


for i=1:size(pathToGoal,1)-1
    n1 = pathToGoal(i,:);
    n2 = pathToGoal(i+1,:);
    plot([n1(1), n2(1)], [n1(2), n2(2)], 'r-o');
end
title("RRT*")
axis padded
hold off
end

