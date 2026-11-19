% The first radial mode for azimuthal orders m = 0, 1, 2.
for mode = ["TE", "TM"]
    fig = figure(Position=[100 100 840 302]);
    layout = tiledlayout(fig, 1, 3, TileSpacing="compact", Padding="compact");
    for m = 0:2
        ax = nexttile(layout);
        plot_circ_mode(ax, mode, m)
    end
    exportgraphics(layout, "../waveguide_circle_" + mode + ".pdf", ...
        ContentType="vector", BackgroundColor="none")
end
