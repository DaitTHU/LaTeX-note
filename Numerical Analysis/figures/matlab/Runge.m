clear
close all

fexpr = @(x) 1./ (1 + 25*x.^2);
a = -1; b = 1; h = 0.001;
x = a : h : b;
f = fexpr(x);

for phenom = ["Runge", "Rungeless"]
    if phenom == "Runge"
        sample = @(n) linspace(a, b, n);  % uniform
        ylimits = [-2.5, 3.5];
    else
        sample = @(n) cospi((2*(1:n) - 1) / (2 * n));  % Chebyshev polynomial zero-point
        ylimits = [0, 1.05];
    end

    figure
    t = tiledlayout(2, 2, TileSpacing="compact", Padding="tight");

    for n = [9 12 15 18]
        xs = sample(n + 1);
        fs = fexpr(xs);
        p = polyval(polyfit(xs, fs, n), x);
        nexttile
        lincomp(plot(x, f, x, p, LineWidth=1), ylim=ylimits, dtheta=0.5)
        hold on
        scatter(xs, fs, 100, '.k')
        grid on
        % grid minor
        ylim(ylimits)
        title("$n = "+n+"$", Interpreter="latex")
    end

    lgd = pad_legend(legend(["$f(x)$", "$p_n(x)$", "sample"], Interpreter="latex"));
    lgd.Layout.Tile = "east";

    fig = gcf;
    fig.Position = [100, 100, 600, 400];

    exportgraphics(t, "../"+phenom+".pdf", ContentType='vector', BackgroundColor='none')
end
