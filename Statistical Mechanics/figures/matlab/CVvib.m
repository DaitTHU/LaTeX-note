figure
T = linspace(0, 3, 10000);
C = vibrational_heat_capacity(T);

p1 = lincomp(plot(T, C, LineWidth=2));
hold on
% t << 1 limit
beta = 1./T(2:end);
p2 = lincomp(plot(T, [0 beta.^2.*exp(-beta)], 'k--'));

set(gca, Children=[p1 p2])

grid on
xlabel("$T/\theta_{\mathrm{v}}$", Interpreter="latex")
ylabel("$C_{V,\mathrm{v}}/(Nk_{\mathrm{B}})$", Interpreter="latex")

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../C_Vvib.pdf", ContentType="vector", BackgroundColor="none")
