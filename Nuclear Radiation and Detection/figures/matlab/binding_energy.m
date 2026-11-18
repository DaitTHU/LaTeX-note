clear
close all

data = readtable("inputs/nndc_nudat_data_export.csv", VariableNamingRule="preserve");

z = 1 : max(data.z);
n = 1 : max(data.n);

SBE_datas = nan(max(n), max(z));

for ii = 1 : height(data)
    if data.z(ii) <= 1 || data.n(ii) <= 1
        continue
    end
    SBE_datas(data.n(ii), data.z(ii)) = data.("bindingEnergy(keV)")(ii) * 1e-3;
end

[Z, N] = meshgrid(z, n);

SBE_model = max(BEldm(Z, Z + N) ./ (Z + N));
[SBE_data, n_data] = max(SBE_datas);
[SBE_max, z_max] = max(SBE_data);
n_max = n_data(z_max);

plot(z, SBE_model, LineWidth=2)
hold on
scatter(z, SBE_data, '.')

plot([z_max z_max], [0 SBE_max], '--k')
elements = load('inputs/symbol.mat', 'symbols');
text(z_max, SBE_max+0.15, "$^{"+(z_max+n_max)+"}$"+elements.symbols(z_max), ...
    VerticalAlignment="bottom", HorizontalAlignment="center", ...
    Interpreter="latex")

xlabel('Proton number $Z$', Interpreter='latex');
ylabel('$\max_A\varepsilon(Z,A)/\mathrm{MeV}$', Interpreter='latex');
xticks(sort([xticks z_max]))
ylim([0 10])

grid on

pad_legend(legend(["LDM fit", "data"], Interpreter="latex", Location="southeast"));

set(gcf, Position=[200 200 750 400])

exportgraphics(gca, "../binding_energy.pdf", BackgroundColor="none", ContentType="vector")
