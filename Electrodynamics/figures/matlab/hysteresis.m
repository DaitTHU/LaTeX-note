figure
hold on

theta0 = 0.8 * pi;
Ha = 0.5;

H = -1 : 0.01 : 1;
Hc = Ha * abs(cos(theta0));
M1 = (H + Hc)./ sqrt(H.^2 + Ha^2 + 2 * H * Hc);
M2 = (H - Hc)./ sqrt(H.^2 + Ha^2 - 2 * H * Hc);
dM = (M1(1) - M2(1)) / 2;
M1 = M1 - dM;
M2 = M2 + dM;
Mi = (M1 + M2) / 2;

addarrow(plot(H(H >= 0), Mi(H >= 0), LineWidth=1), '->-', size=0.1)
addarrow(plot([H, flip(H)], [M2, flip(M1)], LineWidth=1), ...
    position=[.2 .4 .7 .9], size=0.1, filled=true)

grid on
xlabel('$H/H_{\max}$', Interpreter='latex')
ylabel('$M/M_{\mathrm{s}}$', Interpreter='latex')
axis equal
axis([-1.2, 1.2, -1, 1])
pad_legend(legend(["initial magnetization", "hysteresis loops"], Location="southeast"));

exportgraphics(gca, "../hysteresis.pdf", ContentType='vector', BackgroundColor='none')
