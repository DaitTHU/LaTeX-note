clear
close all

detuning = [0 1 2];  % Delta/Omega
periods = 2;
samples = 600;
phase = linspace(0, periods*2*pi, samples)';  % Omega*t
frequency = hypot(1, detuning);
probability = (sin(phase*frequency/2)./frequency).^2;

figure(Units='centimeters', Position=[2 2 11 7.3])
plot(phase/pi, probability, LineWidth=1.5)
xlabel('$\Omega t/\pi$', Interpreter='latex')
ylabel('$P_{-z\to+z}$', Interpreter='latex')
lgd = pad_legend(legend("$\Delta/\Omega=" + detuning + "$", Interpreter='latex', Location='north'));
lgd.IconColumnWidth = 24;  % Keep the north legend between the resonant peaks.
grid on
exportgraphics(gca, '../rabi.pdf', ContentType='vector', BackgroundColor='none')
