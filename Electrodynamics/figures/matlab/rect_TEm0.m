hold on

mode = "TE";
h = 0.01;
[a, b, L] = deal(4, 2, 10);
[~, n, p] = deal(1, 0, 2);
kz = p * 2*pi/L;

%% startx, starty
d = 0.2 / m;
xi = a/m * (0:m-1) + linspace(d, a/m-d, (a/m-2*d)/h)';
[x, y] = meshgrid(xi(:), 0:h:b); z = 0.01;
Elnum = ceil(20 / m);
startEx = a/m * ((1:m)' - acos((.5:Elnum-.5)/Elnum*2 - 1) / pi);
startEy = zeros(size(startEx)); startEy(2:2:end, :) = b;
Hlnum = 10;
startHy = repmat((1:Hlnum-1)/Hlnum*b, [m, 1]);
startHx = repmat((1:m)' * a/m - d, [1, Hlnum-1]);
startHx(2:2:end, :) = startHx(2:2:end, :) - a/m + 2*d;

[Ex, Ey, ~, Hx, Hy, ~] = wg_rect(mode, m, n, a, b, x, y, z, kz=kz);

%% plot
Eline = streamline(x, y, -Ex, -Ey, startEx, startEy);
Hline = streamline(x, y, -Hx, -Hy, startHx, startHy);
set(Eline, LineWidth=1, Color='b')
set(Hline, LineWidth=1, Color='r', LineStyle='--')
addarrow([Hline; Eline], size=0.12, position=0.52)
lincomp([Eline; Hline], disp=false)

plot([a a 0 0 a a], [0 b b 0 0 b], 'k', LineWidth=2)
axis equal off
axis([0 a 0 b])
title(mode+"$_{"+m+n+"}$", Interpreter="latex")
