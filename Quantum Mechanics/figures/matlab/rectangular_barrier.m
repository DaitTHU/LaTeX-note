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

figure(Units='centimeters', Position=[2 2 17.5 8.2])
panels = tiledlayout(3, 2, TileSpacing='compact', Padding='compact');
barrierColor = [0.94 0.88 0.74];
potentialAxes = nexttile(panels, 1);
hold on
patch([0 0 1 1], [0 1 1 0], barrierColor, EdgeColor='none')
plot([-leftExtent 0 0 1 1 rightExtent], [0 0 1 1 0 0], 'k', LineWidth=1.3)
yline(energy, 'k--')
text(-leftExtent+0.2, energy, '$E/V_0$', Interpreter='latex', VerticalAlignment='bottom')
ylim([-0.12 1.18])
yticks([0 1])
ylabel('$V(x)/V_0$', Interpreter='latex')
xticklabels([])

densityAxes = nexttile(panels, 3, [2 1]);
density = transmission*abs(wave).^2;
densityLimit = ceil(2*max(density))/2;
hold on
patch([0 0 1 1], [0 densityLimit densityLimit 0], barrierColor, EdgeColor='none')
plot(position, density, Color=[0 0.35 0.60], LineWidth=1.5)
text(rightExtent-0.2, transmission, '$T$', Interpreter='latex', ...
    HorizontalAlignment='right', VerticalAlignment='bottom')
ylim([0 densityLimit])
linkaxes([potentialAxes densityAxes], 'x')
xlim([-leftExtent rightExtent])
xticks(-leftExtent:rightExtent)
xlabel('$x/a$', Interpreter='latex')
ylabel('$|\psi(x)/A_{\rm in}|^2$', Interpreter='latex')

nexttile(panels, 2, [3 1])
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
