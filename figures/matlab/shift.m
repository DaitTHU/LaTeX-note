function U = shift(V, k, options)

arguments
    V (1, :)
    k (1, 1) {mustBeInteger}
    options.default
end

if ~isfield(options, 'default')
    if islogical(V)
        options.default = false;
    elseif isnumeric(V)
        options.default = 0;
    elseif isstring(V)
        options.default = "";
    end
end

if k > 0
    U = [repelem(options.default, k), V(1:end-k)];
elseif k < 0
    U = [V(1-k:end), repelem(options.default, -k)];
else
    U = V;
end

end
