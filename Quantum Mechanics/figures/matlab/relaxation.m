clear
close all

lifetimes = 5;
samples = 300;
time = linspace(0, lifetimes, samples)';  % t/T1
dephasing = [0 1];  % gamma_phi*T1
population = exp(-time);
coherence = exp(-time*(1/2 + dephasing));

figure(Units='centimeters', Position=[2 2 11 7.3])
plot(time, population, 'k--', LineWidth=1.5)
hold on
plot(time, coherence, LineWidth=1.5)
xlabel('$t/T_1$', Interpreter='latex')
ylabel('$Y(t)/Y(0)$', Interpreter='latex')
pad_legend(legend(["$\rho_{ee}$", "$|\rho_{eg}|,\ \gamma_\phi T_1=" + dephasing + "$"], Interpreter='latex'));
grid on
exportgraphics(gca, '../relaxation.pdf', ContentType='vector', BackgroundColor='none')
