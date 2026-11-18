figure
hold on

[a, b, d, h] = deal(4, 3, 2.0005, 0.01);
[x, y] = meshgrid(0:h:a, -b:h:b);

Phi = 1./ hypot(x - d, y) - 1./ hypot(x + d, y);
[Ex, Ey] = gradient(-Phi, h);

theta = 10 : 20 : 360-10;
startx = d - 2 * h * cosd(theta);
starty = 2 * h * sind(theta);
sl1 = lincomp(streamline(x, y, Ex, Ey, startx, starty), disp=false);
sl2 = lincomp(streamline(-x, y, -Ex, Ey, -startx, starty), disp=false);
set(sl1, LineWidth=1, Color='k')
set(sl2, LineWidth=1, Color='k', LineStyle='--')
addarrow(sl1, '->', size=.25, angle=10)
xline(0, 'k', LineWidth=1)
scatter(d, 0, 100, 'ok', LineWidth=1, MarkerFaceColor='w')
scatter(-d, 0, 100, 'ok', LineWidth=1, MarkerFaceColor='#777777')
% text([1 -1]*(d+.25), [1 1]*-.5, ["$q$", "$q'$"], Interpreter='latex', ...
%     HorizontalAlignment='center', FontSize=15)
text(0, b, "$~\Phi=0$", Interpreter='latex', FontSize=15)
% level = [1 2 3 5 8 15] / 10;
% level = [flip(-level)  level];
% contour(x, y, Phi, level, '--k', LineWidth=1)

axis equal off
axis([-a a -b b])

exportgraphics(gca, '../image_charge_plane.pdf', ContentType='vector', BackgroundColor='none')
