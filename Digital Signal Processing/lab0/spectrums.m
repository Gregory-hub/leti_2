clear, clc, clf

fs = 10; % Hz
Ts = 1 / fs;
a = 0;
b = 10;

x = 0 : Ts : b - Ts;
y1 = sin(2 * pi * x);
y2 = sin(2 * pi * x + pi / 4);
y3 = cos(2 * pi * x);

% choose function (y1, y2, y3)
y = y1;

figure(1);
plot(x, y, 'b');
m = max(y);
axis([a - 1, b + 1, -m(1) * 1.5, m(1) * 1.5]);
grid on;
title("f(x)");

% fft and spectres
ft = fft(y);
xft = (0 : length(ft) - 1) * fs / length(ft);

amp = abs(ft);

figure(2);
subplot(2, 1, 1);
plot(xft, amp, 'r');
m = max(amp);
axis([-xft(length(xft)) * 0.1, xft(length(xft)) * 1.1, -m(1) * 0.8, m(1) * 1.5]);
grid on;
title("Frequency spectrum");
xlabel('Frequency (Hz)');
ylabel('Magnitude');

phase = angle(ft);

subplot(2, 1, 2);
plot(xft, phase);
m = max(phase);
axis([-xft(length(xft)) * 0.1, xft(length(xft)) * 1.1, -m(1) * 1.5, m(1) * 1.5]);
grid on;
title("Phase spectrum");
xlabel('Frequency (Hz)');
ylabel('Phase');
