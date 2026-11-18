figure
hold on

p = 0.5;
N = [100 1000 10000];

for n = N
    x = 0 : n;
    f = binomial_mass(n, p);
    lincomp(plot(x / n, f * n, LineWidth=2), disp=true)
end

xticks(0:0.25:1)
xlabel('$x$', Interpreter='latex')
ylabel('$f(x)$', Interpreter='latex')

grid on
box on

pad_legend(legend("$N="+N+"$", Interpreter="latex"));

set(gcf, Position=[200 200 500 400])

exportgraphics(gca, "../ML_distribution.pdf", ContentType="vector", BackgroundColor="none")
