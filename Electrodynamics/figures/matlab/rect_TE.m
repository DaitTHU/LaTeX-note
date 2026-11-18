figure

mode = "TE";

h = 0.01;
[a, b, L] = deal(4, 2, 10);
% [m, n, p] = deal(1, 0, 2);
p = 2;
kz = p * 2*pi/L;

t = tiledlayout(3, 2, TileSpacing="tight", Padding="tight");

nexttile
axis off
axis([0 a 0 b])

nexttile
n = 1;
rect_TE0n

nexttile
m = 1; %#ok<*NASGU>
rect_TEm0

nexttile
rect_TE11

nexttile
m = 2;
rect_TEm0

nexttile
rect_TE21

set(gcf, Position=100+[0 0 600 500])

exportgraphics(t, '../waveguide_rect_TE.pdf', ContentType='vector', BackgroundColor='none')

nexttile(1)
rect_TM11

exportgraphics(gca, '../waveguide_rect_TM.pdf', ContentType='vector', BackgroundColor='none')
