clear, clc, clf

filename = "square.log";
fileID = fopen(filename, 'r');
formatSpec = '%f';
y = fscanf(fileID, formatSpec);
y = 5 / 1024 * y;

fd = 100;
Ts = 1 / fd;

x = (0:length(y) - 1) * fd / length(y);

figure(1);
plot(x, y, 'b');
m = max(y);
axis([-x(length(x)) * 0.05, x(length(x)) * 1.05, -m(1) * 0.5, m(1) * 1.5]);
grid on;
title("f(x)");

% fft and spectrums
ft = fftshift(fft(y));
xft = (-length(ft) / 2 : length(ft) / 2 - 1) * fd / length(ft);

amp = abs(ft);
amp(length(amp) / 2 - 1:length(amp) / 2 + 1) = 0;

figure(2);
subplot(2, 1, 1);
plot(xft, amp, 'r');
m = max(amp);
axis([-xft(length(xft)) * 1.2, xft(length(xft)) * 1.2, -m(1) * 0.8, m(1) * 1.5]);
grid on;
title("Frequency spectrum");
xlabel('Frequency (Hz)');
ylabel('Magnitude');

ft2 = ft;
threshold = max(abs(ft)) * 10e-2;
ft2(abs(ft2) < threshold) = 0;
phase = angle(ft2) * 180 / pi;

subplot(2, 1, 2);
plot(xft, phase);
m = max(phase);
axis([-xft(length(xft)) * 1.2, xft(length(xft)) * 1.2, -m(1) * 1.5, m(1) * 1.5]);
grid on;
title("Phase spectrum");
xlabel('Frequency (Hz)');
ylabel('Phase');
