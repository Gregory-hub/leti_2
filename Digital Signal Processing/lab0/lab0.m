clear, clc, clf

% function object (f1 to f4)
f = f1;

% frequency (1, 2, 4 or 8)
frequency = 4; % Hz

a = 0;
b = 10;

dx = 0.01;
X = a : dx : b;
Y = arrayfun(@(x) f.execute(x), X);

subplot(2, 1, 1);
plot(X, Y, 'b');
title('f(x) original');
m = max(Y);
axis([a - 1, b + 1, -m(1) * 1.5, m(1) * 1.5]);
grid on;

% discretization and quantization
dx = 1 / frequency;
Xd = a : dx : b;
Yd = arrayfun(@(x) f.execute(x), Xd);

q = quantizer("fixed", "fix", "saturate", [4, 1]); % 4 bits, one bit after dot
Yd = quantize(q, Yd);

figure(1);
subplot(2, 1, 2);
stem(Xd, Yd, 'r');
title('f(x) quantized');
m = max(Y);
axis([a - 1, b + 1, -m(1) * 1.5, m(1) * 1.5]);
grid on;

fsq = f.symbolic()^2;
E = double(int(fsq, a, b));
P = E / f.T;
fprintf("Sygnal enegry: %f\n", E);
fprintf("Sygnal power: %f\n", P);

P_i = double(fsq(X));

figure(2);
subplot(1, 1, 1);

plot(X, P_i);
m = max(P_i);
axis([a - 1, b + 1, -m(1) * 0.5, m(1) * 1.5]);
grid on;
title('Instantaneous power');
