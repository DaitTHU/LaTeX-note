figure
alpha = unique([linspace(0, .2, 1000) linspace(.2, 2, 1000)]);

% Bose
xi = polylog(1.5, exp(-alpha));
beta = xi.^(2/3) * 0.5272010688;  % 0.5272 = zeta(3/2)^(-2/3)
T = 1./ beta;
lnXi = polylog(2.5, exp(-alpha))./ xi;
% U = [0.774684183515423 -diff(lnXi)./ diff(beta)];
U = 3/2 * lnXi./ beta;
C = diff(U)./ diff(T);

% Bose-Einstein
T0 = linspace(0, 1);
Cmax = 1.925671675;  % = 15zeta(5/2) / 4zeta(3/2)
C0 = Cmax * T0.^1.5;
p1 = lincomp(plot([T0 T(2:end)], [C0 C], LineWidth=2), disp=true);
hold on
p2 = plot([1 1], [0 Cmax], 'k--');
p3 = plot([0 1], [1 1] * Cmax, 'k--');
p4 = plot([0 4], [1 1] * 1.5, 'k--');

% xiF = -polylog(1.5, -exp(-alpha));

set(gca, Children=[p1 p2 p3 p4])
grid on
xlim([0 4])
yticks(0:.5:2)
text(-.05, Cmax, "1.926", HorizontalAlignment="right")
xlabel("$T/T_{\mathrm{C}}$", Interpreter="latex")
ylabel("$C_V/(Nk_{\mathrm{B}})$", Interpreter="latex")

set(gcf, Position=[200 200 600 450])

exportgraphics(gca, "../C_VBoson.pdf", ContentType="vector", BackgroundColor="none")

function y = polylog(n, z)
k = (1 : 50000)';
weights = k.^(-n);
y = arrayfun(@(value) sum(value.^k .* weights), z);
end
