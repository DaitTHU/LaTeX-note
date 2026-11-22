clear
close all

time = [0 1 2];  % t/t_s
width = hypot(1, time);  % sigma(t)/sigma_0
tailWidths = 4;
samples = 801;
extent = tailWidths*max(width);
position = linspace(-extent, extent, samples)';  % (x-<X>)/sigma_0
density = exp(-(position./width).^2/2)./(sqrt(2*pi)*width);

figure(Units='centimeters', Position=[2 2 11 7.3])
plot(position, density, LineWidth=1.5)
xlim([-extent extent])
xlabel('$(x-\langle\hat{X}\rangle)/\sigma_0$', Interpreter='latex')
ylabel('$\sigma_0 |\psi|^2$', Interpreter='latex')
pad_legend(legend("$t/t_{\mathrm{s}}=" + time + "$", Interpreter='latex'));
grid on
set(findall(gcf, Type='AxesToolbar'), Visible='off')
exportgraphics(gca, '../free_packet.pdf', ContentType='vector', BackgroundColor='none')
