clear, clc

% k_cr = 0.8681;
k_cr = 1.5;
k = k_cr * 0.8;

W0 = tf(1, [1, 0]);
W1 = tf(1, [1 1]);
W2 = tf(1, [2 1]);

Wp = k * W0 * W1 * W2;
W = Wp / (1 + Wp);

ltiview(W);
