clear
close all

energy = 1/2;  % E/V_0
opticalWidth = 1;  % kappa*a
phase = opticalWidth*sqrt(energy/(1-energy));  % k*a
transmission = 1/(1+sinh(opticalWidth)^2/(4*energy*(1-energy)));
samples = 901;
leftExtent = 4;
rightExtent = 3;
position = linspace(-leftExtent, rightExtent, samples)';  % x/a
inside = position >= 0 & position <= 1;
left = position < 0;
wave = exp(1i*phase*(position-1));
depth = opticalWidth*(position(inside)-1);
wave(inside) = cosh(depth) + 1i*phase/opticalWidth*sinh(depth);
boundary = cosh(opticalWidth) - 1i*phase/opticalWidth*sinh(opticalWidth);
slope = -opticalWidth*sinh(opticalWidth) + 1i*phase*cosh(opticalWidth);
wave(left) = boundary*cos(phase*position(left)) + slope/phase*sin(phase*position(left));

figure(Units='centimeters', Position=[2 2 17.5 7])
panels = tiledlayout(1, 2, TileSpacing='compact');
nexttile
plot(position, transmission*abs(wave).^2, LineWidth=1.5)
xline([0 1], 'k:')
xlim([-leftExtent rightExtent])
xlabel('$x/a$', Interpreter='latex')
ylabel('$|\psi/\psi_{\rm in}|^2$', Interpreter='latex')
grid on

nexttile
energyRatios = [1/4 1/2 3/4];
maxWidth = 5;
width = linspace(0, maxWidth, samples)';  % a*sqrt(2*m*V_0)/hbar
decay = width*sqrt(1-energyRatios);
transmission = 1./(1+sinh(decay).^2./(4*energyRatios.*(1-energyRatios)));
semilogy(width, transmission, LineWidth=1.5)
xlabel('$a\sqrt{2mV_0}/\hbar$', Interpreter='latex')
ylabel('$T$', Interpreter='latex')
pad_legend(legend("$E/V_0=" + energyRatios + "$", Interpreter='latex', Location='southwest'));
grid on
set(findall(gcf, Type='AxesToolbar'), Visible='off')
exportgraphics(panels, '../rectangular_barrier.pdf', ContentType='vector', BackgroundColor='none')
