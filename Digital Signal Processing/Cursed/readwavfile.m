clear; clc
name = "polskaya-korova.wav";
[signal,Fs] = audioread(name);
info = audioinfo(name);
%sound(y,Fs)

t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);

figure
subplot(2,1,1)
plot(t,signal)
xlabel('Time')
ylabel('Audio Signal')

noise_filename = strcat('noise_', name);

SNR = 1; % уровень шума в децибелах (больше уровень меньше шума)
noise = awgn(signal,SNR,'measured'); % гауссов белый шум

audiowrite(noise_filename, noise, Fs)

subplot(2,1,2)
plot(t, noise)
xlabel('Time')
ylabel('Audio Signal-Noise')
