for mode = ["line", "circ", "elli"]
    figure
    hold on
    if mode == "line"
        [Exm, Eym, delta, phi0] = deal(2, 1, 0, pi/3);
    elseif mode == "circ"
        [Exm, Eym, delta, phi0] = deal(2, 2, -pi/2, pi/4);
    elseif mode == "elli"
        [Exm, Eym, delta, phi0] = deal(2, 1, -pi/3, pi/3);
    end

    kzm = 3 * pi;
    yline(0)

    kz = 0 : .1 : kzm;
    [xx, yy] = E(kz, Exm, Eym, delta, phi0);
    plot3(kz, xx, yy, '--')

    if mode == "line"
        kz = [-phi0, pi-phi0];
    else
        kz = 0 : .1 : 6.3;
        kz(1:4:end) = nan;
    end
    [xx, yy] = E(kz, Exm, Eym, delta, phi0);
    plot3(zeros(size(xx)), xx, yy, '--', Color='#888888')

    kz = 0 : pi/8 : kzm;
    [x, y] = E(kz, Exm, Eym, delta, phi0);
    O = zeros(size(kz)); NAN = NaN(size(kz));
    theta = 30 * [-1; 0; 1];
    d = .2 * [1; 0; 1];
    t1 = [kz; kz; NAN; kz + d.* sind(theta)];
    coef = 1 - 1./ hypot(x, y).* d.* cosd(theta);
    x1 = [O; x; NAN; x.* coef];
    y1 = [O; y; NAN; y.* coef];
    plot3(t1, x1, y1, LineWidth=1, Color=lines(1))

    grid on
    axis equal
    axis([[0, kzm], Exm*[-1, 1], Eym*[-1, 1]])
    xticks(0 : pi/2 : kzm)
    xticklabels(xpi(xticks / pi))
    xlabel('$kz$', Interpreter='latex')
    ylabel('$E_{\epsilon_1}/E_{\mathrm{ref}}$', Interpreter='latex')
    zlabel('$E_{\epsilon_2}/E_{\mathrm{ref}}$', Interpreter='latex')
    view(45, 15)
    exportgraphics(gca, "../polarization_" + mode + ".pdf", ...
        ContentType="vector", BackgroundColor="none")
end

function [Ex, Ey] = E(kz, Exm, Eym, delta, phi0)
Ex = real(Exm * exp(1i * (kz + phi0)));
Ey = real(Eym * exp(1i * (kz + delta + phi0)));
end
