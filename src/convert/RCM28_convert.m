function origin_result = RCM28_convert(x)

x1 = x(:,1);
x2 = x(:,2);
v1 = x(:,3);
v2 = x(:,4);
y1 = round(x(:,5));
y2 = 1-y1;
x_ = x1+x2;
z1 = 0.9*(1-exp(-0.5.*v1)).*x1;
z2 = 0.8*(1-exp(-0.4*v2)).*x2;
% Objective function
f(:,1) = 7.5.*y1 + 5.5.*y2 + 7.*v1 + 6.*v2 + 5.*x_;
f(:,2) = x1 + x2;
% Constraints
h(:,1) = y1 + y2 - 1;
h(:,2) = z1 + z2 - 10;
h(:,3) = x1 + x2 -x_;
h(:,4) = z1.*y1 + z2.*y2 - 10;
g(:,1) = v1 - 10*y1 -1e-6;
g(:,2) = v2 - 10*y2;
g(:,3) = x1 - 20*y1;
g(:,4) = x2 - 20*y2;
g      = [g,abs(h)-1e-4];
g = [g,abs(h)-1e-4];

x_origin = [x1,x2,v1,v2,y1,y2];
origin_result = {x_origin,f,h};
end
