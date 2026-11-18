% Five-degree, sign-coloured variant of the sketch project's spherical-harmonic plot.
% Each tile uses its own scale to show the nodal surfaces clearly.
figure(Units="pixels", Position=[80 80 1280 644])
lmax = 5;
theta = (0 : 0.01 : 1) * pi;
phi = (0 : 0.01 : 2)' * pi;

t = tiledlayout(lmax+1, 2*lmax+1, TileSpacing="none", Padding="tight");
t.OuterPosition = [0.05 0.07 0.90 0.85];
for l = 0:lmax
    Pl = legendre(l, cos(theta), 'norm');
    for m = -l:l
        nexttile((2*lmax+1)*l + m + lmax + 1)
        Plm = (-1)^abs(m) * Pl(abs(m)+1, :);
        if m < 0
            Ylm = Plm .* sin(abs(m) * phi);
        else
            Ylm = Plm .* cos(m * phi);
        end
        [x, y, z] = sph2cart(phi, pi/2-theta, abs(Ylm));
        surf(x, y, z, sign(Ylm), EdgeColor="none")
        axis equal off
    end
end

exportgraphics(gcf, "../sphericalharmonicY.png", Units="pixels", ...
    Width=2560, Height=1287, Padding="figure", BackgroundColor="white")
