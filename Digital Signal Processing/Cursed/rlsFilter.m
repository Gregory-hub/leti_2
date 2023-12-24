function [output_signal, error] = rlsFilter(desired_signal, noise_signal_in, order, forgetting_factor)
    output_signal = zeros(size(noise_signal_in));
    error = zeros(size(noise_signal_in));
    weights = zeros(order, 1);
    K = zeros(order, 1);
    P = diag(ones(order, 1) * 1000);

    n = order;
    while (n < size(noise_signal_in, 1))
        [output_signal, weights, error, P, K, n] = rlsFilterRecursion(desired_signal, noise_signal_in, output_signal, forgetting_factor, order, weights, error, P, K, n, 1);
    end
end
