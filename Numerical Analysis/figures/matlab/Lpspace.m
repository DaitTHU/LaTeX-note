clear
close all
clc

format rational
hold on

h = 0.001;
theta = h : h : pi/2;  % 1.57079

for p = [2/3 1 1.5 2 3 6]
    x1 = cos(theta).^(2/p);
    y1 = sin(theta).^(2/p);
    x = [1, x1, 0, flip(-x1), -1, -x1, 0, flip(x1), 1];
    y = [0, y1, 1, flip(y1), 0, -y1, -1, flip(-y1), 0];
    lincomp(plot(x, y, LineWidth=1.5, DisplayName="$p="+rats(p)+"$"));
end

plot([1 -1 -1 1 1], [1 1 -1 -1 1], LineWidth=1.5, DisplayName="$p=\infty$")

xlabel('$x$', Interpreter='latex')
ylabel('$y$', Interpreter='latex')

axis equal
axis([-1 1 -1 1])

pad_legend(legend(Interpreter="latex", Location="eastoutside"));

set(gcf, Position=[200 200 600 400])

exportgraphics(gca, '../Lpspace.pdf', ContentType='vector', BackgroundColor='none')
