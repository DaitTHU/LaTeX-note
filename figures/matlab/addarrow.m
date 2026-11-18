function arrows = addarrow(lines, style, options)
arguments
    lines
    style (1, 1) string = '->'
    options.position (1, :) {mustBeNumeric} = []
    options.positiontype {mustBeMember(options.positiontype, ...
        ["index", "normedindex", "normedlength", "auto"])} = "auto"
    % options.lengthinterp (1, 1) logical = false
    options.size (1, 1) {mustBePositive} = inf  % default: auto size
    options.angle (1, 1) {mustBeReal} = 15
    options.filled (1, 1) logical = true
end

for ii = 1 : numel(lines)

    l = lines(ii);
    x = l.XData; y = l.YData;

    if numel(x) < 2
        continue
    end

    indices = utils.deal_arrowindex(x, y, style, options.position, options.positiontype);

    %% plot arrow
    ax = gca;
    oldColorOrderIndex = ax.ColorOrderIndex;
    ax.ColorOrderIndex = 1 + mod(l.SeriesIndex - 1, height(ax.ColorOrder));

    if isinf(options.size)
        options.size = hypot(max(x)-min(x), max(y)-min(y)) * 0.05;
    end

    if options.filled
        d = options.size * [cosd(options.angle) 1 0 1];
        theta = options.angle * [0 -1 0 1];
    else
        d = options.size * [1 0 1];
        theta = options.angle * [-1 0 1];
    end

    for jj = numel(indices):-1:1
        index = abs(indices(jj));
        thetai = atan2d(y(index+1)-y(index), x(index+1)-x(index)) + theta;
        if imag(indices(jj)) ~= 0  % inverse
            xa = x(index) + d.* cosd(thetai);
            ya = y(index) + d.* sind(thetai);
        else
            xa = x(index+1) - d.* cosd(thetai);
            ya = y(index+1) - d.* sind(thetai);
        end
        if options.filled
            arrow = patch(xa, ya, l.Color, EdgeColor=l.Color, LineWidth=l.LineWidth, ...
                SelectionHighlight='off', HandleVisibility='off');
        else
            arrow = line(xa, ya, Color=l.Color, ...
                LineWidth=l.LineWidth, LineStyle=l.LineStyle, ...
                SelectionHighlight='off', HandleVisibility='off');
        end
        if nargout > 0
            arrows(jj, 1) = arrow;
        end
    end

    ax.ColorOrderIndex = oldColorOrderIndex;

end

end
