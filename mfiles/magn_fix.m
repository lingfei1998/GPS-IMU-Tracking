%focus on loop data
for i = 1:4000
    magx(1,i)=magn_x(1,i);
    magy(1,i)=magn_y(1,i);
end

%calculate magx and magy offsets
xoffset = (max(magx)+min(magx))/2;
yoffset = (max(magy)+min(magy))/2;

xm1 = magx-xoffset; % magn_x hard iron modified
ym1 = magy-yoffset; % magn_y hard iron modified

%take a look at modified data
figure(1)
scatter(xm1,ym1,1)
xlabel('mag_x')
ylabel('mag_y')
title('loop mag scatter')

%ellipse fit of modified data
figure(2)
xdata = xm1' ;
ydata = ym1' ;
XY( : ,1)=xdata;
XY( : ,2)=ydata;
AA=EllipseDirectFit(XY);
syms x y A B C D E F 
% f =A* x.^2+B* x.*y+C* y.^2+D*x+ Ey+F;
f =A* x^2+B* x*y+C* y^2+D*x+ E*y+F;
f = subs( f , [ A B C D E F] , AA' );
f = simplify(f);
clf , ezplot(f,[-1 1 -1 1])
ezplot(f,[-1 1 -1 1])
title('mag-hard-iron-correction')
xlabel('mx')
ylabel('my')

%deal with soft iron
alpha = max(ym1)/max(xm1);
xm2 = xm1/alpha;
ym2 = ym1/alpha;
%let's take a look at it
figure(3)
scatter(xm2,ym2,1)
xlabel('mag_x')
ylabel('mag_y')
title('mag after h and s correction')

% figure(4)
% goodx = (magn_x-xoffset)/alpha;
% goody = (magn_y-yoffset)/alpha;
% plot(ts,atan(unwrap(goody)./unwrap(goodx)))