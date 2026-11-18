figure
j = [1/2 1 2]';
a = linspace(0, 5, 1000);
B = ((j + 1/2).* coth((j + 1/2).* a) - coth(a / 2) / 2)./ j;
B(:, 1) = 0;

p1 = lincomp(plot(a, B, LineWidth=2));
hold on
p2 = plot([0 1], [0 1], 'k--');

set(gca, Children=[p1; p2])

xlabel("$a$", Interpreter="latex")
ylabel("$\mathrm{B}_j(a)$", Interpreter="latex")

grid on

pad_legend(legend(p1, "$j="+rats(j)+"$", Interpreter="latex", Location="southeast"));

set(gcf, Position=[200 200 600 300])

exportgraphics(gca, "../Brillouin.pdf", ContentType="vector", BackgroundColor="none")
