function indices = deal_arrowindex(x, y, style, position, positiontype)
arguments
    x (:, 1)
    y (:, 1)
    style (1, 1) string
    position (1, :)
    positiontype (1, 1) string
end

linesize = numel(x);

if positiontype == "auto"
    if all(abs(position) <= 1)
        positiontype = "normedlength";
    else
        positiontype = "index";
    end
end

if positiontype == "index"
    index = position;
    normed = [];
else
    index = [];
    normed = position;
end

%% parse style

if isempty(position)
    % arrow itself
    if style == ">" || style == ">|" || style == "|>"
        % index(end+1) = -1;
        index = 1 : numel(x) - 1;
    elseif style == "<" || style == "|<" || style == "<|"
        index = 1i * (1 : numel(x) - 1);
    else
        % start with arrow
        if startsWith(style, [">", "|>"])
            index(end+1) = 1;
        elseif startsWith(style, ["<", "|<"])
            index(end+1) = 1i;
        end
        % end with arrow
        if endsWith(style, [">", ">|"])
            index(end+1) = -1;
        elseif endsWith(style, ["<", "<|"])
            index(end+1) = -1i;
        end
        % middle arrow
        if contains(style, ["->-", "->|-", "-|>-"])
            normed(end+1) = 0.5;
        elseif contains(style, ["-<-", "-|<-", "-<|-"])
            normed(end+1) = 0.5i;
        end
    end
end

%% index
if ~isempty(index)
    if any(index == 0)
        throw(MException("extend:ArrowIndex", "Index can NOT contain 0."))
    elseif any(imag(index) ~= 0 & real(index) ~= 0)
        illegal = index(find(imag(index) ~= 0 & real(index) ~= 0, 1));
        throw(MException("extend:ArrowIndex", "Index must be real or pure imaginary (refre to inverse arrow), not" + illegal))
    elseif any(rem(abs(index), 1) ~= 0)
        illegal = index(find(rem(abs(index), 1) ~= 0, 1));
        throw(MException("extend:ArrowIndex", "Index must be integer, not " + illegal))
    elseif any(abs(index) >= linesize)
        illegal = index(find(abs(index) >= linesize, 1));
        throw(MException("extend:ArrowIndex", "Index exceed: " + illegal))
    end
    inv = (imag(index) ~= 0);
    index(inv) = imag(index(inv));
    index(index < 0) = linesize + index(index < 0);
    index(inv) = complex(0, index(inv));
end

%% normed index/length
if ~isempty(normed)
    if any(imag(normed) ~= 0 & real(normed) ~= 0)
        illegal = normed(find(imag(normed) ~= 0 & real(normed) ~= 0, 1));
        throw(MException("extend:ArrowNormedIndex/Length", "Normed-index must be real or pure imaginary (refre to inverse arrow), not" + illegal))
    end
    inv = (imag(normed) ~= 0);
    normed(inv) = imag(normed(inv));
    if any(normed < 0 | normed > 1)
        illegal = normed(find(normed < 0 | normed > 1, 1));
        throw(MException("addarrow:ArrowNormedIndex/Length", "Normed-index must be in [0, 1], not " + illegal));
    end
    if positiontype == "normedindex"
        normed = 1 + ceil((linesize - 2) * normed);
    else
        cumlen = cumsum(sqrt(diff(x).^2 + diff(y).^2));
        [~, normed] = min(abs(cumlen / cumlen(end) - normed));
    end
    normed(inv) = complex(0, normed(inv));
end

indices = [index, normed];

if numel(indices) > 50
    warning("too many arrows: " + numel(indices))
end
