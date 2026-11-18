figure
x = 0 : .001 : 20;
NU = 0 : 3;

hold on
yline(0, HandleVisibility="off")
for nu = NU
    [Jzero, num] = besseljzeros(nu, xmax=max(x));
    l = lincomp(plot(x, besselj(nu, x), LineWidth=1));
    [l.XData, index] = sort([Jzero, l.XData]);
    l.YData = [zeros(1, num), l.YData]; l.YData = l.YData(index);
    Jzeroindex = perminv(index, 1:num);
    set(l, Marker='.', MarkerIndices=Jzeroindex, MarkerSize=15)
end
grid on
xlabel('$x$', Interpreter='latex')
ylim([-0.6, 1])
pad_legend(legend("$J_{"+NU+"}(x)$", Interpreter='latex'));

exportgraphics(gca, '../BesselJzero.pdf', ContentType='vector', BackgroundColor='none')

figure
hold on
yline(0, HandleVisibility="off")
for nu = NU
    [Jpzero, num] = besseljpzeros(nu, xmax=max(x));
    l = lincomp(plot(x, besseljp(nu, x), LineWidth=1));
    [l.XData, index] = sort([Jpzero, l.XData]);
    l.YData = [zeros(1, num), l.YData]; l.YData = l.YData(index);
    Jpzeroindex = perminv(index, 1:num);
    set(l, Marker='.', MarkerIndices=Jpzeroindex, MarkerSize=15)
end
grid on
xlabel('$x$', Interpreter='latex')
ylim([-0.8, 0.8])
pad_legend(legend("$J'_{"+NU+"}(x)$", Interpreter='latex'));

exportgraphics(gca, '../BesselJpzero.pdf', ContentType='vector', BackgroundColor='none')
