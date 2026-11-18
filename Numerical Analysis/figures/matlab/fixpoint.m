clear
close all

t = tiledlayout("horizontal", Padding="tight");

[a, b] = deal(0, 3);
s = linspace(a, b, 100000);  % sample

Fs(1).fn = @(x) 2 * sin(x / 2.25) + 0.75;
Fs(2).fn = @(x) 2 * cos(x / 2.25) + 0.5;
% Fs(3).fn = @(x) 1.7.^(x) - 0.2;

x = zeros(1, 4);
x(1) = .5;

for F = Fs

    nexttile

    f = F.fn;
    fs = f(s); fs(fs < a | fs > b) = nan;
    lincomp(plot(s, fs, LineWidth=1))
    hold on
    plot([a b], [a b], LineWidth=1)

    x_ = fzero(@(t) f(t)-t, x(1), optimset(Display='off'));
    for ii = 2 : numel(x)
        x(ii) = f(x(ii-1));
    end
    y = [x(2:end) f(x(end))];
    [xx, yy] = deal(repelem(x, 2), repelem(y, 2));
    addarrow(plot(xx(2:end), yy(1:end-1), 'k', LineWidth=1), '>', size=0.1)

    plot([x(1) x(1)], [0 y(1)], '--k')
    for ii = 2 : numel(x)
        plot([0 min(x(ii-1), x(ii))], [y(ii-1) y(ii-1)], '--k')     % horizontal
        plot([x(ii) x(ii)], [0 min(y(ii-1), y(ii))], '--k')         % vertical
    end
    plot([0 x(end)], [y(end) y(end)], '--k')

    plot([x_ x_], [0 x_], '--k')
    plot([0 x_], [x_ x_], '--k')

    [xs, ixs] = sort([x x_]);
    [ys, iys] = sort([y x_]);
    xtl = "$x_{"+(ixs-1)+"}$";
    xtl(ixs==numel(x)+1) = "$x^*$";
    ytl = "$\varphi(x_{"+(iys-1)+"})=x_{"+iys+"}$";
    ytl(iys==numel(x)+1) = "$\varphi(x^*)=x^*$";
    xticks(xs(isfinite(xs))); xticklabels(xtl);
    yticks(ys(isfinite(ys))); yticklabels(ytl);
    set(gca, TickLabelInterpreter="latex")

    axis equal
    axis([0 3 0 3])

end

lgd = pad_legend(legend(["$y=\varphi(x)$", "$y = x$"], interpreter="latex"));
lgd.Layout.Tile = "east";

set(gcf, Position=[200 200 700 300])

exportgraphics(t, "../fixpoint.pdf", ContentType='vector', BackgroundColor='none')
