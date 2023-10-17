clear, clc

k = 8;
T = 4;

% for eps = -1 : 0.02 : 1
%     hold on;
%     grid on;
%     w = tf(k,[T^2, 2 * eps * T, 1]);
%     pzmap(w);
% end

eps = 0.7;
w = tf(k,[T^2, 2 * eps * T, 1]);
pzmap(w);
