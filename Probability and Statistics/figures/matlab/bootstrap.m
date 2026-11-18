clear
close all

rng default

mu = 0;
sigma = 1;
Nsam = 100;
Nboot = 1000;

sample = mu + sigma*randn(Nsam, 1);
index = randi(Nsam, Nsam, Nboot);
bootsam = sample(index);
scatter(mean(bootsam), std(bootsam), '.')
hold on
xline(mu, '--')
yline(sigma, '--')

xlabel('Mean')
ylabel('Standard Deviation')

grid on

set(gcf, Position=[200 200 500 400])

exportgraphics(gca, "../bootstrap.pdf", ContentType="vector", BackgroundColor="none")
