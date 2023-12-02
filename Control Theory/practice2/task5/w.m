clear, clc

% W0 = tf(1, [1, 0]);
% W1 = tf(1, [2 1]);
% W2 = tf(1, [0.3 1]);
% W3 = tf(1, [0.1 1]);

% Misha
W0 = tf(1, [1, 0]);
W1 = tf(1, [3.5 1]);
W2 = tf(1, [0.6 1]);
W3 = tf(1, [2 1]);

Wp = 30 * W0 * W1 * W2 * W3;
W = Wp / (1 + Wp);

ltiview(Wp)
% ltiview(W)
