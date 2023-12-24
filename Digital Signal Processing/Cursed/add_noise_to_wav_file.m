clear; clc

filename = 'da-da.wav';

noise_filename = strcat('noise_', filename);
[signal, Fs] = audioread(filename);

SNR = 10; % уровень шума (больше уровень меньше шума)
noise = awgn(signal, SNR, 'measured');

audiowrite(noise_filename, noise, Fs)
