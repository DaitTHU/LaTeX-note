function labels = xpi(ticks)

[n, d] = rat(ticks);

labels = strings(size(ticks));
labels(n == 0) = "0";
labels(abs(n) > 1) = string(n(abs(n) > 1));
labels(n == -1) = "-";
labels(n ~= 0) = labels(n ~= 0) + "\pi";
labels(d > 1) = labels(d > 1) + "/" + string(d(d > 1));

end
