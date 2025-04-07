classdef RWMOP24_re < PROBLEM
% <multi> <real> <constrained>
% Heat exchanger network design

%------------------------------- Reference --------------------------------
% A. Kumar, G. Wu, M. Ali, Q. Luo, R. Mallipeddi, P. Suganthan, and S. Das,
% A benchmark-suite of real-world constrained multi-objective optimization
% problems and some baseline results, Swarm and Evolutionary Computation,
% 2021, 67: 100961.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2023 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        %% Initialization
        function Setting(obj)
            obj.M        = 3;
            obj.D        = 5;
            obj.lower    = [0,0,0,0,0];
            obj.upper    = [10,200,100,200,600];
            obj.encoding = ones(1,obj.D);
        end
        %% Evaluate multiple solutions
        function Population = Evaluation(obj,varargin)
            x  = varargin{1};
            x1 = x(:,1); x2 = x(:,2); x3 = x(:,3); x4 = x(:,4); x6 = x(:,5);
            x5=2000000-x3;x7=x3/10000+100;x8=600-x3/10000;x9=700+x3/10000;
            % Objective function
            f(:,1) = 35.*x1.^(0.6)+ 35.*x2.^(0.6);
            f(:,2) = 200.*x1.*x4-x3;
            f(:,3) = 200.*x2.*x6-x5;
            % Constraints 
            h(:,1) = x4.*log(abs(x8-100)+1e-6)-x4.*log(abs(600-x7)+1e-6)-x8+x7+500;
            h(:,2) = x6.*log(abs(x9-x7)+1e-6)-x6.*log(600)-x9+x7+600;
            g      = abs(h)-1e-4;
            Population = SOLUTION(varargin{1},f,g,varargin{2:end});
            obj.FE     = obj.FE + length(Population);
        end
        %% Generate a point for hypervolume calculation
        function R = GetOptimum(obj,~)
            R = [6.6395236e+00  -3.6323008e-05  -1.9999995e+06];
        end
    end
end