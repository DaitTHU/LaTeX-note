figure
hold on

[r, d, h] = deal(1.01, 2.0005, 0.01);
q = r/d;
[x, y] = meshgrid(-4:h:4, -3:h:3);

Phi = 1./ sqrt((x - d).^2 + y.^2) - q./ sqrt((x - q^2*d).^2 + y.^2);
[Ex, Ey] = gradient(-Phi, h);
inside = (x.^2 + y.^2 < r^2);

theta = 0 : 15 : 360-10;
startx = d - 2 * h * cosd(theta);
starty = 2 * h * sind(theta);
sl = streamline(x, y, Ex, Ey, startx, starty);
for l = sl'
    inside = (l.XData.^2 + l.YData.^2 < r^2);
    lincomp(plot(l.XData(inside), l.YData(inside), 'k--', LineWidth=1), disp=false)
    l.XData = l.XData(~inside);
    l.YData = l.YData(~inside);
end
lincomp(sl, disp=false)
set(sl, LineWidth=1, Color='k')
addarrow(sl, '->', size=.25, angle=10, positiontype='normedlength')
theta = 0 : 360;
plot(r * cosd(theta), r * sind(theta), 'k', LineWidth=1)
scatter(d, 0, 100, 'ok', LineWidth=1, MarkerFaceColor='w')
scatter(r^2/d, 0, q*100, 'ok', LineWidth=1, MarkerFaceColor='#777777')
% scatter([r^2/d d], [0 0], 50, 'ok', 'filled')
text(0, r, "$\Phi=0$", Interpreter='latex', FontSize=15, ...
    HorizontalAlignment='right', VerticalAlignment='bottom')

axis equal off
axis([-2 4 -3 3])

exportgraphics(gca, '../image_charge_sphere.pdf', ContentType='vector', BackgroundColor='none')
