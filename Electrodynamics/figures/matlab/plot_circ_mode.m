function plot_circ_mode(ax, mode, m)
% Cross section of the first radial mode, in units of the guide radius.
a = 1;
grid = linspace(-a, a, 321);
[x, y] = meshgrid(grid);
[ex, ey, ~, hx, hy] = wg_circ(mode, m, 1, a, x, y, -pi/2, kz=1);
[~, ~, ez, ~, ~, hz] = wg_circ(mode, m, 1, a, x, y, 0, kz=1);
te = mode == "TE";
if te
    psi = hz;
    cx = ex; cy = ey;  % tangent to the contours of the longitudinal field
    gx = hx; gy = hy;  % parallel to its gradient
else
    psi = ez;
    cx = hx; cy = hy;
    gx = ex; gy = ey;
end
hold(ax, 'on')
axis(ax, 'equal', 'off')
axis(ax, [-1.025 1.025 -1.025 1.025])

if m == 0
    % The contours are concentric circles. Use equal radial spacing.
    phi = linspace(0, 2*pi, 301);
    for r = .2:.2:.8
        draw_contour(r*cos(phi), r*sin(phi), .2 + .5*r)
    end
    seed = .6*exp(1i*(0:11)*pi/6);
    nulls = 0;
    clearance = .075;
else
    levels = max(psi(:), [], 'omitnan') * [-.82 -.58 -.30 .30 .58 .82];
    contours = contourc(grid, grid, psi, levels);
    k = 1;
    while k < size(contours, 2)
        count = contours(2, k);
        curve = contours(:, k+(1:count)).';
        curve = extend_to_wall(curve);
        draw_contour(curve(:,1), curve(:,2), .39)
        k = k + count + 1;
    end

    % Include the zero contour. Opposite rays join smoothly for m = 1;
    % for m = 2 each ray ends at the on-axis transverse-field null.
    nodes = ((0:2*m-1)+.5)*pi/m;
    if m == 1
        draw_contour(zeros(1,101), linspace(-1,1,101), .60)
    else
        for phi = nodes
            r = linspace(.065, 1, 80);
            draw_contour(r*cos(phi), r*sin(phi), .48)
        end
    end

    % Crossing each nodal ray seeds paths connecting adjacent lobes.
    % In TM modes a second family connects the extrema to the conducting wall.
    lobes = (0:2*m-1)*pi/m;
    if te
        seed = [.25; .50; .74; .91]*exp(1i*nodes);
        clearance = .085;
    else
        clearance = .15;
        seed = [.22; .46; .73]*exp(1i*nodes);
        wallAngles = lobes + [-.59; -.25; 0; .25; .59]*pi/(2*m);
        seed = [seed(:); .98*exp(1i*wallAngles(:))];
    end
    % The extrema lie on the lobe axes at the same radius as the x-axis peak.
    [~, peakIndex] = max(psi(grid == 0,:), [], 'omitnan');
    nulls = abs(grid(peakIndex))*exp(1i*lobes);
    if m == 1
        seed = [seed(:); 0];
    else
        seed = [seed(:); .25*exp(1i*lobes(:))];
        clearance = [.075 repmat(clearance, size(nulls))];
        nulls = [0 nulls];
    end
end

forward = stream2(x, y, gx, gy, real(seed(:)), imag(seed(:)), [.5 1800]);
backward = stream2(x, y, -gx, -gy, real(seed(:)), imag(seed(:)), [.5 1800]);
for k = 1:numel(seed)
    left = trim_at_null(backward{k}, nulls, clearance);
    right = trim_at_null(forward{k}, nulls, clearance);
    path = extend_to_wall([flipud(left); right(2:end,:)]);
    if ~te && abs(seed(k)) > .97
        % Put arrows on the outer portion of wall-to-null paths.
        if hypot(path(end,1), path(end,2)) > .97
            arrow = .66;
        else
            arrow = .34;
        end
    else
        arrow = .46;
    end
    draw_line(path(:,1), path(:,2), ~te, arrow)
end
phi = linspace(0, 2*pi, 361);
plot(ax, cos(phi), sin(phi), 'k', LineWidth=1.4)
title(ax, sprintf('$\\mathrm{%s}_{%d1}$', mode, m), Interpreter='latex', FontSize=17)

    function draw_contour(xx, yy, position)
        % Choose the arrow orientation from the actual instantaneous field.
        middle = max(1, round(.36*(numel(xx)-1)));
        vx = interp2(grid, grid, cx, xx(middle), yy(middle));
        vy = interp2(grid, grid, cy, xx(middle), yy(middle));
        if vx*(xx(middle+1)-xx(middle)) + vy*(yy(middle+1)-yy(middle)) < 0
            xx = flip(xx); yy = flip(yy);
        end
        draw_line(xx, yy, te, position)
    end

    function draw_line(xx, yy, electric, position)
        if electric
            line = plot(ax, xx, yy, '-', Color='#0072B2', LineWidth=1.05);
        else
            line = plot(ax, xx, yy, '--', Color='#C45116', LineWidth=1.0);
        end
        addarrow(line, size=.065, position=position, angle=17)
    end
end

function path = trim_at_null(path, nulls, clearance)
points = complex(path(:,1), path(:,2));
stop = find(any(abs(points-nulls) < clearance, 2) | ~isfinite(points), 1);
if ~isempty(stop)
    path = path(1:stop-1,:);
end
end

function path = extend_to_wall(path)
% Interpolation on a Cartesian grid stops one cell inside the circular wall.
for index = [1 size(path, 1)]
    radius = hypot(path(index,1), path(index,2));
    if radius > .988
        path(index,:) = path(index,:)/radius;
    end
end
end
