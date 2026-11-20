function C = vibrational_heat_capacity(t)
% C/(N k_B) of one harmonic vibrational mode, with t = T/theta_v.
C = zeros(size(t));
x = 1./t(t > 0);
C(t > 0) = x.^2.*exp(-x)./expm1(-x).^2;
end
