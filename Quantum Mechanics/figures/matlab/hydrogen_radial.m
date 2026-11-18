clear
close all

extent = 16;
samples = 801;
radius = linspace(0, extent, samples)';  % r/a_Z
radial1s = 2*exp(-radius);
radial2s = (2-radius).*exp(-radius/2)/sqrt(8);
radial2p = radius.*exp(-radius/2)/sqrt(24);
density = (radius.*[radial1s radial2s radial2p]).^2;

figure(Units='centimeters', Position=[2 2 11 7.3])
plot(radius, density, LineWidth=1.5)
xlim([0 extent])
xlabel('$r/a_Z$', Interpreter='latex')
ylabel('$a_Z r^2 |R_{n\ell}(r)|^2$', Interpreter='latex')
pad_legend(legend('$1s$', '$2s$', '$2p$', Interpreter='latex'));
grid on
set(findall(gcf, Type='AxesToolbar'), Visible='off')
exportgraphics(gca, '../hydrogen_radial.pdf', ContentType='vector', BackgroundColor='none')
