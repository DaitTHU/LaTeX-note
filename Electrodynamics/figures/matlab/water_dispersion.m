% Liquid water at 25 degrees C, Hale & Querry (1973), Table I.
% https://doi.org/10.1364/AO.12.000555
% The CSV is the 0.35--10 um subset of the CC0 electronic transcription:
% https://refractiveindex.info/?shelf=main&book=H2O&page=Hale
data = readtable("inputs/water_hale_querry_1973.csv");
c = 299792458;  % m/s
wavelength = data.wavelength_um * 1e-6;
freq = c ./ wavelength / 1e12;           % THz
alpha = 4*pi * data.kappa ./ wavelength; % intensity absorption, 1/m

fig = figure(Units="centimeters", Position=[2 2 15 8.7]);
layout = tiledlayout(fig, 2, 2, TileSpacing="compact", Padding="compact");
indexColor = [0.08 0.32 0.48];
absorptionColor = [0.65 0.25 0.10];
overview = [28 900];                  % THz
detail = [84 120];                    % THz, near the 3 um absorption band
visible = c ./ ([700 400] * 1e-9) / 1e12;
[~, peak] = max(alpha);

for tile = 1:4
    ax = nexttile(layout);
    hold(ax, "on")
    ax.Box = "on";
    ax.FontSize = 10;
    ax.TickDir = "out";
    ax.YGrid = "on";
    ax.YMinorGrid = "off";
    ax.GridAlpha = 0.12;
    ax.Layer = "top";
    if tile <= 2
        values = data.n;
        color = indexColor;
        ylim(ax, [1.10 1.52])
        yticks(ax, 1.1:0.1:1.5)
        ylabel(ax, "$n$", Interpreter="latex")
    else
        values = alpha;
        color = absorptionColor;
        xlabel(ax, "$f/\mathrm{THz}$", Interpreter="latex")
    end
    if mod(tile, 2) == 1
        ax.XScale = "log";
        xlim(ax, overview)
        xticks(ax, [30 60 100 200 400 800])
        xtickformat(ax, "%g")
        if tile == 3
            ax.YScale = "log";
            ylim(ax, [1e-2 3e6])
            yticks(ax, 10.^(-2:2:6))
            ylabel(ax, "$\alpha/\mathrm{m}^{-1}$", Interpreter="latex")
        end
        band(ax, detail, [0.88 0.92 0.95]);
        band(ax, visible, [0.88 0.94 0.86]);
        plot(ax, freq, values, Color=color, LineWidth=1.4)
        if tile == 1
            text(ax, sqrt(prod(visible)), 1.49, "VIS", ...
                HorizontalAlignment="center", FontSize=9, Color=[0.18 0.32 0.18])
        end
    else
        xlim(ax, detail)
        xticks(ax, 90:10:120)
        xline(ax, freq(peak), "--", Color=[0.48 0.48 0.48])
        if tile == 4
            values = alpha * 1e-6;
            ylim(ax, [0 1.4])
            yticks(ax, 0:0.4:1.2)
            ylabel(ax, "$\alpha/(\mu\mathrm{m})^{-1}$", Interpreter="latex")
        end
        plot(ax, freq, values, "-o", Color=color, LineWidth=1.2, ...
            MarkerSize=3.2, MarkerFaceColor="white")
    end
    if tile <= 2
        xticklabels(ax, [])
    end
end
exportgraphics(layout, "../water_dispersion.pdf", ...
    ContentType="vector", BackgroundColor="white")

function band(ax, limits, color)
y = ylim(ax);
patch(ax, limits([1 2 2 1]), y([1 1 2 2]), color, EdgeColor="none")
end
