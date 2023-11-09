clc, clear

k = 30;
T = 12;

w = tf(k, [T, 1]);

ltiview(w);
