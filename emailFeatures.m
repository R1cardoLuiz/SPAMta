function x = emailFeatures(word_indices)
%EMAILFEATURES recebe como parametros os indices e transforma num vetor da
%forma x = [ 0 0 0 1 0 0 0 ... 0 0 1 0 1 ... 1 0 ..];

n = 2000;

x = zeros(n, 1);

x(word_indices) = 1;

end
