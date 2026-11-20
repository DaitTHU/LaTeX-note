% Angle-integrated synchrotron power per unit angular frequency.
% x = omega/omega_c. The plotted density integrates to one over dx.
shape = @(x) 9*sqrt(3)/(8*pi) * x * integral(@(u) besselk(5/3, u), x, Inf);
x = logspace(-3, 1, 220);
density = arrayfun(shape, x);
peak = fminbnd(@(x) -shape(x), 0.1, 0.5);

fig = figure(Units="centimeters", Position=[2 2 13 6.7]);
ax = axes(fig);
semilogx(ax, x, density, Color=[0.10 0.32 0.46], LineWidth=1.6)
hold(ax, "on")
xline(ax, 1, "--", Color=[0.43 0.43 0.43]);
plot(ax, peak, shape(peak), "o", MarkerSize=5, ...
    MarkerEdgeColor=[0.10 0.32 0.46], MarkerFaceColor="white")
xlim(ax, [x(1) x(end)])
ylim(ax, [0 0.65])
yticks(ax, 0:0.2:0.6)
ax.TickDir = "out";
ax.FontSize = 11;
xlabel(ax, "$\omega/\omega_{\rm c}$", Interpreter="latex")
ylabel(ax, "$(\omega_{\rm c}/P)\,{\rm d}P/{\rm d}\omega$", Interpreter="latex")
exportgraphics(fig, "../synchrotron_spectrum.pdf", ContentType="vector", BackgroundColor="white")
