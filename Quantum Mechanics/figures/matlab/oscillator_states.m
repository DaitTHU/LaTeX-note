clear
close all

extent = 4;
samples = 601;
position = linspace(-extent, extent, samples)';  % x/b
ground = pi^(-1/4)*exp(-position.^2/2);
first = sqrt(2)*position.*ground;
second = (2*position.^2-1).*ground/sqrt(2);

figure(Units='centimeters', Position=[2 2 11 7.3])
plot(position, [ground first second], LineWidth=1.5)
yline(0, 'k:')
xlabel('$x/b$', Interpreter='latex')
ylabel('$\sqrt{b}\,\psi_n(x)$', Interpreter='latex')
pad_legend(legend("$n=" + (0:2) + "$", Interpreter='latex', Location='southeast'));
grid on
set(findall(gcf, Type='AxesToolbar'), Visible='off')
exportgraphics(gca, '../oscillator_states.pdf', ContentType='vector', BackgroundColor='none')
