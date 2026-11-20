% Fixed electric dipole in vacuum at distance h from a perfectly conducting plane.
hOverLambda = linspace(0, 1.5, 601);
x = 4*pi*hOverLambda(2:end);
j0 = sin(x)./x;
j1OverX = (j0 - cos(x))./x.^2;
normal = [2, 1 + 3*j1OverX];
parallel = [0, 1 - (3/2)*(j0-j1OverX)];

fig = figure(Units="centimeters", Position=[2 2 13 6.5]);
ax = axes(fig);
hold(ax, "on")
yline(ax, 1, ":", Color=[0.44 0.44 0.44], HandleVisibility="off");
plot(ax, hOverLambda, normal, "-", Color=[0.08 0.30 0.46], LineWidth=1.6)
plot(ax, hOverLambda, parallel, "--", Color=[0.67 0.30 0.11], LineWidth=1.6)
xlim(ax, [0 1.5])
ylim(ax, [0 2.1])
xticks(ax, 0:0.25:1.5)
yticks(ax, 0:0.5:2)
ax.FontSize = 10;
ax.TickDir = "out";
ax.Box = "on";
xlabel(ax, "$h/\lambda$", Interpreter="latex")
ylabel(ax, "$P/P_0$", Interpreter="latex")
legend(ax, ["$P_\perp$","$P_\parallel$"], Interpreter="latex", ...
    Location="northeast", Orientation="horizontal", Box="off")
exportgraphics(fig, "../mirror_dipole_power.pdf", ContentType="vector", BackgroundColor="white")
