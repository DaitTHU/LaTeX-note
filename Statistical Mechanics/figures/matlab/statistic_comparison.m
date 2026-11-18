figure
x = linspace(-3, 3, 1000);
a = 1./ (exp(x) + [-1 0 1]');
a(a < 0 | a > 3.1) = nan;
p1 = lincomp(plot(x, a, LineWidth=2));
hold on
p2 = plot([-3 3], [1 1], 'k--');
p3 = plot([0 0], [0, 3], 'k--');

pad_legend(legend(p1, ["Bose-Einstein", "Maxwell-Boltzmann", "Fermi-Dirac"], Interpreter="latex"));

set(gca, Children=[p1; p2; p3])

grid on

xlabel("$\alpha+\beta\varepsilon_i$", Interpreter="latex")
ylabel("$a_i/\omega_i$", Interpreter="latex")
ylim([0 3])

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../Boltzmann_Bose_Fermi.pdf", ContentType="vector", BackgroundColor="none")
