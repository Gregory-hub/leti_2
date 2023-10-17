clear, clc, clf

k = 8;
T = 4;

dx = 0.01;
epsilons = 0 : dx : 1;
Res = zeros(length(epsilons));
ResT = zeros(length(epsilons));
for eps = epsilons
    w = tf(k,[T^2, 2 * eps * T, 1]);
    [mag, phase, wout] = bode(w);
    Res(int8(eps / dx) + 1) = max(mag(1, 1, :));
    ResT(int8(eps / dx) + 1) = k / (2 * eps * sqrt(1 - eps^2));
end
Res(1) = Res(2);

subplot(2, 1, 1);
plot(epsilons, Res, 'b');
title("Real");
xlabel("eps");
ylabel("magnitude");
grid on;

subplot(2, 1, 2);
plot(epsilons, ResT, 'r');
title("Theoretical");
xlabel("eps");
ylabel("magnitude");
grid on;
