clear
close all

extent = 4;
samples = 401;
detuning = linspace(-extent, extent, samples)';  % (E_a-E_b)/(2|g|)
branch = hypot(1, detuning);

figure(Units='centimeters', Position=[2 2 11 7.3])
plot(detuning, [detuning -detuning], 'k:', LineWidth=1)
hold on
levels = plot(detuning, [branch -branch], LineWidth=1.5);
xlabel('$(E_a-E_b)/(2|g|)$', Interpreter='latex')
ylabel('$(E-\bar E)/|g|$', Interpreter='latex')
pad_legend(legend(levels, '$E_+$', '$E_-$', Interpreter='latex', Location='east'));
grid on
set(findall(gcf, Type='AxesToolbar'), Visible='off')
exportgraphics(gca, '../avoided_crossing.pdf', ContentType='vector', BackgroundColor='none')
