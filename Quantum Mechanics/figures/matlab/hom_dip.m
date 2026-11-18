clear
close all

bandwidth = [1 2];  % sigma_omega/sigma_ref
extent = 3;
samples = 601;
delay = linspace(-extent, extent, samples)';  % sigma_ref*tau
coincidence = (1-exp(-(delay*bandwidth).^2))/2;

figure(Units='centimeters', Position=[2 2 11 7.3])
plot(delay, coincidence, LineWidth=1.5)
xlabel('$\sigma_{\rm ref}\tau$', Interpreter='latex')
ylabel('$P_{1,1}$', Interpreter='latex')
pad_legend(legend("$\sigma_\omega/\sigma_{\rm ref}=" + bandwidth + "$", Interpreter='latex', Location='southwest'));
grid on
set(findall(gcf, Type='AxesToolbar'), Visible='off')
exportgraphics(gca, '../hom_dip.pdf', ContentType='vector', BackgroundColor='none')
