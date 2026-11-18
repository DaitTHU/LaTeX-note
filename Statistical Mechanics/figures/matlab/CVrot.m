figure
T = linspace(0, 3, 1000);
beta = 1./ T;
l = (0 : 100)';
Z = sum((2 * l + 1).* exp(-l.* (l + 1).* beta));
Z(1) = 1;
U = [0 -diff(log(Z))./ diff(beta)];
C = [0 diff(U)./ diff(T)];

p1 = lincomp(plot(T, C, LineWidth=2));
hold on
% t << 1 limit
t = linspace(0, 0.604, 1000);
p2 = lincomp(plot(t, 12 * exp(-2./ t)./ t.^2, 'k--'));
% t >> 1 limit
p3 = plot([0 max(T)], [1 1], 'k--');

set(gca, Children=[p1 p2 p3])

grid on
xlabel("$T/\theta_{\mathrm{r}}$", Interpreter="latex")
ylabel("$C_{V,\mathrm{r}}/Nk_{\mathrm{B}}$", Interpreter="latex")

set(gcf, Position=[200 200 600 400])

exportgraphics(gca, "../C_Vrot.pdf", ContentType="vector", BackgroundColor="none")
