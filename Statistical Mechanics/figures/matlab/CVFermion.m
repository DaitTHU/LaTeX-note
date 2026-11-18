figure
alpha = -10 : 0.1 : 1.3;

% Fermi
xi = fermiIntegral(1.5, alpha);
beta = (xi * 3 * sqrt(pi) / 4).^(1/1.5);
T = 1./ beta;
lnXi = fermiIntegral(2.5, alpha)./ xi;
U = 3/2 * lnXi./ beta;
C = diff(U)./ diff(T);

p1 = lincomp(plot([0 T(2:end)], [0 C], LineWidth=2), disp=true);
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
F = arrayfun(@(a) integral(@(x) x.^(s-1)./(exp(x+a)+1), 0, Inf), alpha) / gamma(s);
end
