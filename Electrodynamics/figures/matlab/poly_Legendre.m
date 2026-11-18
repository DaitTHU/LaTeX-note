figure
hold on

x = -1 : .0001 : 1;
for l = 0 : 5
    y = legendre(l, x);
    ln = plot(x, y(1, :), LineWidth=1, DisplayName="$P_{"+l+"}(x)$");
    lincomp(ln, dtheta=1);
end
grid on
xlabel('$x$', Interpreter='latex')
pad_legend(legend(Interpreter='latex', Location='southeast', NumColumns=2));

exportgraphics(gca, '../Legendre.pdf', ContentType='vector', BackgroundColor='none')
