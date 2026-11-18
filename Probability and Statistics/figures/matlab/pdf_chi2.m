clear
close all

n = [1 2 3 5];
x = linspace(0, 10, 10000)';

a = n/2;
f = x.^(a-1) .* exp(-x/2) ./ (2.^a .* gamma(a));
f(f > 0.6) = nan;

lincomp(plot(x, f, LineWidth=2))

xlabel("$x$", Interpreter="latex")
ylabel("$f(x)$", Interpreter="latex")

grid on

pad_legend(legend("$n="+n+"$", Interpreter="latex"));

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../pdf_chi2.pdf", ContentType="vector", BackgroundColor="none")
