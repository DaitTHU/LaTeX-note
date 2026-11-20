figure
% Fixed density: T/Tc = [zeta(3/2)/Li_{3/2}(exp(-alpha))]^(2/3).
% Use the limiting value at Tc separately because Li_{1/2}(1) diverges.
alpha = [logspace(-6, -1, 120), linspace(.11, 2, 190)];
gHalf = boseIntegral(.5, alpha);
gThreeHalves = boseIntegral(1.5, alpha);
gFiveHalves = boseIntegral(2.5, alpha);
zetaThreeHalves = 2.612375348685488;
zetaFiveHalves = 1.341487257250917;
T = (zetaThreeHalves ./ gThreeHalves).^(2/3);
C = 15/4 * gFiveHalves ./ gThreeHalves - 9/4 * gThreeHalves ./ gHalf;

T0 = linspace(0, 1);
Cmax = 15/4 * zetaFiveHalves / zetaThreeHalves;
C0 = Cmax * T0.^1.5;
p1 = lincomp(plot([T0 T], [C0 C], LineWidth=2), disp=true);
hold on
p2 = plot([1 1], [0 Cmax], 'k--');
p3 = plot([0 1], [1 1] * Cmax, 'k--');
p4 = plot([0 4], [1 1] * 1.5, 'k--');

set(gca, Children=[p1 p2 p3 p4])
grid on
xlim([0 4])
yticks(0:.5:2)
text(-.05, Cmax, "1.926", HorizontalAlignment="right")
xlabel("$T/T_{\mathrm{C}}$", Interpreter="latex")
ylabel("$C_V/(Nk_{\mathrm{B}})$", Interpreter="latex")

set(gcf, Position=[200 200 600 450])

exportgraphics(gca, "../C_VBoson.pdf", ContentType="vector", BackgroundColor="none")

function g = boseIntegral(s, alpha)
% The substitution x = u^2 removes the square root at the lower limit.
g = arrayfun(@(a) integral(@(u) 2*u.^(2*s-1)./expm1(u.^2+a), 0, Inf), alpha) / gamma(s);
end
