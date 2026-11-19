% Meridional section of the two dielectric half-spaces, in units of d.
% The real charge is at (z,x)=(1,0); the interface is z=0.
figure(Position=[100 100 760 330])
layout = tiledlayout(1, 2, TileSpacing='compact', Padding='compact');
zLeft = -1.6;
zRight = 2.5;
xTop = 1.5;

% Specify the crossings to compare the two refraction angles at the same
% position. Other field lines end on the top or right edge of the view.
edges = [0 0 0 0 .42 1.04 1.68 2.30 zRight zRight;
         .19 .50 .85 1.22 xTop xTop xTop xTop .79 .25];
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
for ratio = [3, 1/3]
    nexttile
    hold on
    xline(0, 'k', LineWidth=1)
    imageCharge = (1-ratio)/(1+ratio);  % q'/q in medium 1

    for edge = edges
        rEdge = norm(edge-[1; 0]);
        [~, path] = ode45(@(r,p) fieldByRadius(r, p, imageCharge), ...
            linspace(rEdge, .025, 70), edge, options);
        path = flipud(path);
        z = path(:,1);
        x = path(:,2);
        if edge(1) == 0
            % In medium 2 the field is radial about the real charge's
            % position, so x(z) = x(0)*(1-z) through the crossing.
            zEnd = max(zLeft, 1-xTop/edge(2));
            tail = linspace(0, zEnd, 40)';
            z = [z; tail(2:end)];
            x = [x; edge(2)*(1-tail(2:end))];
        end
        lines = plot([z z], [x -x], 'k', LineWidth=1);
        addarrow(lines, '->', size=.13, angle=10)
    end

    scatter(1, 0, 100, 'ok', LineWidth=1, MarkerFaceColor='w')
    scatter(-1, 0, 75, 'ok', LineWidth=1, MarkerFaceColor='#777777')
    if ratio > 1
        leftLabel = '$\varepsilon_2=3\varepsilon_1$';
    else
        leftLabel = '$\varepsilon_2=\varepsilon_1/3$';
    end
    text([-.8 1.1], [1 1]*(xTop+.16), {leftLabel, '$\varepsilon_1$'}, ...
        Interpreter='latex', FontSize=15, HorizontalAlignment='center')
    axis equal off
    axis([zLeft zRight -xTop xTop+.30])
end
exportgraphics(layout, '../image_charge_dielectrics.pdf', ContentType='vector', BackgroundColor='none')

function tangent = fieldByRadius(~, point, imageCharge)
% Along a field line dr/ds = Ehat dot rhat. Radius about the real charge
% increases throughout z>=0 because |q'|<q and the image is farther away.
fromSource = point - [1; 0];
fromImage = point + [1; 0];
field = fromSource/norm(fromSource)^3 + imageCharge*fromImage/norm(fromImage)^3;
tangent = field/dot(field, fromSource/norm(fromSource));
end
