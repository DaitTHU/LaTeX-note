function [x_, y_] = xycomp(x, y, options)

%XYCOMP (x, y) data compression

arguments
    x (1, :)
    y (1, :)
    options.dtheta = 1
    options.xlim (1, 2) double = [-inf, inf]
    options.ylim (1, 2) double = [-inf, inf]
    options.disp (1, 1) logical = false
end

% exclude: nan/inf
valid = options.xlim(1) < x & x < options.xlim(2) & ...
    options.ylim(1) < y & y < options.ylim(2);
consider = shift(valid, 1) | valid | shift(valid, -1);
x_ = x(consider);
y_ = y(consider);
if numel(x_) < 2
    return
end
% normalize
dx = betternorm(diff(x_), x(valid));
dy = betternorm(diff(y_), y(valid));
theta = atan2d(dy, dx);

ii = 1;
keep = false(size(x_));
while true
    keep(ii) = true;
    di = find(~(includeabs(theta(ii+1:end), theta(ii)) <= options.dtheta), 1);
    if isempty(di)
        keep(end) = true;
        break
    end
    ii = ii + di;
end
x_ = x_(keep);
y_ = y_(keep);
if options.disp
    disp(numel(x)+" / "+numel(x_))
end

end


function xnorm = betternorm(x, rho)

[rhomax, rhomin] = bounds(rho);
rhorange = rhomax - rhomin;
if rhorange == 0
    xnorm = x;
else
    xnorm = x / rhorange;
end

end

function absdtheta = includeabs(theta1, theta2)

absdtheta = abs(theta1 - theta2);
absdtheta(absdtheta > 180) = 360 - absdtheta(absdtheta > 180);

end
