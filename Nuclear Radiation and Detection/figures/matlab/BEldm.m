function [B, m] = BEldm(Z, A)

%BELDM binding energy [MeV] and mass [u] using liquid drop model
% semi-empirical binding energy formula

aV = 15.835;  % volume
aS = 18.33;   % surface
aC = 0.714;   % Coulomb
asym = 92.8;  % symmetric
ap = 11.2;    % pair

% binding energy formula
B = aV * A - aS * A.^(2/3) - aC * Z.^2.* A.^(-1/3) - asym * (A/2 - Z).^2./ A;
delta = 1 - mod(A, 2);
delta(delta == 1 & mod(Z, 2) == 1) = -1;
B = B + ap * delta.* A.^(-1/2);

if nargout == 1
    return
end

% constants: u
mH = 1.007825;
mn = 1.008665;
u_MeV = 1 / 931.494013;
m = Z * mH + (A - Z) * mn - B * u_MeV;

end
