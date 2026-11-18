clear
close all

rate = [2 1 1/2];

x = linspace(0, 3, 10000)';
f = rate .* exp(-x .* rate);
lincomp(plot(x, f, LineWidth=2))

xlabel("$x$", Interpreter="latex")
ylabel("$f(x)$", Interpreter="latex")

grid on

pad_legend(legend("$\lambda="+rats(rate')+"$", Interpreter="latex"));

set(gcf, Position=[200 200 800 300])

exportgraphics(gca, "../pdf_exp.pdf", ContentType="vector", BackgroundColor="none")
