clear, clc, clear sound

step_size_lms = 0.1; % 0 - 2
forgetting_factor_rls = 0.99; % 0 - 2
order = 32; % Порядок фильтра (сколько предыдущих значений берется)

filename_desired = 'input.wav';
filename_noised = 'input_noise.wav';

desired_signal = audioread(filename_desired);
[noise_signal, Fs] = audioread(filename_noised);

[output_signal_lms, error_lms] = lmsFilter(desired_signal, noise_signal, order, step_size_lms);
[output_signal_rls, error_rls] = rlsFilter(desired_signal, noise_signal, order, forgetting_factor_rls);

time = 0 : seconds(1/Fs) : seconds((size(noise_signal, 1) - 1) / Fs);

figure('Name', 'LMS');
subplot(4, 1, 1);
plot(time, desired_signal);
title('Desired signal');
grid on
subplot(4, 1, 2);
plot(time, noise_signal);
title('Input with noise');
grid on
subplot(4, 1, 3);
plot(time, output_signal_lms);
title('Output signal after LMS filter');
grid on
subplot(4, 1, 4);
plot(time, error_lms);
title('Error');
grid on

time_help = 76300:76350;

figure('Name', 'LMS');
plot(time_help, [desired_signal(time_help, 1), noise_signal(time_help, 1), output_signal_lms(time_help, 1), error_lms(time_help, 1)])
grid on
title('LMS')
legend('Desired', 'Input with noise', 'Output', 'Error')
xlabel('Time')
ylabel('Signal value')

figure('Name', 'RLS');
subplot(4, 1, 1);
plot(time, desired_signal);
title('Desired signal');
grid on
subplot(4, 1, 2);
plot(time, noise_signal);
title('Input with noise');
grid on
subplot(4, 1, 3);
plot(time, output_signal_rls);
title('Output signal after RLS filter');
grid on
subplot(4, 1, 4);
plot(time, error_rls);
title('Error');
grid on

figure('Name', 'RLS');
plot(time_help, [desired_signal(time_help, 1), noise_signal(time_help, 1), output_signal_rls(time_help, 1), error_rls(time_help, 1)])
grid on
title('RLS')
legend('Desired', 'Input with noise', 'Output', 'Error')
xlabel('Time')
ylabel('Signal value')

figure;
subplot(3, 1, 1);
plot(time, desired_signal);
title('Desired signal');
grid on
subplot(3, 1, 2);
plot(time, output_signal_lms);
title('LMS');
grid on
subplot(3, 1, 3);
plot(time, output_signal_rls);
title('RLS');
grid on

figure
subplot(2, 1, 1);
plot(time, error_lms);
title('LMS Error');
grid on
subplot(2, 1, 2);
plot(time, error_rls);
title('RLS Error');
grid on

figure('Name', 'LMS/RLS');
plot(time_help, [desired_signal(time_help, 1), output_signal_lms(time_help, 1), output_signal_rls(time_help, 1), error_lms(time_help, 1), error_rls(time_help, 1)])
grid on
title('LMS/RLS')
legend('Desired', 'Output LMS', 'Output RLS', 'Error LMS', 'Error RLS')
xlabel('Time')
ylabel('Signal value')
