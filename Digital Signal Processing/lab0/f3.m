classdef f3
    properties
        T = inf;
    end
    methods
        function [y] = execute(~, x)
            y = exp(-x);
        end

        function y = symbolic(~)
            syms y(x);
            y(x) = exp(-x);
        end
    end
end
