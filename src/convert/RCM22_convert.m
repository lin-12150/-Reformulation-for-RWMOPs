function origin_result = RCM22_convert(x)

x1 = x(:,1); x3 = x(:,2);
x4 = x(:,3); x5 = x(:,4); x6 = x(:,5);
x8 = x(:,6); x9 = x(:,7);

x2 = x6 + x8; 
x7 = x1 - x5;

% Objective function
f(:,1) = -9*x1-15*x2+6*x3+16*x4;
f(:,2) = 10.*(x5+x6);
% Constraints
g(:,1) = x9.*x7+2*x5-2.5*x1;
g(:,2) = x9.*x8+2*x6-1.5*x2;

h(:,1) = x7+x8-x4-x3;
h(:,2) = x9.*x7+x9.*x8-3.*x3-x4;
h(:,3) = x1-x5-x7;
h(:,4) = x2-x6-x8;

g = [g,abs(h)-1e-4];

x_origin = [x1,x2,x3,x4,x5,x6,x7,x8,x9];
origin_result = {x_origin,f,h};
end
