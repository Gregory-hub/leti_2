classdef f2
    properties
        T = inf;
    end
    methods
        function [y] = execute(~, x)
            if 0 <= x && x <= 1
                y = 1;
            else 
                y = 0;
            end
        end

        function y = symbolic(~)
            syms y(x);
            y(x) = piecewise(x < 0, 0, x >= 0 & x <= 1, 1, x > 1, 0);
        end
    end
end
