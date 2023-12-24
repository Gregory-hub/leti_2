function [output_signal, error] = nlmsFilter(desired_signal, noise_signal_in, order, forgetting_factor)
    step_size = forgetting_factor; % Шаг обучения (изменение весов при каждой итерации)

    output_signal = zeros(size(noise_signal_in));
    error = zeros(size(noise_signal_in));

    for i = 1 : size(noise_signal_in, 2)
        noise_signal = noise_signal_in(:, i);
        weights = zeros(order, 1); % Веса фильтра
        for n = order : length(noise_signal)
            noise_signal_n = noise_signal(n : -1 : n-order+1); % Входной вектор
            output_signal(n, i) = weights.' * noise_signal_n; % Вычисление выходного сигнала
            error(n, i) = desired_signal(n, i) - output_signal(n, i); % Вычисление ошибки
            weights = weights + step_size * error(n, i) * conj(noise_signal_n) / (noise_signal_n' * noise_signal_n + eps); % Обновление коэффициентов фильтра
        end
    end
end
