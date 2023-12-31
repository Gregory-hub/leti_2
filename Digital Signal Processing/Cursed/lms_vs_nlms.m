clear, clc, clear sound

step_size_lms = 0.1; % 0 - 2
step_size_nlms = 0.1; % 0 - 2
order = 32; % Порядок фильтра (сколько предыдущих значений берется)

filename_desired = 'input.wav';
filename_noised = 'input_noise.wav';

desired_signal = audioread(filename_desired);
[noise_signal, Fs] = audioread(filename_noised);

% lms = dsp.LMSFilter(order, 'StepSize', step_size_lms);
% nlms = dsp.LMSFilter(order, 'StepSize', step_size_nlms, 'Method', 'Normalized LMS');
% 
% [output_signal_lms, error_lms, weights_out_lms] = lms(noise_signal, desired_signal);
% [output_signal_nlms, error_nlms, weights_out_nlms] = nlms(noise_signal, desired_signal);

[output_signal_lms, error_lms] = lmsFilter(desired_signal, noise_signal, order, step_size_lms);
[output_signal_nlms, error_nlms] = nlmsFilter(desired_signal, noise_signal, order, step_size_nlms);

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

figure('Name', 'NLMS');
subplot(4, 1, 1);
plot(time, desired_signal);
title('Desired signal');
grid on
subplot(4, 1, 2);
plot(time, noise_signal);
title('Input with noise');
grid on
subplot(4, 1, 3);
plot(time, output_signal_nlms);
title('Output signal after NLMS filter');
grid on
subplot(4, 1, 4);
plot(time, error_nlms);
title('Error');
grid on

figure('Name', 'NLMS');
plot(time_help, [desired_signal(time_help, 1), noise_signal(time_help, 1), output_signal_nlms(time_help, 1), error_nlms(time_help, 1)])
grid on
title('NLMS')
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
plot(time, output_signal_nlms);
title('NLMS');
grid on

figure
subplot(2, 1, 1);
plot(time, error_lms);
title('LMS Error');
grid on
subplot(2, 1, 2);
plot(time, error_nlms);
title('NLMS Error');
grid on

figure('Name', 'LMS/NLMS');
plot(time_help, [desired_signal(time_help, 1), output_signal_lms(time_help, 1), output_signal_nlms(time_help, 1), error_lms(time_help, 1), error_nlms(time_help, 1)])
grid on
title('LMS/NLMS')
legend('Desired', 'Output LMS', 'Output NLMS', 'Error LMS', 'Error NLMS')
xlabel('Time')
ylabel('Signal value')
