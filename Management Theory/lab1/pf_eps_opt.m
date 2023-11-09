clear, clc

eps = 0.7;

k = 8;
T = 4;

w = tf(k,[T^2, 2 * eps * T, 1]);
ltiview(w);
