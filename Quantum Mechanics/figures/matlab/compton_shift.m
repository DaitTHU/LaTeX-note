clear
close all

backscatter = 180;  % deg
samples = 181;
angle = linspace(0, backscatter, samples);
shift = 1-cosd(angle);  % Delta lambda / lambda_C

figure(Visible='off', Units='centimeters', Position=[2 2 9.2 6.1])
plot(angle, shift, LineWidth=1.5)
xticks(0:backscatter/4:backscatter)
xlim([0 backscatter])
xlabel('$\theta/{}^\circ$', Interpreter='latex')
ylabel('$(\lambda''-\lambda)/\lambda_C$', Interpreter='latex')
grid on
exportgraphics(gca, '../compton_shift.pdf', ContentType='vector', BackgroundColor='none')
