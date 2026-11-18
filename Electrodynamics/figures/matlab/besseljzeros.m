function [x, num] = besseljzeros(nu, k, options)
% BESSELJZEROS:
%     zero-points of Bessel function J(x)
% INPUT:
%     nu: order of J
%     k : k-th zero-points
%     options:
%         xmax: zero-point max limit
% OUTPUT:
%     x  : (nu, k)-th zero-point table
%     num: number of zero-point of each nu

arguments
    nu (:, 1) {mustBeInRange(nu, 0, 20), mustBeInteger}
    k (1, :) {mustBeInRange(k, 1, 20), mustBeInteger} = 1:20
    options.xmax (1, 1) {mustBePositive} = inf
end

x = zeros(numel(nu), numel(k));  % roots of bessel
% root approximation
x(:, k == 1) = 2.26 + 0.67 * sqrt(nu) + nu;
x(:, k > 1) = -2 + 1.3661 * nu + 3.2656 * k(k > 1);

num = nan(numel(nu), 1);

for ii = 1 : numel(nu)
    for jj = 1 : numel(k)
        x(ii, jj) = fzero(@(z) besselj(nu(ii), z), x(ii, jj));
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
