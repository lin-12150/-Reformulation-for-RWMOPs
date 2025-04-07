clc;clear;close all;

% NSGAII
algorithms = ["CCMO","NSGAII","PPS"];
num = 30:35;
convert = ["RCM30_convert","RCM31_convert","RCM32_convert","RCM33_convert","RCM34_convert","RCM35_convert"];
for p = 1:6
    for a = 1:3
        algorithm = algorithms(a);
        for i = 1:21
            if p < 4
            path1 = "Data\"+algorithm+"\"+algorithm+"_RWMOP"+num(p)+"_re1_M2_D26_"+i+".mat";
            else
            path1 = "Data\"+algorithm+"\"+algorithm+"_RWMOP"+num(p)+"_re1_M2_D31_"+i+".mat";
            end
%             path1 = "Data\"+algorithm+"\"+algorithm+"_RWMOP"+num(3)+"_re1_M2_D25_"+i+".mat";
            load(path1);
            % 对每个文件进行修改
            for j = 1:20
                population = result{j,2};
                for m = 1:120
                    p1 = population(1,m);
                    re_x = p1.dec;
                    obj = p1.obj;
                    out = feval(convert(p), re_x);
                    result{j,2}(1,m) = SOLUTION(out{1},obj,out{3});
                end
            end
            metric = rmfield(metric, 'Feasible_rate');
%             metric = rmfield(metric, 'HV');
            save(path1, 'metric',"result");
        end
    end
end


% for i = 1:21
%     path1 = "Data\"+algorithm+"\"+algorithm+"_RWMOP"+p+"_re_M2_D25_"+i+".mat";
%     load(path1);
%     % 对每个文件进行修改
%     for j = 1:20
%         population = result{j,2};
%         for m = 1:120
%             p1 = population(1,m);
%             re_x = p1.dec;
%             obj = p1.obj;
%             con = zeros(1,size(re_x,2)-1);
%             for i = 1:size(re_x,2)-1
%                 con(i) = re_x(i)-re_x(i+1)+1e-6;
%             end
%             result{j,2}(1,m) = SOLUTION(re_x,obj,con);
%         end
%     end
%     save(path1, 'metric',"result");
% end

