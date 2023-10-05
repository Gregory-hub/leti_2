clear, clc, clf

a = -2;
b = 2;
dx = 0.01;
X = a : dx : b;
Y = f4(X);

plot(X, Y, 'b');
m = max(Y);
axis([a - 1, b + 1, -m(1) * 1.5, m(1) * 1.5]);
grid on;
hold on;

% discretization and quantization
frequency = 3;
dx = 1 / frequency;
Xd = a : dx : b;
Yd = f4(Xd);

q = quantizer("fixed", "fix", "saturate", [4, 1]); % 4 bits
Yd = quantize(q, Yd);

stem(Xd, Yd, 'r');
legend("analog", "digital");
