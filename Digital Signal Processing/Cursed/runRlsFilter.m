clear, clc, clear sound

filename_desired = 'da-da.wav';
filename_noised = 'noise_da-da.wav';
filename_output = 'output_rls.wav';

desired_signal = audioread(filename_desired);
[noise_signal_in, Fs] = audioread(filename_noised);

order = 32;
forgetting_factor = 0.98; % 0 - 1, обычно 0.98 - 0.99

[output_signal, error] = rlsFilter(desired_signal, noise_signal_in, order, forgetting_factor);

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
title('Output signal after RLS filter');
grid on
subplot(4, 1, 4);
plot(time, error);
title('Error');
grid on

audiowrite(filename_output, output_signal, Fs);
