clc, clear

T = 12;

w = tf([T, 0], [0.0000000001, 1]);

ltiview(w);
