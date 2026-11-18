clear
close all

n1 = [1 1 5 5 5];
n2 = [1 5 1 2 10];

x = linspace(0, 3, 10000)';
a = n1/2;
b = n2/2;
ratio = n1./n2;
f = (ratio.^a ./ beta(a, b)) .* x.^(a-1) ./ (1 + ratio.*x).^(a+b);
f(f > 1) = nan;

lincomp(plot(x, f, LineWidth=2))

xlabel("$x$", Interpreter="latex")
ylabel("$f(x)$", Interpreter="latex")

grid on

pad_legend(legend("$n_1="+n1+",n_2="+n2+"$", Interpreter="latex"));

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../pdf_F.pdf", ContentType="vector", BackgroundColor="none")
