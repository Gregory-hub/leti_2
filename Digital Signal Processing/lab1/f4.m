function [y] = f4(x)
y = zeros(length(x));
for i = 1 : length(x)
    el = x(i) - floor(x(i));
    if 0 <= el && el < 1 / 3
        y(i) = -1;
    elseif 1 / 3 <= el && el < 2 / 3
        y(i) = 0;
    elseif 2 / 3 <= el && el < 1
        y(i) = 1;
    end
end
