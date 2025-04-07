function origin_result = RCM30_convert(x)
m = 0.32;
s = (-ones(1,25)).^(2:26);
k = [5,7,11,13,17,19,23,25,29,31,35,37,41,43,47,49,53,55,59,61,65,67,71,73,77,79,83,85,91,95,97];


y = cumsum(x(:,2:end), 2);
aa = x(:,1)./y(:,end);
x_new = fix(aa.*1e6)./1e6 .* x(:,2:end);
x_new(:,2:end) = max(x_new(:,2:end),1e-5);
y = cumsum(x_new, 2);

% Objective function
for i = 1 : size(y,1)
    su = 0;
    for j = 1 : 31
        su2 = 0;
        for l = 1 : size(y,2)
            su2 = su2 + s(l).*cos(k(j).*y(i,l)*pi/180);
        end
        su = su + su2.^2./k(j).^4;
    end
    f(i,1) = (su).^0.5./(sum(1./k.^4)).^0.5;
end
f(:,2) = (sum(s.*cos(y*pi/180),2)-m).^2;

% Constraints
for i = 1 : size(y,2)-1
    g(:,i) = y(:,i)-y(:,i+1)+1e-6;
end

x_origin = y;
origin_result = {x_origin,f,g};
end
