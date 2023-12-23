function [output_signal, weights, P, K, n] = rlsFilter(desired_signal, noise_signal_in, output_signal, lambda, order, weights, P, K, n, depth)
    if (~isequal(size(weights),  [order 1]) || ~isequal(size(P),  [order order]) || ~isequal(size(K),  [order 1]))
        return;
    end
    if (lambda <= 0 || lambda > 1 || depth <= 0)
        return
    end
    if (n <= order)
        n = order;
    end

    MAX_DEPTH = 10000;
    if (n > size(noise_signal_in, 1) || depth > MAX_DEPTH)
        return
    end

    for i = 1 : size(noise_signal_in, 2)
        noise_signal_n = noise_signal_in(n : -1 : n-order+1, i);
        output_signal(n, i) = weights.' * noise_signal_n;
        error = desired_signal(n, i) - output_signal(n, i);

        K = P * noise_signal_n / (lambda + noise_signal_n.' * P * noise_signal_n);
        P = P - K * noise_signal_n.' * P / lambda;
        weights = weights + K * error;
    end

    [output_signal, weights, P, K, n] = rlsFilter(desired_signal, noise_signal_in, output_signal, lambda, order, weights, P, K, n + 1, depth + 1);
end
