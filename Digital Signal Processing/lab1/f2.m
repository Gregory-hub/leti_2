function [y] = f2(x)
y = zeros(length(x));
for i = 1 : length(x)
    if 0 <= x(i) && x(i) <= 1
        y(i) = 1;
    else 
        y(i) = 0;
    end
end
