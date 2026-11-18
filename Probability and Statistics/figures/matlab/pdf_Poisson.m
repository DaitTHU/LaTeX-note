clear
close all

x = 0 : 100;

for lambda = [10 30 50 70 90]
    pr = exp(x*log(lambda) - lambda - gammaln(x+1));
    bar(x, pr, 1, EdgeColor="none", FaceAlpha=0.5, DisplayName="$\lambda="+lambda+"$")
    hold on
end

xlim([min(x), max(x)])
xlabel('$k$', Interpreter='latex')
ylabel('${\rm P}(X=k)$', Interpreter='latex')

grid on

pad_legend(legend(Interpreter="latex", Location="eastoutside"));

set(gcf, Position=[200 200 800 300])

exportgraphics(gca, "../pdf_poission.pdf", ContentType="vector", BackgroundColor="none")
