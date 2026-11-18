% O2

figure

Tv = 2.23e3;
Tr = 2.40;

T = logspace(-2, 5, 10000);
beta = 1./ T;

Ct = 3 / 2;
Cv = Einst(Tv.* beta);

l = (0 : 1000)';
Z = sum((2 * l + 1).* exp(-l.* (l + 1) * Tr./ T));
Z(1) = 1;
U = [0 -diff(log(Z))./ diff(beta)];
Cr = [0 diff(U)./ diff(T)];

[T_, C_] = xycomp(log10(T), Ct + Cv + Cr);
p1 = plot(10.^T_, C_, LineWidth=2);
hold on
p2 = plot([1e-2 1e1], [1 1] * 5/2, 'k--');
p3 = plot([1e-2 1e4], [1 1] * 7/2, 'k--');
p4 = plot([1 1] * Tr, [0 5/2], 'k--');
p5 = plot([1 1] * Tv, [0 7/2], 'k--');

% xline([Tr Tv], 'k--')
% yline([5/2 7/2], 'k--')

set(gca, Children=[p1 p2 p3 p4 p5])

grid on
xscale log
ylim([0 4])
xlabel("$T$ [K]", Interpreter="latex")
ylabel("$C_V/Nk_{\mathrm{B}}$", Interpreter="latex")

text(Tr, -.13, "$\theta_{\mathrm{r}}$", Interpreter="latex")
text(Tv, -.13, "$\theta_{\mathrm{v}}$", Interpreter="latex")

set(gcf, Position=[200 200 700 500])

exportgraphics(gca, "../C_Vtot.pdf", ContentType="vector", BackgroundColor="none")

function y = Einst(x)
y = x.^2.* exp(x)./ (exp(x) - 1).^2;
y(isnan(y)) = 0;
end
