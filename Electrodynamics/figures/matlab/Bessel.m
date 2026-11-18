x = 0 : .001 : 20;
NU = 0 : 3;

figure
hold on
for nu = NU
    lincomp(plot(x, besselj(nu, x), LineWidth=1), ylim=[-.6 1])
end
grid on
xlabel('$x$', Interpreter='latex')
ylim([-0.6, 1])
pad_legend(legend("$J_{"+NU+"}(x)$", Interpreter='latex'));
exportgraphics(gca, '../BesselJ.pdf', ContentType='vector', BackgroundColor='none')

figure
hold on
for nu = NU
    lincomp(plot(x, besseljp(nu, x), LineWidth=1), ylim=[-.8 .8])
end
grid on
xlabel('$x$', Interpreter='latex')
ylim([-0.8, 0.8])
pad_legend(legend("$J'_{"+NU+"}(x)$", Interpreter='latex'));
exportgraphics(gca, '../BesselJp.pdf', ContentType='vector', BackgroundColor='none')

figure
hold on
for nu = NU
    lincomp(plot(x, bessely(nu, x), LineWidth=1), ylim=[-1 .6])
end
grid on
xlabel('$x$', Interpreter='latex')
ylim([-1, 0.6])
pad_legend(legend("$Y_{"+NU+"}(x)$", Interpreter='latex', Location='southeast'));
exportgraphics(gca, '../BesselY.pdf', ContentType='vector', BackgroundColor='none')
