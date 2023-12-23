clear; clc

filename = 'polskaya-korova.wav';
noise_filename = strcat('noise_', filename);
[signal, Fs] = audioread(filename);

SNR = 1; % уровень шума в децибелах (больше уровень меньше шума)
noise = awgn(signal, SNR, 'measured');

audiowrite(noise_filename, noise, Fs)
