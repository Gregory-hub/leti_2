clear, clc, clf

k = 8;
eps = 0.5;

a = 0;
b = 5;
dx = 0.05;
t = a : dx : b;

Res = zeros(length(t));
ResT = zeros(length(t));
for T = t
    w = tf(k,[T^2, 2 * eps * T, 1]);
    [mag, phase, wout] = bode(w);
    [m, i] = max(mag(1, 1, :));
    Res(int8(T / dx) + 1) = wout(i);
    ResT(int8(T / dx) + 1) = sqrt(1 - 2 * eps^2) / T;
end
Res(1) = Res(2);

subplot(2, 1, 1);
plot(t, Res, 'b');
title("Real");
xlabel("T");
ylabel("frequency");
grid on;

subplot(2, 1, 2);
plot(t, ResT, 'r');
title("Theoretical");
xlabel("T");
ylabel("frequency");
grid on;
