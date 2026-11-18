clear
close all

rng default

N = 1000;

x = rand([N, 1]);
y = rand([N, 1]);
in = (x.^2 + y.^2 <= 1);
data = table(x, y, in);

scatter(x(in), y(in), '.', DisplayName="inside: "+sum(in))
hold on
scatter(x(~in), y(~in), '.', DisplayName="outside: "+sum(~in))

theta = linspace(0, pi/2, 10000);
lincomp(plot(cos(theta), sin(theta), 'k', HandleVisibility='off'))

xlabel('$x$', Interpreter='latex')
ylabel('$y$', Interpreter='latex')
pad_legend(legend(Location="eastoutside", Interpreter="latex"));

axis equal
axis([0 1 0 1])

set(gcf, Position=[200 200 500 400])

exportgraphics(gca, "../monte_carlo.pdf", ContentType="vector", BackgroundColor="none")

peye = 4 * sum(in) / N;
