classdef f1
    properties
        T = 1;
    end
    methods
        function y = execute(~, x)
            y = sin(2 * pi * x);
        end
        
        function y = symbolic(~)
            syms y(x);
            y(x) = sin(2 * pi * x);
        end
    end
end
