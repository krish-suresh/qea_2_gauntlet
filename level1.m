%rosinitIfNotActive();
% figure;
% [x,y]=meshgrid(-5:0.3:5,-5:0.3:5);
% v = 1.3 .* log(sqrt((x-1.41).^2+(y+2).^2)) + 1.3 .* log(sqrt((x+.25).^2+(y+1).^2)) + 1.3 .* log(sqrt((x-1).^2+(y+.7).^2)) - 3 .* log(sqrt((x-.75).^2+(y+2.5).^2));
% contour(x,y,v,'k','ShowText','On')
% %surf(x,y,v)
% axis equal
% g = gradient(v,[x,y]);
% figure;
% [x,y]=meshgrid(-3:0.05:3,-3:0.05:3);
% fx = (x-1.41)./((x-1.41).^2+(y+2).^2) - (x+.25)./((x+.25).^2+(y+1).^2) - (x-1)./((x-1).^2+(y+.7).^2) + (x-.75)./((x-.75).^2+(y+2.5).^2);
% fy = (x-1.41)./((x-1.41).^2+(y+2).^2) - (x+.25)./((x+.25).^2+(y+1).^2) - (x-1)./((x-1).^2+(y+.7).^2) + (x-.75)./((x-.75).^2+(y+2.5).^2);
% quiver(x,y,fx,fy)
% axis equal


figure;
[x1,y1]=meshgrid(-1.5:0.05:2.5,-3.5:0.05:0.5);
[X2,Y2] = meshgrid(-1.5:0.5:2.5,-3.5:0.5:0.5);
% v = log(sqrt(x.^2+y.^2)) - log(sqrt((x-1).^2+(y-2).^2));
% %contour(x,y,v,'k','ShowText','On')
% surf(x,y,v)
% axis equal
syms x y
sink1 = log(sqrt((x-1.41).^2+(y+2).^2));
sink2 = log(sqrt((x-1).^2+(y+0.7).^2));
sink3 = log(sqrt((x+0.25).^2+(y+1).^2));
source = log(sqrt((x-0.75).^2+(y+2.5).^2));
f = 1.3*sink1 + 1.3*sink2 + 1.3*sink3 - 3*source;
%contour(x,y,f,'k','ShowText','On')
axis equal
% Find the gradient of the function
g = gradient(f,[x,y]);
gx = subs(g(1), [x,y],{X2,Y2});
gy = subs(g(2), [x,y],{X2,Y2});
figure;
contour(x1,y1,subs(f,[x,y],{x1,y1}),50)
figure;
quiver(X2,Y2,gx,gy)
axis equal


%% discrete points for lines
figure;
[x,y]=meshgrid(-3:0.05:3,-3:0.05:3);
%first box
v = 0;
a = 1.16;
for b = -2.25:0.01:-1.75
v = v - log(sqrt((x-a).^2 + (y-b).^2));
end
c = 1.66;
for d = -2.25:0.01:-1.75
v = v - log(sqrt((x-c).^2 + (y-d).^2));
end
e = -2.25;
for f = 1.16:0.01:1.66
v = v - log(sqrt((x-f).^2 + (y-e).^2));
end
g = -1.75;
for h = 1.16:0.01:1.66
v = v - log(sqrt((x-h).^2 + (y-g).^2));
end
source1 = .08 .* v;

%second box
[x,y]=meshgrid(-3:0.05:3,-3:0.05:3);
for aa = -.6035533906:0.01:-.25
    for bb = -1:0.01:-.6464466094
    v = v - log(sqrt((x-aa).^2 + (y-bb).^2));
    end
end
for cc = -.25:0.01:.1035533906
    for dd = -1.353553391:0.01:-1
    v = v - log(sqrt((x-cc).^2 + (y-dd).^2));
    end
end
for ee = -.6035533906:0.01:-.25
    for ff = -1:0.01:-1.353553391
    v = v - log(sqrt((x-ee).^2 + (y-ff).^2));
    end
end
for gg = -.25:0.01:.1035533906
    for hh = -.6464466094:0.01:-1
    v = v - log(sqrt((x-gg).^2 + (y-hh).^2));
    end
end
source2 = .006 .* v;
% %contour(x,y,f,'k','ShowText','On')
% figure;
% surf(x,y,k)
% axis equal

% third box
v = 0;
for aaa = .6464466094:0.01:1
    for bbb = -.7:0.01:-.3464466094
    v = v - log(sqrt((x-aaa).^2 + (y-bbb).^2));
    end
end
for ccc = 1:0.01:1.353553391
    for ddd = -1.053553391:0.01:-.7
    v = v - log(sqrt((x-ccc).^2 + (y-ddd).^2));
    end
end
for eee = .6464466094:0.01:1
    for fff = -.7:0.01:-1.053553391
    v = v - log(sqrt((x-eee).^2 + (y-fff).^2));
    end
end
for ggg = 1:0.01:1.353553391
    for hhh = -.3464466094:0.01:-.7
    v = v - log(sqrt((x-ggg).^2 + (y-hhh).^2));
    end
end
source3 = .006 .* v;
k = source1 + source2 + source3;
k = .03 .* k;
%contour(x,y,v,'k','ShowText','On')
figure;
surf(x,y,k)
axis equal


% define obsticles and walls as lines
% define goal as point



