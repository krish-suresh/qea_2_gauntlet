rosinitIfNotActive();
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
%contour(x1,y1,subs(f,[x,y],{x1,y1}),50)
quiver(X2,Y2,gx,gy)
axis equal


% define obsticles and walls as lines
% define goal as point



