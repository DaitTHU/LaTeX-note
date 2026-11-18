function [Ex, Ey, Ez, Hx, Hy, Hz] = wg_rect(mode, m, n, a, b, x, y, z, options)

arguments
    mode {mustBeMember(mode, ["TE", "TM"])}
    m (1, 1) {mustBeInteger, mustBeNonnegative}
    n (1, 1) {mustBeInteger, mustBeNonnegative}
    a (1, 1) {mustBePositive}
    b (1, 1) {mustBePositive}
    x
    y
    z
    options.kz (1, 1) {mustBeNonnegative} = 0
    options.k (1, 1) {mustBePositive}
end

kx = m * pi / a;
ky = n * pi / b;
kc = hypot(kx, ky);
if isfield(options, 'k')
    kz = sqrt(options.k^2 - kc^2);
else
    kz = options.kz;
end
if ~isreal(kz)
    throw(MException("waveguide:cutoff", "kz is imaginary."))
end

x(x < 0 | x > a) = nan;
y(y < 0 | y > b) = nan;

coskx = cospi(m * x / a);
sinkx = sinpi(m * x / a);
cosky = cospi(n * y / b);
sinky = sinpi(n * y / b);
coskz = cos(kz * z);
sinkz = sin(kz * z);

if mode == "TE"
    Hx = kz*kx/kc^2 * sinkx.* cosky.* sinkz;
    Hy = kz*ky/kc^2 * coskx.* sinky.* sinkz;
    Hz = coskx.* cosky.* coskz;
    Ex = ky/kc^2 * coskx.* sinky.* sinkz;
    Ey = -kx/kc^2 * sinkx.* cosky.* sinkz;
    Ez = zeros(size(Ex));
elseif mode == "TM"
    Ex = -kz*kx/kc^2 * coskx.* sinky.* sinkz;
    Ey = -kz*ky/kc^2 * sinkx.* cosky.* sinkz;
    Ez = sinkx.* sinky.* coskz;
    Hx = ky/kc^2 * sinkx.* cosky.* sinkz;
    Hy = -kx/kc^2 * coskx.* sinky.* sinkz;
    Hz = zeros(size(Hx));
end

end
