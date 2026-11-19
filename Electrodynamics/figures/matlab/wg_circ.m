function [Ex, Ey, Ez, Hx, Hy, Hz] = wg_circ(mode, m, n, a, x, y, z, options)
% Cartesian fields of a forward circular-waveguide mode at t = 0.
% The longitudinal profile is J_m(kc*rho)*cos(m*phi), with the nth positive
% radial root. E and H are in units of E_ref and E_ref/Z, respectively,
% where Z is the intrinsic impedance of the filling medium.
% The Bessel root routines support n = 1:20, m = 0:14 (TE) or 0:20 (TM).
arguments
    mode {mustBeMember(mode, ["TE", "TM"])}
    m (1, 1) {mustBeInteger, mustBeNonnegative}
    n (1, 1) {mustBeInteger, mustBePositive}
    a (1, 1) {mustBePositive}
    x
    y
    z
    options.kz (1, 1) {mustBeNonnegative} = 0
    options.k (1, 1) {mustBePositive}
end

if mode == "TE"
    kc = besseljpzeros(m, n) / a;
else
    kc = besseljzeros(m, n) / a;
end
if isfield(options, 'k')
    k = options.k;
    if k < kc
        error("waveguide:cutoff", "kz is imaginary.")
    end
    kz = sqrt((k-kc)*(k+kc));
else
    kz = options.kz;
    k = hypot(kc, kz);
end

rho = hypot(x, y);
rho(rho > a + 4*eps(a)) = NaN;  % Allow roundoff in points on the wall.
phi = atan2(y, x);
u = kc*rho;
psi = besselj(m, u).*cos(m*phi);
% J_m' = (J_{m-1}-J_{m+1})/2 and m*J_m/u = (J_{m-1}+J_{m+1})/2
% give Cartesian derivatives that remain regular at the axis.
lower = besselj(m-1, u);
upper = besselj(m+1, u);
dx = kc/2 * (lower.*cos((m-1)*phi) - upper.*cos((m+1)*phi));
dy = -kc/2 * (lower.*sin((m-1)*phi) + upper.*sin((m+1)*phi));

longitudinal = psi.*cos(kz*z);
transverse = -sin(kz*z)/kc^2;
if mode == "TE"
    Hx = kz*transverse.*dx;
    Hy = kz*transverse.*dy;
    Hz = longitudinal;
    Ex = k*transverse.*dy;
    Ey = -k*transverse.*dx;
    Ez = 0*longitudinal;
else
    Ex = kz*transverse.*dx;
    Ey = kz*transverse.*dy;
    Ez = longitudinal;
    Hx = -k*transverse.*dy;
    Hy = k*transverse.*dx;
    Hz = 0*longitudinal;
end
end
