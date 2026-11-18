function mass = binomial_mass(n, p)
% Probabilities P(X=k), k=0,...,n, for X~Binomial(n,p).
k = 0:n;
if p == 0 || p == 1
    mass = double(k == n*p);
    return
end
logCoefficient = gammaln(n+1) - gammaln(k+1) - gammaln(n-k+1);
mass = exp(logCoefficient + k*log(p) + (n-k)*log1p(-p));
end
