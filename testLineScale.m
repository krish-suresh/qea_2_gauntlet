x_range = linspace(-2,3, 100);
y_range = linspace(-4,1.5, 100);

[X,Y]=meshgrid(x_range,y_range);
f = X.*0;
corners = [-1.5, -3.37;
2.5, -3.37;
2.5, 1;
-1.5, 1;];
for i=1:4
    f = addLineFlat(f,x_range,y_range,[corners(i,:);corners((mod(i,4)+1),:)], 50, 1);
end



% figure(1); %#ok<UNRCH> 
% contour(X,Y,f, 100); hold on
% plot(0,0,'b*');
% plot(M(:,1),M(:,2),'g*')
% plot(M_discrete(:,1),M_discrete(:,2),'r*')
% hold off
% 
% figure(2);
h = surf(X,Y,f);
set(h,'LineStyle','none')
