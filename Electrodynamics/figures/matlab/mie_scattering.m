% Plane-wave scattering by a homogeneous, lossless dielectric sphere in vacuum.
indexRatio = 1.5;
x = linspace(0.1, 2.5, 481);
[full, electricDipole] = arrayfun(@(s) efficiencies(s, indexRatio), x);
rayleigh = (8/3)*x.^4*((indexRatio^2-1)/(indexRatio^2+2))^2;
relativeError = 100*abs([electricDipole; rayleigh]./full - 1);

fig = figure(Units="centimeters", Position=[2 2 15.8 6.2]);
layout = tiledlayout(fig, 1, 2, TileSpacing="compact", Padding="compact");
blue = [0.08 0.30 0.46];
orange = [0.67 0.30 0.11];
ax = nexttile(layout);
semilogy(ax, x, full, "k-", LineWidth=1.6)
hold(ax, "on")
semilogy(ax, x, electricDipole, "--", Color=blue, LineWidth=1.5)
semilogy(ax, x, rayleigh, "-.", Color=orange, LineWidth=1.4)
xlim(ax, [0 2.5])
ylim(ax, [1e-5 10])
yticks(ax, 10.^(-5:2:1))
xlabel(ax, "$ka$", Interpreter="latex")
ylabel(ax, "$\sigma_{\rm sca}/(\pi a^2)$", Interpreter="latex")
legend(ax, ["Mie","$a_1$","Rayleigh"], Location="southeast", Interpreter="latex", Box="off")
ax.FontSize = 10;
ax.TickDir = "out";

ax = nexttile(layout);
hold(ax, "on")
plot(ax, x, relativeError(1,:), "--", Color=blue, LineWidth=1.5)
plot(ax, x, relativeError(2,:), "-.", Color=orange, LineWidth=1.4)
yline(ax, 10, ":", Color=[0.35 0.35 0.35]);
for errorCurve = relativeError.'
    firstAbove = find(errorCurve >= 10, 1);
    bracket = firstAbove-1:firstAbove;
    crossing = interp1(errorCurve(bracket), x(bracket), 10);
    plot(ax, crossing, 10, "ko", MarkerFaceColor="white", MarkerSize=4)
end
xlim(ax, [0 1.5])
ylim(ax, [0 30])
yticks(ax, 0:10:30)
xlabel(ax, "$ka$", Interpreter="latex")
ylabel(ax, "$|Q/Q_{\rm Mie}-1|$ (\%)", Interpreter="latex")
ax.Box = "on";
ax.FontSize = 10;
ax.TickDir = "out";
exportgraphics(layout, "../mie_scattering.pdf", ContentType="vector", BackgroundColor="white")

function [full, electricDipole] = efficiencies(x, m)
% Orders through 12 suffice for this plot (x <= 2.5, m = 1.5).
ell = (1:12).';
orders = (0:12).'+0.5;
psi = sqrt(pi*x/2)*besselj(orders, x);
xi = psi + 1i*sqrt(pi*x/2)*bessely(orders, x);
inside = sqrt(pi*m*x/2)*besselj(orders, m*x);
dPsi = psi(1:end-1) - ell.*psi(2:end)/x;
dXi = xi(1:end-1) - ell.*xi(2:end)/x;
dInside = inside(1:end-1) - ell.*inside(2:end)/(m*x);
psi = psi(2:end);
xi = xi(2:end);
inside = inside(2:end);
a = (m*inside.*dPsi - psi.*dInside)./(m*inside.*dXi - xi.*dInside);
b = (inside.*dPsi - m*psi.*dInside)./(inside.*dXi - m*xi.*dInside);
full = 2/x^2 * sum((2*ell+1).*(abs(a).^2+abs(b).^2));
electricDipole = 6/x^2 * abs(a(1))^2;
end
