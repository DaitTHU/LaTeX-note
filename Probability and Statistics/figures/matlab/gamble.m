clear
close all

n = 6;
k = 1 : n-1;

p = linspace(0, 1, 100000)';
lambda = (1 - p)./ p;

Pk = (1 - lambda.^k)./ (1 - lambda.^n);
Pk(1, :) = 0;
lincomp(plot(p, Pk, LineWidth=2), disp=true)

xlabel("$p$", Interpreter="latex")
ylabel("$Q_i$", Interpreter="latex")
pad_legend(legend("$i = "+k+"$", Interpreter="latex", Location="southeast"));

grid on

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../gamble.pdf", BackgroundColor="none", ContentType="vector")
