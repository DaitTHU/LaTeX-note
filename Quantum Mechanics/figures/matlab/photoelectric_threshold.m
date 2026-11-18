clear
close all

planck = 6.62607015e-34;
charge = 1.602176634e-19;
terahertz = 1e12;
workEV = [2 3];
maxFrequency = 1200;  % THz
threshold = workEV*charge/(planck*terahertz);

figure(Visible='off', Units='centimeters', Position=[2 2 9.2 6.1])
hold on
for index = 1:numel(workEV)
    frequency = [threshold(index) maxFrequency];
    voltage = (frequency-threshold(index))*terahertz*planck/charge;
    plot(frequency, voltage, LineWidth=1.5, DisplayName="$W=" + workEV(index) + "$ eV")
end
xlim([0 maxFrequency])
xlabel('$\nu$ (THz)', Interpreter='latex')
ylabel('$V_{\rm stop}$ (V)', Interpreter='latex')
pad_legend(legend(Location='northwest', Interpreter='latex'));
grid on
exportgraphics(gca, '../photoelectric_threshold.pdf', ContentType='vector', BackgroundColor='none')
