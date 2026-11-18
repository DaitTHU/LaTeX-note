function sigma_inv = perminv(sigma, index)

arguments
    sigma
    index = nan
end

sigma_inv = zeros(size(sigma));
sigma_inv(sigma) = 1 : numel(sigma);
if ~isnan(index)
    sigma_inv = sigma_inv(index);
end

end
