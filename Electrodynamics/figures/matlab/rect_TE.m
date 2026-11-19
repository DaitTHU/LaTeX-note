figure

mode = "TE";

h = 0.01;
[a, b, L] = deal(4, 2, 10);
% [m, n, p] = deal(1, 0, 2);
p = 2;
kz = p * 2*pi/L;

t = tiledlayout(3, 2, TileSpacing="tight", Padding="tight");

nexttile
hold on
sample = linspace(.65, 2.1, 40);
e = plot(sample, 1.22*ones(size(sample)), '-', Color='#0072B2', LineWidth=1);
hline = plot(sample, .67*ones(size(sample)), '--', Color='#C45116', LineWidth=1);
addarrow([e; hline], size=.12, position=.65)
text(2.35, 1.22, '$\mathbf{E}_{\perp}$', Interpreter='latex', FontSize=14)
text(2.35, .67, '$\mathbf{H}_{\perp}$', Interpreter='latex', FontSize=14)
axis equal
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
cla reset
rect_TM11

exportgraphics(gca, '../waveguide_rect_TM.pdf', ContentType='vector', BackgroundColor='none')
