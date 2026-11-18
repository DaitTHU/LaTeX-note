clear
close all

duration = [1 2];  % t/t_0
lobes = 3;
samples = 901;
detuning = linspace(-lobes, lobes, samples)';  % (E_f-E_i)*t_0/(2*pi*hbar)
phase = pi*detuning*duration;
lineShape = ones(size(phase));
offResonance = phase ~= 0;
lineShape(offResonance) = sin(phase(offResonance))./phase(offResonance);
probability = (duration.*lineShape).^2;

figure(Units='centimeters', Position=[2 2 11 7.3])
plot(detuning, probability, LineWidth=1.5)
xlabel('$(E_f-E_i)t_0/(2\pi\hbar)$', Interpreter='latex')
ylabel('$P_{i\to f}/(|V_{fi}|t_0/\hbar)^2$', Interpreter='latex')
pad_legend(legend("$t/t_0=" + duration + "$", Interpreter='latex'));
grid on
set(findall(gcf, Type='AxesToolbar'), Visible='off')
exportgraphics(gca, '../finite_time_line.pdf', ContentType='vector', BackgroundColor='none')
