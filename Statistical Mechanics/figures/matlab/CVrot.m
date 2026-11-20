figure
T = linspace(0, 3, 1000);
C = rotational_heat_capacity(T);

p1 = lincomp(plot(T, C, LineWidth=2));
hold on
% t << 1 limit
t = linspace(0.001, 0.604, 1000);
p2 = lincomp(plot(t, 12 * exp(-2./ t)./ t.^2, 'k--'));
% t >> 1 limit
p3 = plot([0 max(T)], [1 1], 'k--');

set(gca, Children=[p1 p2 p3])

grid on
xlabel("$T/\theta_{\mathrm{r}}$", Interpreter="latex")
ylabel("$C_{V,\mathrm{r}}/(Nk_{\mathrm{B}})$", Interpreter="latex")

set(gcf, Position=[200 200 600 400])

exportgraphics(gca, "../C_Vrot.pdf", ContentType="vector", BackgroundColor="none")
