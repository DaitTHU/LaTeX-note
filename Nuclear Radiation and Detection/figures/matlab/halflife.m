clear
close all

data = load('inputs/halfLife.mat', 'halfLife');
halfLife = data.halfLife';

for Z = 1 : height(halfLife)
for N = 1 : width(halfLife)
    X = Z + [-1 1 1 -1] / 2;
    Y = N + [-1 -1 1 1] / 2;
    if isnan(halfLife(Z, N))
        continue
    elseif isinf(halfLife(Z, N))
        patch(X, Y, "black", EdgeColor='w', LineWidth=1/72)
        continue
    end
    patch(X, Y, halfLife(Z, N), EdgeColor='w', LineWidth=1/72)
end
end
patch(0.5+[0 Z Z 0], 0.5+[0 0 N N], 'w', FaceColor='none', EdgeColor='k')

xlabel("proton $Z$", Interpreter="latex")
ylabel("neutron $N$", Interpreter="latex")
xticks([2 8 28 50 82])
yticks([2 8 28 50 82 126])
grid on

colormap(sky)
cb = colorbar;
clim([1e-10 1e32])
set(gca, ColorScale="log")
cb.Label.String = "decay half-life [s]";
cb.Label.Interpreter = "latex";

axis equal
axis(0.5 + [0 Z 0 N])

set(gcf, Position=[200 200 600 700])

exportgraphics(gca, "../halflife.pdf", BackgroundColor="none", ContentType="vector")
