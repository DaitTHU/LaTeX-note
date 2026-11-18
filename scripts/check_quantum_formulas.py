#!/usr/bin/env python3
"""Independent numerical spot checks for Quantum Mechanics/QM.tex.

Requires NumPy 2 or later. Uses dimensionless hbar=1; no manuscript expressions are parsed.
These checks cannot prove operator-domain statements or validate experiments.
"""
import math
import numpy as np

I2 = np.eye(2, dtype=complex)
SX = np.array([[0, 1], [1, 0]], dtype=complex)
SY = np.array([[0, -1j], [1j, 0]], dtype=complex)
SZ = np.diag([1., -1.]).astype(complex)
UP = np.array([1., 0.], dtype=complex)
DOWN = np.array([0., 1.], dtype=complex)


def close(actual, expected, atol=1e-10):
    np.testing.assert_allclose(actual, expected, atol=atol, rtol=atol)


def unitary(h, t):
    e, v = np.linalg.eigh(h)
    return (v * np.exp(-1j * t * e)) @ v.conj().T


def rk4(rhs, y, end, steps):
    dt = end / steps
    for k in range(steps):
        t = k * dt
        a = rhs(t, y)
        b = rhs(t + dt / 2, y + dt * a / 2)
        c = rhs(t + dt / 2, y + dt * b / 2)
        d = rhs(t + dt, y + dt * c)
        y = y + dt * (a + 2 * b + 2 * c + d) / 6
    return y


def spin_dynamics():
    # Integrate the actual lab-frame, time-dependent Hamiltonian.
    for omega0, omega, coupling, t in [(2., 2., .7, 4.1), (2., 1.4, .8, 3.7),
                                       (1.3, 1.7, .2, 7.2)]:
        def rhs(s, psi):
            h = (omega0 * SZ + coupling *
                 (SX * np.cos(omega * s) + SY * np.sin(omega * s))) / 2
            return -1j * h @ psi
        psi = rk4(rhs, DOWN.copy(), t, 5000)
        delta = omega0 - omega
        gap = math.hypot(delta, coupling)
        predicted = coupling**2 / gap**2 * np.sin(gap * t / 2)**2
        close(abs(psi[0])**2, predicted, 2e-10)
        close(np.vdot(psi, psi), 1)
    for phase in np.linspace(-4, 4, 17):
        psi = unitary(SY / 2, -np.pi / 2) @ unitary(SZ / 2, phase) @ (
            unitary(SY / 2, np.pi / 2) @ UP)
        close(abs(psi[0])**2, (1 + np.cos(phase)) / 2)


def oscillator():
    size = 70
    a = np.diag(np.sqrt(np.arange(1, size)), 1)
    x = (a + a.T) / np.sqrt(2)
    p = (a - a.T) / (1j * np.sqrt(2))
    # Never claim a finite truncation satisfies the CCR at its top state.
    close((x @ p - p @ x)[:8, :8], 1j * np.eye(8))
    x4 = np.linalg.matrix_power(x, 4)
    for n in range(6):
        close(x4[n, n], 3 * (2 * n**2 + 2 * n + 1) / 4)
    alpha = 1.2 + .3j
    psi = np.array([np.exp(-abs(alpha)**2 / 2) * alpha**n /
                    np.sqrt(float(math.factorial(n))) for n in range(size)])
    close(np.vdot(psi, psi), 1)
    close(np.linalg.norm(a @ psi - alpha * psi), 0)
    mean = np.vdot(psi, a.T @ a @ psi)
    close(np.vdot(psi, a.T @ a.T @ a @ a @ psi) / mean**2, 1)
    # Variational bound versus two independently converged matrix sizes.
    lam = .1
    omega = max(z.real for z in np.roots([1, 0, -1, -6 * lam])
                if abs(z.imag) < 1e-12)
    upper = omega / 4 + 1 / (4 * omega) + 3 * lam / (4 * omega**2)
    energies = []
    for dim in (50, 70):
        b = np.diag(np.sqrt(np.arange(1, dim)), 1)
        xx = (b + b.T) / np.sqrt(2)
        h = np.diag(np.arange(dim) + .5) + lam * np.linalg.matrix_power(xx, 4)
        energies.append(np.linalg.eigvalsh(h)[0])
    close(*energies, atol=1e-10)
    assert energies[-1] < upper < .575


def angular_momentum():
    for j in (.5, 1., 1.5, 2.):
        m = np.arange(-j, j + 1)
        plus = np.diag(np.sqrt((j - m[:-1]) * (j + m[:-1] + 1)), -1)
        x, y, z = (plus + plus.T) / 2, (plus - plus.T) / (2j), np.diag(m)
        close(x @ y - y @ x, 1j * z)
        close(x @ x + y @ y + z @ z, j * (j + 1) * np.eye(len(m)))
    exchange = sum(np.kron(s, s) for s in (SX, SY, SZ)) / 4
    singlet = np.array([0, 1, -1, 0]) / np.sqrt(2)
    close(exchange @ singlet, -.75 * singlet)
    close(np.linalg.eigvalsh(exchange), [-.75, .25, .25, .25])


def perturbation():
    rng = np.random.default_rng(27)
    levels = np.array([0., 1.3, 2.7, 4.1, 6.])
    raw = rng.normal(size=(5, 5)) + 1j * rng.normal(size=(5, 5))
    v = (raw + raw.conj().T) / 2
    second = sum(abs(v[m, 0])**2 / (levels[0] - levels[m]) for m in range(1, 5))
    errors = []
    for lam in (.004, .002, .001):
        exact = np.linalg.eigvalsh(np.diag(levels) + lam * v)[0]
        estimate = levels[0] + lam * v[0, 0].real + lam**2 * second
        errors.append(abs(exact - estimate))
    # A second-order expansion must have a cubic leading error.
    assert all(7 < a / b < 9 for a, b in zip(errors, errors[1:]))


def radiation():
    x = np.linspace(1e-7, 50., 200001)
    integral = np.trapezoid(x**3 / np.expm1(x), x)
    close(integral, np.pi**4 / 15, 1e-9)
    lo, hi = 4., 6.
    for _ in range(60):
        mid = (lo + hi) / 2
        if mid - 5 * (1 - np.exp(-mid)) < 0:
            lo = mid
        else:
            hi = mid
    close((lo + hi) / 2, 4.965114231744276)
    # Two transverse polarizations: d=(0,0,1), angular integral 8*pi/3.
    z, weights = np.polynomial.legendre.leggauss(60)
    close(2 * np.pi * np.dot(weights, 1 - z**2), 8 * np.pi / 3)


def density_and_bell():
    # Complex, unequal subsystem dimensions expose a missing conjugation in
    # the right Schmidt basis; compare against a direct partial trace.
    rng = np.random.default_rng(19)
    coefficient = rng.normal(size=(3, 2)) + 1j * rng.normal(size=(3, 2))
    coefficient /= np.linalg.norm(coefficient)
    u, singular, vh = np.linalg.svd(coefficient, full_matrices=False)
    schmidt = sum(singular[k] * np.kron(u[:, k], vh[k, :]) for k in range(2))
    close(schmidt, coefficient.ravel())
    joint = np.outer(schmidt, schmidt.conj()).reshape(3, 2, 3, 2)
    alice = np.trace(joint, axis1=1, axis2=3)
    bob = np.trace(joint, axis1=0, axis2=2)
    close(np.linalg.eigvalsh(alice), np.r_[0, np.sort(singular**2)])
    close(np.linalg.eigvalsh(bob), np.sort(singular**2))
    for k in range(2):
        close(bob @ vh[k, :], singular[k]**2 * vh[k, :])

    singlet = np.array([0, 1, -1, 0], complex) / np.sqrt(2)
    rho = np.outer(singlet, singlet.conj())
    partial = np.trace(rho.reshape(2, 2, 2, 2), axis1=1, axis2=3)
    close(partial, I2 / 2)
    b, bp = (SZ + SX) / np.sqrt(2), (SZ - SX) / np.sqrt(2)
    chsh = np.kron(SZ, b + bp) + np.kron(SX, b - bp)
    close(abs(np.vdot(singlet, chsh @ singlet)), 2 * np.sqrt(2))
    # Nonselective amplitude damping on Bob leaves Alice unchanged.
    eta = .37
    k0, k1 = np.diag([1, np.sqrt(1 - eta)]), np.array([[0, np.sqrt(eta)], [0, 0]])
    out = sum(np.kron(I2, k) @ rho @ np.kron(I2, k).conj().T for k in (k0, k1))
    close(np.trace(out.reshape(2, 2, 2, 2), axis1=1, axis2=3), partial)
    # Trace out a non-orthogonal path record and compare interference.
    theta, phase = .7, .4
    da, db = UP, np.array([np.cos(theta), np.sin(theta)])
    state = (np.kron(UP, da) + np.exp(1j * phase) * np.kron(DOWN, db)) / np.sqrt(2)
    reduced = np.trace(np.outer(state, state.conj()).reshape(2, 2, 2, 2), axis1=1, axis2=3)
    xp = (UP + DOWN) / np.sqrt(2)
    close(np.vdot(xp, reduced @ xp), (1 + np.cos(theta) * np.cos(phase)) / 2)


def berry():
    theta = .91
    phis = np.linspace(0, 2 * np.pi, 20001)
    states = np.column_stack([np.full(phis.size, np.cos(theta / 2)),
                              np.exp(1j * phis) * np.sin(theta / 2)])
    # Gauge-invariant closed product, independently discretized.
    overlaps = np.einsum("ij,ij->i", states[:-1].conj(), states[1:])
    phase = -np.angle(np.prod(overlaps / abs(overlaps)))
    close(phase, -np.pi * (1 - np.cos(theta)), 2e-8)


def open_system():
    gamma, dephase, omega, t = .4, .13, 1.2, 3.1
    h = omega * np.outer(UP, UP)
    jumps = [np.sqrt(gamma) * np.outer(DOWN, UP), np.sqrt(dephase / 2) * SZ]
    initial = np.outer((UP + DOWN) / np.sqrt(2), (UP + DOWN) / np.sqrt(2))
    def rhs(_, rho):
        out = -1j * (h @ rho - rho @ h)
        for jump in jumps:
            jj = jump.conj().T @ jump
            out += jump @ rho @ jump.conj().T - (jj @ rho + rho @ jj) / 2
        return out
    rho = rk4(rhs, initial, t, 2000)
    close(np.trace(rho), 1)
    assert np.linalg.eigvalsh(rho).min() >= 0
    close(rho[0, 0], .5 * np.exp(-gamma * t))
    close(rho[0, 1], .5 * np.exp(-(1j * omega + gamma / 2 + dephase) * t))


def scattering():
    # Independently solve delta-interaction continuity and derivative-jump
    # equations in its two flux channels (hbar=m=1).
    for g in (-3., -.2, .2, 3.):
        for k in (.1, 1., 5.):
            # t-r=1; ik*t + (ik-2g)*r = ik+2g.
            matrix = np.array([[1, -1], [1j * k, 1j * k - 2 * g]], complex)
            t, r = np.linalg.solve(matrix, [1, 1j * k + 2 * g])
            eta = g / k
            close(t, 1 / (1 + 1j * eta))
            close(r, -1j * eta / (1 + 1j * eta))
            close(abs(t)**2 + abs(r)**2, 1)
    # Partial-wave optical theorem from numerical angular quadrature.
    phases = np.array([.4, -.2, .09, .03])
    z, weights = np.polynomial.legendre.leggauss(40)
    f = sum((2*l+1) * np.exp(1j*d) * np.sin(d) *
            np.polynomial.legendre.Legendre.basis(l)(z) for l, d in enumerate(phases))
    forward = sum((2*l+1) * np.exp(1j*d) * np.sin(d) for l, d in enumerate(phases))
    close(2 * np.pi * np.dot(weights, abs(f)**2), 4 * np.pi * forward.imag)


def fine_structure():
    for n in range(1, 7):
        for ell in range(n):
            for j in set([ell + .5] + ([ell - .5] if ell else [])):
                kinetic = 3 / (4 * n) - 1 / (ell + .5)
                so = ((j*(j+1)-ell*(ell+1)-.75) /
                      (2*ell*(ell+.5)*(ell+1))) if ell else 0
                darwin = 1 if ell == 0 else 0
                close(kinetic + so + darwin, 3/(4*n)-1/(j+.5))
    # Compare with the exact point-nucleus Dirac spectrum: omitted error O(alpha^6).
    n, j = 2, .5
    errors = []
    for alpha in (.1, .05, .025):
        den = n-j-.5 + np.sqrt((j+.5)**2-alpha**2)
        exact = (1+(alpha/den)**2)**(-.5)-1
        approximate = -alpha**2/(2*n*n) + alpha**4/(2*n**3)*(3/(4*n)-1/(j+.5))
        errors.append(abs(exact-approximate))
    assert all(60 < a/b < 68 for a, b in zip(errors, errors[1:]))


def foldy_wouthuysen():
    # Compare the fourth-order even Hamiltonian with the exact four-level
    # spectrum, using generic odd and even blocks and atomic power counting.
    rng = np.random.default_rng(51)
    b = rng.normal(size=(2, 2)) + 1j * rng.normal(size=(2, 2))
    odd = np.block([[np.zeros((2, 2)), b], [b.conj().T, np.zeros((2, 2))]])
    beta = np.diag([1, 1, -1, -1])
    raw = rng.normal(size=(4, 4)) + 1j * rng.normal(size=(4, 4))
    even = (raw + raw.conj().T) / 2
    even[:2, 2:] = even[2:, :2] = 0
    commutator = odd @ even - even @ odd
    double = odd @ commutator - commutator @ odd
    errors = []
    for epsilon in (.08, .04, .02):
        exact = np.linalg.eigvalsh(beta + epsilon * odd + epsilon**2 * even)[2:]
        effective = (beta + epsilon**2 * (beta @ odd @ odd / 2 + even)
                     - epsilon**4 * (beta @ np.linalg.matrix_power(odd, 4) + double) / 8)
        approximate = np.linalg.eigvalsh(effective[:2, :2])
        errors.append(np.linalg.norm(exact - approximate))
    assert all(60 < a / b < 68 for a, b in zip(errors, errors[1:]))


def spectroscopy_examples():
    # Construct L and S independently in the uncoupled basis.
    def angular(j):
        m = np.arange(-j, j + 1)
        plus = np.diag(np.sqrt((j - m[:-1]) * (j + m[:-1] + 1)), -1)
        return [(plus + plus.T) / 2, (plus - plus.T) / (2j), np.diag(m)]
    orbital, spin = angular(1), angular(.5)
    ls = sum(np.kron(a, b) for a, b in zip(orbital, spin))
    jz = np.kron(orbital[2], I2) + np.kron(np.eye(3), spin[2])
    magnetic = np.kron(orbital[2], I2) + 2 * np.kron(np.eye(3), spin[2])
    upper = []
    for m in (-1.5, -.5, .5, 1.5):
        indices = np.flatnonzero(np.isclose(np.diag(jz), m))
        energies, vectors = np.linalg.eigh(ls[np.ix_(indices, indices)])
        for energy, vector in zip(energies, vectors.T):
            j = .5 if energy < 0 else 1.5
            slope = np.vdot(vector, magnetic[np.ix_(indices, indices)] @ vector).real
            close(slope, (2/3 if j == .5 else 4/3) * m)
            if j == .5:
                upper.append((m, slope))
    shifts = sorted(slope - 2 * ground_m for m, slope in upper
                    for ground_m in (-.5, .5) if abs(m-ground_m) <= 1)
    close(shifts, [-4/3, -2/3, 2/3, 4/3])
    # Induced dipole versus a finite difference of the exact Stark energy.
    gap, dipole = 1.7, .8
    d = dipole * SX
    for field in (.03, .4, 2.):
        h = np.diag([-gap/2, gap/2]) - field * d
        energies, vectors = np.linalg.eigh(h)
        step = 1e-5
        derivative = (np.linalg.eigvalsh(h-step*d)[0]
                      - np.linalg.eigvalsh(h+step*d)[0]) / (2*step)
        close(-derivative, np.vdot(vectors[:, 0], d @ vectors[:, 0]), 1e-9)
        close(energies, [-math.hypot(gap/2, dipole*field),
                        math.hypot(gap/2, dipole*field)])


def rotating_adiabatic():
    # Integrate in the lab frame, then project on the moving eigenstate.
    theta, omega0 = .83, 2.3
    initial = np.array([np.cos(theta/2), np.sin(theta/2)], complex)
    for speed, time in ((.12, 15.), (.65, 9.), (-.4, 8.)):
        def rhs(t, state):
            h = omega0 / 2 * (
                np.sin(theta) * (np.cos(speed*t)*SX + np.sin(speed*t)*SY)
                + np.cos(theta)*SZ)
            return -1j * h @ state
        evolved = rk4(rhs, initial.copy(), time, 7000)
        minus = np.array([-np.sin(theta/2),
                          np.exp(1j*speed*time)*np.cos(theta/2)])
        frequency = np.sqrt(omega0**2+speed**2-2*omega0*speed*np.cos(theta))
        predicted = (speed*np.sin(theta)/frequency)**2 * np.sin(frequency*time/2)**2
        close(abs(np.vdot(minus, evolved))**2, predicted, 2e-9)


def optical_overlap_and_echo():
    # Numerical spectral overlap versus the analytic Gaussian HOM dip.
    offset = np.linspace(-10, 10, 20001)
    intensity = np.exp(-offset**2/2) / np.sqrt(2*np.pi)
    for delay in (0., .3, 1., 2.5):
        overlap = np.trapezoid(intensity * np.exp(-1j*offset*delay), offset)
        close((1-abs(overlap)**2)/2, (1-np.exp(-delay**2))/2, 1e-10)
    # A fixed detuning cancels for every ensemble member individually.
    pulse = unitary(SX/2, np.pi)
    for detuning in (-3.1, -.7, 0., 1.9):
        free = unitary(detuning*SZ/2, 1.3)
        close(free @ pulse @ free, pulse)
    # Compare finite Kraus evolution with integrated Lindblad dynamics.
    for time in (.1, .7, 2.):
        rate = .43
        probability = 1-np.exp(-rate*time)
        k0 = np.diag([1, np.sqrt(1-probability)])
        k1 = np.array([[0, np.sqrt(probability)], [0, 0]])
        psi = np.array([1, 1j]) / np.sqrt(2)
        rho = np.outer(psi, psi.conj())
        mapped = sum(k @ rho @ k.conj().T for k in (k0, k1))
        jump = np.sqrt(rate) * np.array([[0, 1], [0, 0]])
        number = jump.conj().T @ jump
        evolved = rk4(lambda t, state: jump @ state @ jump.conj().T
                      - (number @ state + state @ number)/2, rho.copy(), time, 1000)
        close(mapped, evolved, 1e-10)


def main():
    checks = [spin_dynamics, oscillator, angular_momentum, perturbation,
              radiation, density_and_bell, berry, open_system, scattering,
              fine_structure, foldy_wouthuysen, spectroscopy_examples,
              rotating_adiabatic, optical_overlap_and_echo]
    for check in checks:
        check()
        print(f"PASS {check.__name__}")
    print(f"{len(checks)} numerical check groups passed.")


if __name__ == "__main__":
    main()
