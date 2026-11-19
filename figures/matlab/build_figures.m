function build_figures(courses)
% Without arguments, rebuild the illustrations for all courses.
% Pass course directory names to rebuild a subset, for example "Quantum Mechanics".
arguments
    courses string = string.empty
end
root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
properties = {'DefaultFigureVisible', 'DefaultFigurePosition', 'DefaultFigureCreateFcn'};
previous = get(groot, properties);
restoreDefaults = onCleanup(@() set(groot, properties, previous));
% Keep the page background and plot dimensions independent of the desktop.
set(groot, properties, {'off', [100 100 560 420], @(fig, ~) theme(fig, "light")})

scripts = {
    'Electrodynamics', ["Bessel", "Besselzero", "circle_modes", "ellipseKE", "hysteresis", ...
        "image_charge_dielectrics", "image_charge_plane", "image_charge_sphere", "polarization", ...
        "poly_Legendre", "rect_TE", "spherical_harmonic", "water_dispersion"];
    'Linear Algebra', "svcompress";
    'Nuclear Radiation and Detection', ["binding_energy", "decay2", "decay_system", "halflife"];
    'Numerical Analysis', ["fixpoint", "Lpspace", "Runge"];
    'Probability and Statistics', ["bootstrap", "CLT_bin", "gamble", "monte_carlo", "pdf_bin", ...
        "pdf_bin3", "pdf_chi2", "pdf_exp", "pdf_F", "pdf_norm2", "pdf_normal", "pdf_Poisson", "pdf_t"];
    'Quantum Mechanics', ["avoided_crossing", "blackbody", "compton_shift", "finite_time_line", ...
        "franck_hertz_current", "free_packet", "hom_dip", "hydrogen_radial", "oscillator_states", ...
        "photoelectric_threshold", "rabi", "rectangular_barrier", "relaxation"];
    'Statistical Mechanics', ["blackbody", "Brillouin", "CVBoson", "CVFermion", "CVphonon", ...
        "CVrot", "CVtot", "CVvib", "Maxwell_dist", "ML", "statistic_comparison"];
};
names = string(scripts(:, 1));
if isempty(courses)
    courses = names;
end
[found, rows] = ismember(courses, names);
if ~all(found(:))
    error('Unknown course: %s', strjoin(courses(~found), ', '))
end
for row = unique(rows(:)', 'stable')
    for script = scripts{row, 2}
        fprintf('Drawing %s / %s\n', names(row), script)
        run_script(fullfile(root, names(row), 'figures', 'matlab', script + ".m"))
        close all
    end
end
end

function run_script(filename)
% Scripts use their own workspace, including those that start with clear.
run(filename)
end
