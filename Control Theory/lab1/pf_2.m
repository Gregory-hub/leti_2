clear, clc

k = 8;
T = 4;

a = 0;
b = 45;
dx = 0.05;

eps = 0.5;
w = tf(k,[T^2, 2 * eps * T, 1]);
step(w);
hold on;

eps = 0.6;
w = tf(k,[T^2, 2 * eps * T, 1]);
step(w);

eps = 0.7;
w = tf(k,[T^2, 2 * eps * T, 1]);
step(w);

eps = 0.8;
w = tf(k,[T^2, 2 * eps * T, 1]);
step(w);

eps = 0.9;
w = tf(k,[T^2, 2 * eps * T, 1]);
step(w);

eps = 1;
w = tf(k,[T^2, 2 * eps * T, 1]);
step(w);

legend("0.5", "0.6", "0.7", "0.8", "0.9", "1.0")
grid on;
