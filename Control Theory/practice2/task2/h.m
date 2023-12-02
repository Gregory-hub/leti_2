clear, clc, clf

K = [ 0.5, 1.25, 4 ];
legendArr = strings(size(K));

for i = 1 : length(K)
    k = K(i);
    Wp = tf(k, [0.2, 1, 0]);
    W = Wp / (1 + Wp);
    stepplot(W)
    legendArr(i) = "k = " + num2str(k);
    hold on
end
grid on

legend(legendArr)
