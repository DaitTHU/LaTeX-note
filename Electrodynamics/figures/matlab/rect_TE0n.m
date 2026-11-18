hold on

mode = "TE";
h = 0.01;
[a, b, L] = deal(4, 2, 10);
[m, ~, p] = deal(0, 1, 2);
kz = p * 2*pi/L;

%% startx, starty
d = 0.1 / n;
yi = b/n * (0:n-1) + linspace(d, b/n-d, (b/n-2*d)/h)';
[x, y] = meshgrid(0:h:a, yi(:)); z = 0.01;
Elnum = ceil(10 / n);
startEy = b/n * ((1:n)' - acos((.5:Elnum-.5)/Elnum*2 - 1) / pi);
startEx = zeros(size(startEy)); startEx(1:2:end, :) = a;
Hlnum = 15;
startHx = repmat((1:Hlnum-1)/Hlnum*a, [n, 1]);
startHy = repmat((1:n)' * b/n - d, [1, Hlnum-1]);
startHy(2:2:end, :) = startHy(2:2:end, :) - b/n + 2*d;

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
