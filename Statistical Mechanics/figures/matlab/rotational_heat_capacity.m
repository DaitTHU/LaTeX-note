function C = rotational_heat_capacity(t)
% C/(N k_B) of a rigid heteronuclear rotor, with t = T/theta_r.
C = zeros(size(t));
for k = 1:numel(t)
    if t(k) == 0
        continue
    end
    % The first omitted level has Boltzmann factor below exp(-45).
    ell = 0:ceil(sqrt(45*t(k)));
    energy = ell.*(ell + 1)/t(k);
    weight = (2*ell + 1).*exp(-energy);
    prob = weight/sum(weight);
    C(k) = sum(prob.*(energy - sum(prob.*energy)).^2);
end
end
