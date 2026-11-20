% Single-excitation dynamics. Frequencies in units of g, time in units of 1/g.
gammaBg = 0.01;
kappa = 40;
time = linspace(0, 32, 321);
detuning = [0, kappa/2];
population = zeros(2, numel(time));
for j = 1:numel(detuning)
    generator = [-gammaBg/2, -1i; -1i, 1i*detuning(j)-kappa/2];
    for k = 1:numel(time)
        evolution = expm(generator*time(k));
        population(j,k) = abs(evolution(1,1))^2;
    end
end

kappa = 0.20;
delta = linspace(-1.6, 1.6, 1201);
spectrum = 1./abs((kappa/2-1i*delta).*(gammaBg/2-1i*delta)+1).^2;
blue = [0.08 0.30 0.46];
orange = [0.67 0.30 0.11];
fig = figure(Units="centimeters", Position=[2 2 15.8 6.2]);
layout = tiledlayout(fig, 1, 2, TileSpacing="compact", Padding="compact");
ax = nexttile(layout);
plot(ax, time, population(1,:), "-", Color=blue, LineWidth=1.6)
hold(ax, "on")
plot(ax, time, population(2,:), "--", Color=orange, LineWidth=1.6)
xlim(ax, [0 32])
ylim(ax, [0 1.04])
xlabel(ax, "$gt$", Interpreter="latex")
ylabel(ax, "$P_{\rm e}$", Interpreter="latex")
legend(ax, ["$\Delta=0$","$\Delta=\kappa/2$"], ...
    Interpreter="latex", Location="northeast", Box="off")
ax.FontSize = 10;
ax.TickDir = "out";

ax = nexttile(layout);
plot(ax, delta, spectrum/max(spectrum), Color=blue, LineWidth=1.6)
xlim(ax, [-1.6 1.6])
ylim(ax, [0 1.04])
xticks(ax, [-1 0 1])
xlabel(ax, "$(\omega-\omega_{\rm c})/g$", Interpreter="latex")
ylabel(ax, "$S_{\rm out}/S_{\rm max}$", Interpreter="latex")
ax.FontSize = 10;
ax.TickDir = "out";
exportgraphics(layout, "../cavity_decay_spectrum.pdf", ContentType="vector", BackgroundColor="white")
