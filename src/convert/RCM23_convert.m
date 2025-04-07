
function origin_result = RCM23_convert(x)

k1 = 0.09755988; k2 = 0.99*k1;
k3 = 0.0391908; k4 = 0.9*k3;
x2 = x(:,1); x3 = x(:,2);
x4 = x(:,3); x5 = x(:,4); x6 = x(:,5);
x1 = k2.*x6.*x2+x2;

% Objective function
f(:,1) = -x4;
f(:,2) = x5.^(0.5)+x6.^(0.5);
% Constraints
g(:,1) = f(:,2)-4;
g(:,2) = x1-1;
h(:,1) = k1.*x5.*x2 + x1 -1;
h(:,2) = k3.*x5.*x3+x3+x1-1;
h(:,3) = k4.*x6.*x4 + x2-x1+x4-x3;
h(:,4) = k2.*x6.*x2-x1+x2;
g      = [g,abs(h)-1e-4];

x_origin = [x1,x2,x3,x4,x5,x6];
origin_result = {x_origin,f,h};
end




