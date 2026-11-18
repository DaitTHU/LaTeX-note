clear
close all

spacing = 4.9;  % V
offset = 1;  % V
orders = 1:4;
centres = offset + orders*spacing;
dipWidth = spacing/7;
dipDepth = 0.7;
maxVoltage = centres(end) + spacing/2;
samples = 801;
voltage = linspace(0, maxVoltage, samples)';
envelope = voltage/maxVoltage;
dips = exp(-((voltage-centres)/dipWidth).^2/2);
current = envelope.*(1-dipDepth*sum(dips, 2));

figure(Visible='off', Units='centimeters', Position=[2 2 9.2 6.1])
plot(voltage, current, LineWidth=1.5)
xlim([0 maxVoltage])
xlabel('$U$ (V)', Interpreter='latex')
ylabel('$I$ (arb. units)', Interpreter='latex')
grid on
exportgraphics(gca, '../franck_hertz_current.pdf', ContentType='vector', BackgroundColor='none')
