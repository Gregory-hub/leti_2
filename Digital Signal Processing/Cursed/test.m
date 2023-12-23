clear, clc, clear sound

desired = 'chin-chan-chon-chi-chicha-chochi.wav';
noised = 'noise_chin-chan-chon-chi-chicha-chochi.wav';
output = 'output_rls.wav';
order = 32;
lambda = 0.99; % 0 < lambda <= 1, обычно 0.98 <= lambda <= 0.99

[output_signal, Fs] = runRlsFilter(desired, noised, output, order, lambda);

sound(output_signal, Fs);
