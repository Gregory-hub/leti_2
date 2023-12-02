clear, clc

k = 90;

W1 = tf(k, [1, 0]);
W2 = tf(1);

Wp = W1 * W2;
F = W1 / (1 + Wp);

ltiview(F);
