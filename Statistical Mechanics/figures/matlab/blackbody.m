figure
c = 2.998e8;  % m/s
h = 6.626e-34;  % Js
kB = 1.38e-23;  % J/K

lambda = 1e-6 * linspace(0, 3, 1e3);  % um
T = [3000 4000 5000]';  % K

nu = c./ lambda;
hnu = h * nu;
kBT = kB * T;
I = 2 * h * c^2./ (lambda.^5.* (exp(hnu./ kBT) - 1));

p1 = lincomp(plot(1e6 * lambda, 1e-12 * I, LineWidth=1.5));
hold on

I_W = 2 * h * c^2./ (lambda.^5.* exp(hnu./ kBT(end)));
I_RJ = 2 * c * kBT(end)./ lambda.^4;
p2 = lincomp(plot(1e6 * lambda, 1e-12 * I_W, '-.', Color=[1 1 1]*.3));
p3 = lincomp(plot(1e6 * lambda, 1e-12 * I_RJ, 'k--'), ylim=[0 15]);

lr = 380;
lv = 740;
p4 = patch(1e-3 * [lr lv lv lr], 15 * [0 0 1 1], [1 0 0 1], EdgeColor="none", FaceAlpha=.1);
colormap hsv

set(gca, Children=[p1; p2; p3; p4])

xlabel("$\lambda$ [$\mu$m]", Interpreter="latex")
ylabel("$I$ [kW/(sr$\cdot$mm$^3$)]", Interpreter="latex")
ylim([0, 15])

pad_legend(legend([p1; p2; p3], "$T=" + [T + "$ K"; ...
    T(end) + "$ K (" + ["Wien"; "Rayleigh-Jeans"] + ")"], ...
    Interpreter="latex"));
grid on

box on
set(gcf, Units='pixels', Position=[200 200 600 396])

exportgraphics(gca, '../blackbody.pdf', ContentType='vector', BackgroundColor='none')
