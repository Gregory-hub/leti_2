classdef f4
    properties
        T = inf;
    end
    methods
        function [y] = execute(~, x)
            el = x - floor(x);
            if 0 <= el && el < 1 / 3
                y = -1;
            elseif 1 / 3 <= el && el < 2 / 3
                y = 0;
            elseif 2 / 3 <= el && el < 1
                y = 1;
            end
        end

        function y = symbolic(~)
            syms y(x);
            syms g(x);
            g(x) = x - floor(x);
            y(x) = piecewise(0 <= g(x) & g(x) < 1 / 3, -1, 1 / 3 <= g(x) & g(x) < 2 / 3, 0, 2 / 3 <= g(x) & g(x) < 1, 1, 0);
        end 
    end
end
