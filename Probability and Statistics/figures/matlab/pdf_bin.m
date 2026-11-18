clear
close all

t = tiledlayout(2, 2, TileSpacing="compact", Padding="tight");

for n = [10 20 50 100]

nexttile
x = 0 : n;

for p = [0.1 0.3 0.5 0.7 0.9]
    pr = binomial_mass(n, p);
    bar(x, pr, 1, EdgeColor="none", FaceAlpha=0.5, DisplayName="$p="+p+"$")
    hold on
end

title("$n = "+n+"$", Interpreter="latex")
xlim([min(x)-0.5, max(x)+0.5])
xlabel('$k$', Interpreter='latex')
ylabel('${\rm P}(X=k)$', Interpreter='latex')

grid on
% grid minor

end

lgd = pad_legend(legend(Interpreter="latex"));
lgd.Layout.Tile = "east";

set(gcf, Position=[200 200 800 450])

exportgraphics(t, "../pdf_bin.pdf", ContentType='vector', BackgroundColor='none')
