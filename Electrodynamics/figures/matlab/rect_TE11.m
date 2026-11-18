hold on

mode = "TE";
h = 0.01;
[a, b, L] = deal(4, 2, 10);
[m, n, p] = deal(1, 1, 2);
kz = p * 2*pi/L;

%% startx, starty
[x, y] = meshgrid(0:h:a, 0:h:b); z = 0.01;
theta = [0.5 1.2 2 5 20 60];
k = 0.1;
startHx = [1-k*cosd(theta), k*cosd(theta)] * a;
startHy = [k*sind(theta), 1-k*sind(theta)] * b;
Elnum = 12;
startEx = repmat(linspace(0, a, Elnum), [1, 2]);
startEy = repelem([0, b], Elnum);

[Ex, Ey, ~, Hx, Hy, ~] = wg_rect(mode, m, n, a, b, x, y, z, kz=kz);

%% plot
Eline = streamline(x, y, -Ex, -Ey, startEx, startEy);
Hline = streamline(x, y, -Hx, -Hy, startHx, startHy);
for ii = 1 : numel(Hline)
    lx = Hline(ii).XData; ly = Hline(ii).YData;
    keep = ((1-lx/a).^2 + (1-ly/b).^2 > k^2) & ((lx/a).^2 + (ly/b).^2 > k^2);
    Hline(ii).XData = lx(keep); Hline(ii).YData = ly(keep);
end
set(Eline, LineWidth=1, Color='b')
set(Hline, LineWidth=1, Color='r', LineStyle='--')
addarrow([Hline; Eline], size=0.12, position=0.52)
lincomp([Eline; Hline], disp=false)

plot([a a 0 0 a a], [0 b b 0 0 b], 'k', LineWidth=2)
axis equal off
axis([0 a 0 b])
title(mode+"$_{"+m+n+"}$", Interpreter="latex")
