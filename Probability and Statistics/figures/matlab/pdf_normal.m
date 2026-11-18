clear
close all

MU = [-2 0 1];
SIGMA = [0.5 1 2];

x = linspace(-5, 5, 10000)';
z = (x-MU)./SIGMA;
f = exp(-z.^2/2) ./ (sqrt(2*pi)*SIGMA);
lincomp(plot(x, f, LineWidth=2))

xlabel("$x$", Interpreter="latex")
ylabel("$f(x)$", Interpreter="latex")
ylim([0 1])
grid on

pad_legend(legend("$\mu="+MU'+",\sigma="+rats(SIGMA')+"\;$", Interpreter="latex"));

set(gcf, Position=[200 200 800 300])

exportgraphics(gca, "../pdf_normal.pdf", ContentType="vector", BackgroundColor="none")
