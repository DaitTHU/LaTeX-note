function build_figures
% Rebuild the course illustrations from the inputs distributed with the notes.
root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
properties = {'DefaultFigureVisible', 'DefaultFigurePosition', 'DefaultFigureCreateFcn'};
previous = get(groot, properties);
restoreDefaults = onCleanup(@() set(groot, properties, previous));
% Keep the page background and plot dimensions independent of the desktop.
set(groot, properties, {'off', [100 100 560 420], @(fig, ~) theme(fig, "light")})

build_course(root, 'Electrodynamics', [
    "Bessel", "Besselzero", "ellipseKE", "hysteresis", "image_charge_plane", ...
    "image_charge_sphere", "polarization", "poly_Legendre", "rect_TE", "spherical_harmonic"])
build_course(root, 'Linear Algebra', "svcompress")
build_course(root, 'Nuclear Radiation and Detection', ["binding_energy", "decay2", "decay_system", "halflife"])
build_course(root, 'Numerical Analysis', ["fixpoint", "Lpspace", "Runge"])
build_course(root, 'Probability and Statistics', [
    "bootstrap", "CLT_bin", "gamble", "monte_carlo", "pdf_bin", "pdf_bin3", ...
    "pdf_chi2", "pdf_exp", "pdf_F", "pdf_norm2", "pdf_normal", "pdf_Poisson", "pdf_t"])
build_course(root, 'Quantum Mechanics', [
    "avoided_crossing", "blackbody", "compton_shift", "finite_time_line", ...
    "franck_hertz_current", "free_packet", "hom_dip", "hydrogen_radial", ...
    "oscillator_states", "photoelectric_threshold", "rabi", "rectangular_barrier", "relaxation"])
build_course(root, 'Statistical Mechanics', [
    "blackbody", "Brillouin", "CVBoson", "CVFermion", "CVphonon", "CVrot", ...
    "CVtot", "CVvib", "Maxwell_dist", "ML", "statistic_comparison"])
end

function build_course(root, course, scripts)
for script = scripts
    fprintf('Drawing %s / %s\n', course, script)
    run_script(fullfile(root, course, 'figures', 'matlab', script + ".m"))
    close all
end
end

function run_script(filename)
% Scripts use their own workspace, including those that start with clear.
run(filename)
end
