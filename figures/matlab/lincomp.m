function l = lincomp(lines, options)

%LINCOMP line compression, now only works in linear-scale

arguments
    lines
    options.dtheta = 1
    options.xlim (1, 2) double = [-inf, inf]
    options.ylim (1, 2) double = [-inf, inf]
    options.disp (1, 1) logical = false
end

for kk = 1 : numel(lines)
    [lines(kk).XData, lines(kk).YData] = ...
        xycomp(lines(kk).XData, lines(kk).YData, disp=options.disp, ...
        dtheta=options.dtheta, xlim=options.xlim, ylim=options.ylim);
end

if nargout >= 1
    l = lines;
end

end
