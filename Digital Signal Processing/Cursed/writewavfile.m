clear; clc

Fs = 44100; % частота дискретизации
bit = 16; % битность записи
channel = 1; % количество каналов
id = -1; % идентификатор устройства записи
recObj = audiorecorder(Fs, bit, channel, id);

disp("Begin speaking.")
recDuration = 3; % сколько секунд записывать
recordblocking(recObj, recDuration);
disp("End of recording.")
play(recObj);

audioData = getaudiodata(recObj);

in_filename = 'input.wav';
audiowrite(in_filename, audioData, Fs)

% Create time axis
time = 0 : seconds(1/Fs) : seconds(recDuration);
time = time(1:end-1);

subplot(2, 1, 1);
plot(time, audioData);
xlabel('Время');
ylabel('Амплитуда');
title('График аудиосигнала');
grid on;

SNR = 1; % уровень шума в децибелах (больше уровень меньше шума)
noise = awgn(audioData, SNR, 'measured');

in_noise_filename = 'input_noise.wav';
audiowrite(in_noise_filename, noise, Fs)

subplot(2, 1, 2);
plot(time, [audioData, noise]);
xlabel('Время');
ylabel('Амплитуда');
title('Аудиосигнал с шумом');
grid on;
