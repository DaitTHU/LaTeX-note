% Reproduce the three graphs returned by Nuclide.decayChain() in Radiation:
% https://github.com/DaitTHU/Radiation/blob/2629d2662865b396c23c6d0524886d3f662dd487/%40Nuclide/decayChain.m
% The CSV stores nonzero (parent,daughter) entries of its intensity and
% half-life matrices, in graph order. The original groups levels at one
% (Z,N) site. Its last record for a pair supplies that edge's I and T.
% parentState identifies the level supplying the plotted edge. These
% intensities therefore need not sum to one across edges from a site.
directory = fileparts(mfilename('fullpath'));
records = readtable(fullfile(directory, 'inputs', 'decay_series.csv'), TextType="string");
output = fullfile(directory, '..', 'decay_system.pdf');

% Appendix page order and consecutive elements Z = 80 ... 92.
series = ["232Th", "238U", "235U"];
elements = ["Hg","Tl","Pb","Bi","Po","At","Rn","Fr","Ra","Ac","Th","Pa","U"];
for page = 1:numel(series)
    edges = records(records.series == series(page), :);
    names = unique(reshape([edges.parent edges.daughter].', [], 1), 'stable');
    [~,parent] = ismember(edges.parent, names);
    [~,daughter] = ismember(edges.daughter, names);
    edges.EndNodes = [parent daughter];
    G = digraph(edges(:, ["EndNodes","intensity","halfLife_s","mode"]), ...
        table(names, VariableNames="Name"));
    symbol = extract(names, lettersPattern);
    mass = extract(names, digitsPattern);
    [found,Z] = ismember(symbol, elements);
    assert(all(found), 'Unknown element in the series')
    Z = 79 + Z;
    N = str2double(mass) - Z;

    % Preserve the equal Z,N grid, square nodes, and arrows of the source.
    spanZ = max(Z)-min(Z)+2;
    spanN = max(N)-min(N)+2;
    plotWidth = 252;
    plotHeight = plotWidth * spanN / spanZ;
    fig = figure(Visible='off', Color='white', Units='points', ...
        Position=[50 50 365 plotHeight+53]);
    theme(fig, 'light')
    ax = axes(fig, Units='points', FontName='Arial', FontSize=9.6);
    P = plot(ax, G, 's', XData=Z, YData=N, MarkerSize=8, NodeLabel={}, ...
        ArrowSize=10, ArrowPosition=0.6, EdgeAlpha=1);
    I = G.Edges.intensity;
    IT = G.Edges.mode == "IT";
    P.LineWidth = 3*max(I,0.05);
    P.EdgeCData = G.Edges.halfLife_s;
    terminal = ~ismember(names, edges.parent(edges.mode ~= "IT"));
    highlight(P, find(terminal), NodeColor='black')
    edgeLabels = string(100*I) + "%";
    edgeLabels((I > 0.99 & I <= 1.001) | IT) = "";
    P.EdgeFontSize = 8;
    labeledge(P, 1:numedges(G), edgeLabels)

    % Each level shares the same physical grid point. Typeset the mass
    % number and mark sites whose displayed records include an isomer.
    combined = ismember(names, edges.parent(edges.parentState == "m"));
    label = "^{" + mass + "}" + symbol;
    label(combined) = "^{" + mass(combined) + "m,g}" + symbol(combined);
    % Short, labelled beta edges need room for both the percent and nuclide.
    labelledBeta = G.Edges.mode == "beta-" & edgeLabels ~= "";
    nearPercent = ismember(names, G.Edges.EndNodes(labelledBeta,:));
    left = Z == max(Z) | (combined & Z == max(Z)-1);
    labelX = Z + 0.36 + 0.36*nearPercent;
    besideLoop = ismember(names, edges.parent(edges.mode == "IT")) & ~terminal & ~left;
    labelY = N + 0.14*ismember(names, G.Edges.EndNodes(labelledBeta,1)) + 0.4*besideLoop;
    text(ax, labelX(~left), labelY(~left), label(~left), ...
        VerticalAlignment='middle', FontName='Arial', FontSize=9)
    text(ax, Z(left)-0.35, labelY(left), label(left), HorizontalAlignment='right', ...
        VerticalAlignment='middle', FontName='Arial', FontSize=9)

    axis(ax, 'equal')
    xlim(ax, [min(Z)-1 max(Z)+1])
    ylim(ax, [min(N)-1 max(N)+1])
    xticks(ax, min(Z)-1:max(Z)+1)
    yticks(ax, min(N)-1:max(N)+1)
    grid(ax, 'on')
    box(ax, 'on')
    title(ax, label(1) + " decay chain", FontWeight='normal')
    xlabel(ax, 'Proton number Z')
    ylabel(ax, 'Neutron number N')
    ax.ColorScale = 'log';
    clim(ax, [min(G.Edges.halfLife_s), max(G.Edges.halfLife_s)])
    bar = colorbar(ax);
    bar.Label.String = 'Half-life T_{1/2} / s';
    ax.Position = [35 31 plotWidth plotHeight];
    bar.Units = 'points';
    bar.Position = [306 31 14 plotHeight];
    exportgraphics(fig, output, ContentType='vector', BackgroundColor='white', ...
        Append=(page > 1))
    close(fig)
end
