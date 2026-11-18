figure
T = linspace(0, 1.2, 10000);
y = 1./ T;

% U = 3 * T.* Debye(y);
% plot(T, U, LineWidth=2)
% C = diff(U)./ diff(T);
% plot(T, [0 C], LineWidth=2)
C = 3 * (4 * Debye(y) - 3 * y./ (exp(y) - 1));
C(isnan(C)) = 0;
p1 = lincomp(plot(T, C, LineWidth=2));
hold on

T0 = linspace(0, 0.234, 1000);
p2 = lincomp(plot(T0, 12*pi^4/5 * T0.^3, 'k--'));

set(gca, Children=[p1 p2])

grid on
xlabel("$T/\theta_{\mathrm{D}}$", Interpreter="latex")
ylabel("$C_V/Nk_{\mathrm{B}}$", Interpreter="latex")

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../C_Vphonon.pdf", ContentType="vector", BackgroundColor="none")


function D = Debye(Y)
D = zeros(size(Y));
for ii = 1 : numel(Y)
    y = Y(ii);
    if isinf(y)
        D(ii) = 0;
        continue
    end
    x = linspace(0, y, 1000);
    fx = x.^3./ (exp(x) - 1);
    fx(isnan(fx)) = 0;
    D(ii) = 3 / y^3 * trapz(x, fx);
end
end
