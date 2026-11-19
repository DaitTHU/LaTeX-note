hold on

mode = "TM";
h = 0.01;
[a, b, L] = deal(4, 2, 10);
[m, n, p] = deal(1, 1, 2);
kz = p * 2*pi/L;

%% startx, starty
[x, y] = meshgrid(0:h:a, 0:h:b); z = 0.01;
Elxnum = 10; Elynum = 5;
startEx = [repmat(linspace(0, a, Elxnum), [1, 2]), repelem([0, a], Elynum)];
startEy = [repelem([0, b], Elxnum), repmat(linspace(0, b, Elynum), [1, 2])];
Hlnum = 7;
startHy = (1:Hlnum-1)/Hlnum * b/2;
startHx = repmat(a/2, size(startHy));

[Ex, Ey, ~, Hx, Hy, ~] = wg_rect(mode, m, n, a, b, x, y, z, kz=kz);

%% plot
Eline = streamline(x, y, -Ex, -Ey, startEx, startEy);
for ii = 1 : numel(Eline)
    lx = Eline(ii).XData; ly = Eline(ii).YData;
    keep = (5.5*(lx/a - 1/2)).^2 + (5.5*(ly/b - 1/2)).^2 > 1;
    Eline(ii).XData = lx(keep); Eline(ii).YData = ly(keep);
end
Hline = streamline(x, y, -Hx, -Hy, startHx, startHy);
for ii = 1 : numel(Hline)
    lx = Hline(ii).XData; ly = Hline(ii).YData;
    index = xorindex(atan2d(ly-b/2, lx-a/2) > -90);
    Hline(ii).XData = lx(1:index(2)); Hline(ii).YData = ly(1:index(2));
end

set(Eline, LineWidth=1, Color='#0072B2')
set(Hline, LineWidth=1, Color='#C45116', LineStyle='--')
addarrow([Hline; Eline], size=0.12, position=0.5)
lincomp([Eline; Hline], disp=false)

plot([a a 0 0 a a], [0 b b 0 0 b], 'k', LineWidth=2)
axis equal off
axis([0 a 0 b])
title(mode+"$_{"+m+n+"}$", Interpreter="latex")

% set(gcf, Position=100+[0 0 300 200])
