clear
close all

x = linspace(-3, 3, 50);
f = exp(-x.^2/2) / sqrt(2*pi);

surf(x, x, f.* f')
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
zlabel("$f(x_1,x_2)$", Interpreter="latex")

view(60, 30)

set(gcf, Position=[200 200 600 500])

exportgraphics(gca, "../pdf_norm2.pdf", ContentType="vector", BackgroundColor="none")
