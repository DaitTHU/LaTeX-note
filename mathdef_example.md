# example 1:

```LaTeX
\int\iti\e{-x^2}\d x=\sqrt\pi.
% \iti = -infty to +infty
% \e   = e^
% \d   = d
```
vs.
```LaTeX
\int_{-\infty}^{+\infty}\mathrm e^{-x^2}\,\mathrm dx=\sqrt\pi.
```

$$\int_{-\infty}^{+\infty}\mathrm e^{-x^2}\hspace{0.1em}\mathrm dx=\sqrt\pi.$$

# example 2:

```LaTeX
\dd[n-1]x\dv yx = \dv[n]yx.
% \dd x  = d/dx
% \dv yx = dy/dx, derivative
```
vs.
```LaTeX
\frac{\mathrm d^{n-1}}{\mathrm dx^{n-1}}\frac{\mathrm dy}{\mathrm dx}=\frac{\mathrm d^ny}{\mathrm dx^n}.
```

$$\frac{\mathrm d^{n-1}}{\mathrm dx^{n-1}}\frac{\mathrm dy}{\mathrm dx}=\frac{\mathrm d^ny}{\mathrm dx^n}.$$

# example 3:

```LaTeX
\pv yx, \pv[n]yx, \pw zxy.
% \pv yx  = ∂y/∂x,     partial derivative
% \pw zxy = ∂^2z/∂x∂y, w = double v
```
vs.
```LaTeX
\frac{\partial y}{\partial x}, \frac{\partial^n y}{\partial x^n}, \frac{\partial^2 z}{\partial x\partial y}.
```
$$\frac{\partial y}{\partial x}, \frac{\partial^n y}{\partial x^n}, \frac{\partial^2 z}{\partial x\partial y}.$$

# example 4:

```LaTeX
\ave A=\bra\psi A\ket\psi=\int\bra\psi A\ket x\brkt x\psi\d x.
% \bra x = <x|
% \ket x = |x>
% \brkt x\psi = <x|ψ>
```
vs.
```LaTeX
\left\langle A\right\rangle=\left\langle\psi\right\vert A\left\vert\psi\right\rangle=\int\left\langle\psi\right\vert A\left\vert x\right\rangle\left\langle x\middle\vert\psi\right\rangle\,\mathrm dx.
```
$$\left\langle A\right\rangle=\left\langle\psi\right\vert A\left\vert\psi\right\rangle=\int\left\langle\psi\right\vert A\left\vert x\right\rangle\hspace{-3pt}\left\langle x\middle\vert\psi\right\rangle\hspace{0.1em}\mathrm dx.$$