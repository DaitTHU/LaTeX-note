function index = xorindex(X)
arguments
    X (1, :) logical
end
index = 1 + find(xor(X(1:end-1), X(2:end)));
end
