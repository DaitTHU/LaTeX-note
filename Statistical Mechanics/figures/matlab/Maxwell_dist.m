figure
kB = 1.38e-23;
NA = 6.02e23;
m = 32e-3 / NA;

T = [100 300 500]';
v = linspace(0, 1000, 10000);

kT = kB * T;
f = 4 * pi * (m./ (2 * pi * kT)).^1.5.* exp(-m * v.^2./ (2 * kT)).* v.^2;
lincomp(plot(v, f, LineWidth=2))

% xline(sqrt(2 * kT / m))

grid on
xlabel("$v/(\mathrm{m}\,\mathrm{s}^{-1})$", Interpreter="latex")
ylabel("$p(v)/(\mathrm{s}\,\mathrm{m}^{-1})$", Interpreter="latex")
pad_legend(legend("$T="+T+"$ K", Interpreter="latex"));

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../Maxwell_distribution.pdf", ContentType="vector", BackgroundColor="none")
