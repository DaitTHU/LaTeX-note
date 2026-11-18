clear
close all
hold on

p = 0.7;
N = [10 50 100];

for n = N
    x = 0 : n;
    f = binomial_mass(n, p);
    bar(x, f, 1, EdgeColor="none")
end

z = linspace(-3, 3, 100000)';
fn = exp(-z.^2/2) / sqrt(2*pi);

mu = N * p;
sigma = sqrt(N * p * (1 - p));
lincomp(plot(z.* sigma + mu, fn./ sigma, 'k', LineWidth=2))

xticks auto
xlim([0, max(N)])
xlabel('$k$', Interpreter='latex')
ylabel('${\rm P}(X=k)$', Interpreter='latex')

grid on

pad_legend(legend(["$n="+N+"$" "normal"], Interpreter="latex"));

set(gcf, Position=[200 200 800 300])

exportgraphics(gca, "../CLT_bin.pdf", ContentType="vector", BackgroundColor="none")
