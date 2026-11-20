figure
T = linspace(0, 1.2, 1201);
% For theta_D/T >= 50 the relative tail of the heat-capacity integral
% is below 6e-17, so its infinite-limit value is sufficient.
C = (12*pi^4/5)*T.^3;
thermal = T > 1/50;
C(thermal) = 9*T(thermal).^3.*arrayfun(@(t) integral(@debyeKernel, 0, 1/t), T(thermal));
p1 = lincomp(plot(T, C, LineWidth=2));
hold on

T0 = linspace(0, 0.234, 1000);
p2 = lincomp(plot(T0, 12*pi^4/5 * T0.^3, 'k--'));

set(gca, Children=[p1 p2])

grid on
xlabel("$T/\theta_{\mathrm{D}}$", Interpreter="latex")
ylabel("$C_V/(Nk_{\mathrm{B}})$", Interpreter="latex")

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, "../C_Vphonon.pdf", ContentType="vector", BackgroundColor="none")


function f = debyeKernel(x)
f = zeros(size(x));
positive = x > 0;
u = x(positive);
f(positive) = u.^4.*exp(-u)./expm1(-u).^2;
end
