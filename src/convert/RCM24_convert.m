

function origin_result = RCM24_convert(x)

x1 = x(:,1); x2 = x(:,2); x3 = x(:,3);
x4 = x(:,4); x6 = x(:,5);
x5=2000000-x3;
x7=x3/10000+100;
x8=600-x3/10000;
x9=700+x3/10000;
% Objective function
f(:,1) = 35.*x1.^(0.6)+ 35.*x2.^(0.6);
f(:,2) = 200.*x1.*x4-x3;
f(:,3) = 200.*x2.*x6-x5;
% Constraints 
h(:,1) = x4.*log(abs(x8-100)+1e-6)-x4.*log(abs(600-x7)+1e-6)-x8+x7+500;
h(:,2) = x6.*log(abs(x9-x7)+1e-6)-x6.*log(600)-x9+x7+600;
h(:,3) = x3-10000*(x7-100);
h(:,4) = x5-10000*(300-x7);
h(:,5) = x3 -10000*(600-x8);
h(:,6) = x5 - 10000*(900-x9);
g = abs(h)-1e-4;

x_origin = [x1,x2,x3,x4,x5,x6,x7,x8,x9];
origin_result = {x_origin,f,h};
end
