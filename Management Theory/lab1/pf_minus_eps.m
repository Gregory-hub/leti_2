clear, clc

k = 8;
T = 4;

eps = -0.5;
w = tf(k,[T^2, 2 * eps * T, 1]);
ltiview(w);
