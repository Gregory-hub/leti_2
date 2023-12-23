clear, clc
input_signal = audioread('input.wav');
[noise_signal, Fs] = audioread('input_noise.wav');

step_size = 0.5; % 0 - 2
order = 32; % Порядок фильтра (сколько предыдущих значений берется)

lms = dsp.LMSFilter();
lms_normalized = dsp.LMSFilter(order,'StepSize',step_size,'Method','Normalized LMS');

[output_signal_lms, error_lms, weights_out_lms] = lms(noise_signal,input_signal);
[output_signal_nlms, error_nlms, weights_out_nlms] = lms_normalized(noise_signal,input_signal);

recDuration = 3;
time = 0:seconds(1/Fs):seconds(recDuration);
time = time(1:end-1);

figure('Name','LMS');
subplot(4,1,1);
plot(time, input_signal);
title('Input signal');
subplot(4,1,2);
plot(time, noise_signal);
title('Input with noise');
subplot(4,1,3);
plot(time, output_signal_lms);
title('Output signal after LMS filter');
subplot(4,1,4);
plot(time, error_lms);
title('Error');

time_help = 76300:76350;

figure('Name','LMS');
plot(time_help, [input_signal(time_help), noise_signal(time_help), output_signal_lms(time_help), error_lms(time_help)])
title('LMS')
legend('Input', 'Noise', 'Output', 'Error')
xlabel('Time')
ylabel('Signal value')

figure('Name','NLMS');
subplot(4,1,1);
plot(time, input_signal);
title('Input signal');
subplot(4,1,2);
plot(time, noise_signal);
title('Input with noise');
subplot(4,1,3);
plot(time, output_signal_nlms);
title('Output signal after NLMS filter');
subplot(4,1,4);
plot(time, error_nlms);
title('Error');

figure('Name','NLMS');
plot(time_help, [input_signal(time_help), noise_signal(time_help), output_signal_nlms(time_help), error_nlms(time_help)])
title('NLMS')
legend('Input', 'Noise', 'Output', 'Error')
xlabel('Time')
ylabel('Signal value')

figure('Name','Comparison LMS and NLMS');
plot(time_help, [input_signal(time_help), output_signal_lms(time_help),output_signal_nlms(time_help), error_lms(time_help), error_nlms(time_help)])
title('Comparison LMS and NLMS')
legend('Input','OutputLMS', 'OutputNLMS', 'ErrorLMS', 'ErrorNLMS')
xlabel('Time')
ylabel('Signal value')
