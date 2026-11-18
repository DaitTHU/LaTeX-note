function [x, num] = besseljpzeros(nu, k, options)
% BESSELJPZEROS:
%     zero-points of Bessel function derivative J'(x)
% INPUT:
%     nu: order of J
%     k : k-th zero-points
%     options:
%         xmax: zero-point max limit
% OUTPUT:
%     x  : (nu, k)-th zero-point table
%     num: number of zero-point of each nu

arguments
    nu (:, 1) {mustBeInRange(nu, 0, 14), mustBeInteger}
    k (1, :) {mustBeInRange(k, 1, 20), mustBeInteger} = 1:20
    options.xmax (1, 1) {mustBePositive} = inf
end

x = zeros(numel(nu), numel(k));  % roots of bessel
% root approximation
x(nu == 0, :) = 0.75 + pi * k(any(nu == 0), :);
if any(nu > 0)
    x(nu > 0, :) = -3.63 + 1.35 * nu(nu > 0) + 3.29 * k;
end

num = nan(numel(nu), 1);

for ii = 1 : numel(nu)
    for jj = 1 : numel(k)
        x(ii, jj) = fzero(@(z) besseljp(nu(ii), z), x(ii, jj));
        if x(ii, jj) > options.xmax
            x(ii, jj:end) = nan;  % exceed max limit, cut off
            num(ii) = jj - 1;
            break
        end
    end
end

% clear all-nan column
x = x(:, ~all(isnan(x), 1));
num(isnan(num)) = numel(k);

end
