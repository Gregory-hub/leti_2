clear, clc, clear sound

desired_signal = audioread('polskaya-korova.wav');
[noise_signal_in, Fs] = audioread('noise_polskaya-korova.wav');

order = 32; % Порядок фильтра (сколько предыдущих значений берется)
step_size = 0.1; % Шаг обучения (изменение весов при каждой итерации)

output_signal = zeros(size(noise_signal_in));
error = zeros(size(noise_signal_in));

for i = 1 : size(noise_signal_in, 2)
    noise_signal = noise_signal_in(:, i);
    %LMS
    weights = zeros(order, 1); % Веса фильтра
    for n = order : length(noise_signal)
        noise_signal_n = noise_signal(n : -1 : n-order+1); % Входной вектор
        output_signal(n, i) = weights.' * noise_signal_n; % Вычисление выходного сигнала
        error(n, i) = desired_signal(n, i) - output_signal(n, i); % Вычисление ошибки
        weights = weights + step_size * error(n, i) * conj(noise_signal_n); % Обновление коэффициентов фильтра
    end
end

sound(output_signal, Fs);

time = 1 : 1 : size(desired_signal);

subplot(4, 1, 1);
plot(time, desired_signal);
title('Desired signal');
grid on
subplot(4, 1, 2);
plot(time, noise_signal);
title('Noise signal');
grid on
subplot(4, 1, 3);
plot(time, output_signal);
title('Output signal after LMS filter');
grid on
subplot(4, 1, 4);
plot(time, error);
title('Error');
grid on

audiowrite('output_lms.wav', output_signal, Fs);
