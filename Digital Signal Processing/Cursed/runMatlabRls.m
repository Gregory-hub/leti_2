clear, clc, clear sound

filename_desired = 'da-da.wav';
filename_noised = 'noise_da-da.wav';
filename_output = 'output_rls.wav';

desired_signal = audioread(filename_desired);
[noise_signal_in, Fs] = audioread(filename_noised);

order = 32;
forgetting_factor = 0.99;

rls = dsp.RLSFilter(order, 'ForgettingFactor', forgetting_factor);

output_signal = zeros(size(noise_signal_in));
[output_signal(:, 1), error(:, 1)] = rls(noise_signal_in(:, 1), desired_signal(:, 1));
[output_signal(:, 2), error(:, 2)] = rls(noise_signal_in(:, 2), desired_signal(:, 2));

sound(output_signal, Fs);

time = 0 : seconds(1/Fs) : seconds((size(noise_signal_in, 1) - 1) / Fs);

figure
subplot(4, 1, 1);
plot(time, desired_signal);
title('Desired signal');
grid on
subplot(4, 1, 2);
plot(time, noise_signal_in);
title('Noise signal');
grid on
subplot(4, 1, 3);
plot(time, output_signal);
title('Output signal after Matlab RLS filter');
grid on
subplot(4, 1, 4);
plot(time, error);
title('Error');
grid on

audiowrite(filename_output, output_signal, Fs);
