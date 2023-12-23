clear, clc
input_signal = audioread('input.wav');
[noise_signal, Fs] = audioread('input_noise.wav');

order_lms = 32; % Порядок фильтра (сколько предыдущих значений берется)
step_size_lms = 0.1; % Шаг обучения (изменение весов при каждой итерации)

weights_lms = zeros(order_lms, 1); %веса фильтра

%LMS
output_signal_lms = zeros(size(noise_signal));
for n_lms = order_lms:length(noise_signal)
    noise_signal_n_lms = noise_signal(n_lms:-1:n_lms-order_lms+1); % Входной вектор
    output_signal_lms(n_lms) = weights_lms' * noise_signal_n_lms; % Вычисление выходного сигнала
    error_lms(n_lms) = input_signal(n_lms) - output_signal_lms(n_lms); % Вычисление ошибки
    weights_lms = weights_lms + step_size_lms * error_lms(n_lms) * noise_signal_n_lms; % Обновление коэффициентов фильтра
end

%NLMS
order_nlms = 32; % Порядок фильтра (сколько предыдущих значений берется)
step_size_nlms = 0.5; % Шаг обучения (изменение весов при каждой итерации)

weights_nlms = zeros(order_nlms, 1); %веса фильтра

output_signal_nlms = zeros(size(noise_signal));
for n_nlms = order_nlms:length(noise_signal)
    noise_signal_n_nlms = noise_signal(n_nlms:-1:n_nlms-order_nlms+1); % Входной вектор
    output_signal_nlms(n_nlms) = weights_nlms' * noise_signal_n_nlms; % Вычисление выходного сигнала (' - транспонирование вектора)
    error_nlms(n_nlms) = input_signal(n_nlms) - output_signal_nlms(n_nlms); % Вычисление ошибки
    norm_x = norm(noise_signal_n_nlms); % Норма входного вектора
    weights_nlms = weights_nlms + (step_size_nlms / (norm_x^2 + eps)) * error_nlms(n_nlms) * noise_signal_n_nlms; % Обновление коэффициентов фильтра
end

recDuration = 3;
time = 0:seconds(1/Fs):seconds(recDuration);
time = time(1:end-1);

figure;
subplot(3,1,1);
plot(time, [input_signal, output_signal_lms, output_signal_nlms]);
title('Input signal and lms/nlms');
legend('Input','OutputLMS', 'OutputNLMS')
subplot(3,1,2);
plot(time, error_lms);
title('Error LMS');
subplot(3,1,3);
plot(time, error_nlms);
title('Error NLMS');

time_help = 76300:76350;

figure('Name','Comparison LMS and NLMS');
plot(time_help, [input_signal(time_help), output_signal_lms(time_help),output_signal_nlms(time_help)])
title('Comparison LMS and NLMS')
legend('Input','OutputLMS', 'OutputNLMS')
xlabel('Time')
ylabel('Signal value')
