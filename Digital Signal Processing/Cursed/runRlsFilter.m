function [output_signal, Fs] = runRlsFilter(filename_desired, filename_noised, filename_output, order, lambda)
    desired_signal = audioread(filename_desired);
    [noise_signal_in, Fs] = audioread(filename_noised);
    output_signal = zeros(size(noise_signal_in));
    weights = zeros(order, 1);
    K = zeros(order, 1);
    P = diag(ones(order, 1) * 1000);

    n = order;
    while (n < size(noise_signal_in, 1))
        [output_signal, weights, P, K, n] = rlsFilter(desired_signal, noise_signal_in, output_signal, lambda, order, weights, P, K, n, 1);
    end

    audiowrite(filename_output, output_signal, Fs);
end
