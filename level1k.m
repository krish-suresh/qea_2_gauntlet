x_range = linspace(-2,3, 500);
y_range = linspace(-4,1.5, 500);

[X,Y]=meshgrid(x_range,y_range);
f = X.*0;
corners = [-1.5, -3.37;
2.5, -3.37;
2.5, 1;
-1.5, 1;];
for i=1:4
    f = addLine(f,x_range,y_range,[corners(i,:);corners((mod(i,4)+1),:)],50, 20);
end

objects = [-0.25, -1;1,-0.7;1.41,-2];
for i=1:size(objects,1)
    f = addSource(f,x_range,y_range,objects(i,:), 0.3);
end

for i=1:size(corners,1)
    f = addSource(f,x_range,y_range,corners(i,:), 1);
end

f = addSink(f,x_range,y_range,[0.75,-2.5], 5);

[px,py] = gradient(f);


contour(X,Y,f, 100); hold on

plot(0,0,'b*');
tol = 0.01;
n = 0;
n_max = 60;
r = [0;0];
lambda = 0.03;
delta = 1.1;
while n<n_max 
    [~,x_idx]=min(abs(x_range-r(1)));
    [~,y_idx]=min(abs(y_range-r(2)));
    grad = -[px(y_idx,x_idx);py(y_idx,x_idx)];
    r = r + lambda*grad;
    plot(r(1),r(2),'r*');
    lambda = lambda*delta;
    n = n+1;
end
