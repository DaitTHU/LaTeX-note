figure
alpha = [-40 : -11, -10 : .1 : 1.3];
fHalf = fermiIntegral(.5, alpha);
fThreeHalves = fermiIntegral(1.5, alpha);
fFiveHalves = fermiIntegral(2.5, alpha);
T = (fThreeHalves * 3 * sqrt(pi) / 4).^(-2/3);
C = 15/4 * fFiveHalves ./ fThreeHalves - 9/4 * fThreeHalves ./ fHalf;

p1 = lincomp(plot([0 T], [0 C], LineWidth=2), disp=true);
hold on
t0 = [0 0.31];
p2 = plot(t0, pi^2/2*t0, 'k--');

set(gca, Children=[p1 p2])

xlabel("$T/T_{\mathrm{F}}$", Interpreter="latex")
ylabel("$C_V/(Nk_{\mathrm{B}})$", Interpreter="latex")

grid on
axis([0 2 0 1.5])

set(gcf, Position=[200 200 600 450])

exportgraphics(gca, "../C_VFermion.pdf", ContentType="vector", BackgroundColor="none")

% Fermi integral F_s(alpha) = -Li_s(-exp(-alpha)).
function F = fermiIntegral(s, alpha)
F = arrayfun(@(a) integral(@(u) 2*u.^(2*s-1)./(exp(u.^2+a)+1), 0, Inf), alpha) / gamma(s);
end
