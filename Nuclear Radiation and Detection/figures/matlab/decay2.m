clear
close all

lambda1 = 1;
lambda2 = 2;

N10 = 1;
t = (0 : .01 : 5) / lambda1;
N1 = N10 * exp(-lambda1 * t);
N2 = N10 * lambda1 * (exp(-lambda1 * t) - exp(-lambda2 * t)) / (lambda2 - lambda1);
N3 = N10 * (lambda2 * (1 - exp(-lambda1 * t)) - lambda1 * (1 - exp(-lambda2 * t))) / (lambda2 - lambda1);

plot(t, N1, t, N2, t, N3, LineWidth=2)

% A1 = lambda1 * N1;
% A2 = lambda2 * N2;
% plot(t, A1, t, A2, LineWidth=2)

xlabel("$t/\tau_1$", Interpreter="latex")
ylabel("$N/N_{10}$", Interpreter="latex")

pad_legend(legend("$N_"+(1:3)+"(t)$", Interpreter="latex", Location="eastoutside"));

grid on

set(gcf, Position=[200 200 700 350])

exportgraphics(gca, '../decay2.pdf', ContentType='vector', BackgroundColor='none')
