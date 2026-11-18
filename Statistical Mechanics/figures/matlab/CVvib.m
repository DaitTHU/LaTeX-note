figure
T = linspace(0, 3, 10000);
beta = 1./ T;

C = beta.^2.* exp(beta)./ (exp(beta) - 1).^2;

p1 = lincomp(plot(T, C, LineWidth=2));
hold on
% t << 1 limit
p2 = lincomp(plot(T, beta.^2.* exp(-beta), 'k--'));

set(gca, Children=[p1 p2])

grid on
xlabel("$T/\theta_{\mathrm{v}}$", Interpreter="latex")
ylabel("$C_{V,\mathrm{v}}/Nk_{\mathrm{B}}$", Interpreter="latex")

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../C_Vvib.pdf", ContentType="vector", BackgroundColor="none")
