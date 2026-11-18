clear
close all
hold on

n = [1 2 5 30];

x = linspace(-5, 5, 10000)';
f = (1 + x.^2./n).^(-(n+1)/2) ./ (sqrt(n) .* beta(n/2, 0.5));
finf = exp(-x.^2/2) / sqrt(2*pi);
lincomp([plot(x, f, LineWidth=2); plot(x, finf, '--k', LineWidth=2)]);

xlabel("$x$", Interpreter="latex")
ylabel("$f(x)$", Interpreter="latex")

grid on

remark = strings(size(n));
remark(n == 1) = ", Cauchy";
pad_legend(legend(["$n="+n+"$" + remark, "normal"], Interpreter="latex"));

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../pdf_t.pdf", ContentType="vector", BackgroundColor="none")
