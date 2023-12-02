clear, clc

k = 1;

% Wp = tf([1.8 * k, k], [5.76, 5, 1, 0]);
% W = Wp / (1 + Wp);

% Wp = tf(k, [5.76 0.3125 0]);
% W = Wp / (1 + Wp);

% Misha
W0 = tf(1, [1, 0]);
W1 = tf(1, [1 1]);
W2 = tf(1, [2 1]);
Wp = k * W0 * W1 * W2;
W = Wp / (1 + Wp);

ltiview(W);
