# LaTeX-note
用 LaTeX 记录的数理课笔记。对于期末复习有所帮助。

为方便阅读（母语 + 字母符号在汉字中更易区分），语言采用为中文。

使用 `UTF-8` 编码。

已收录本人的（排名并不按照学期顺序）：

- 微积分A (2) [Calculus 2](Calculus 2)
- 概率论与数理统计 [Probability and Statistics](Probability and Statistics)
- 数学物理方法 [Methods of Mathematics and Physics](Methods of Mathematics and Physics)
- 量子力学 [Quantum Mechanics](Quantum Mechanics)
- 统计力学 [Statistical Mechanics](Statistical Mechanics)
- 电动力学 [Electrodynamics](Electrodynamics)
- 核辐射物理及探测学 [Nuclear Radiation Physics and Detection](Nuclear Radiation Physics and Detection)

## hair.tex
`hair.tex` 预设定了统一的笔记格式，在 `\input{hair.tex}` 之前，你还需要定义一些笔记性质相关的变量。

### example:
```LaTeX
\def\coursename{数理方程}
    % default: 笔记
\def\coursefullname{数理方程与特殊函数}
    % default: \coursename
\def\courseEnglishname{Mathematical Equations and Special Functions}
    % default: Note
\def\titleannotation{基于姚国武老师讲义整理}
    % default no notation
\def\authorname{Dait}
    % default: Dait
\def\authorEnglishname{Dait}
    % default: Dait
\def\departmentname{THU}
    % default: THU
\def\emailaddress{daiyj20@mails.tsinghua.edu.cn}
    % default: daiyj20@mails.tsinghua.edu.cn
\def\beginday{2022/2/24}
    % default: 2021
\def\endday{2022/5/20}
    % default: \number\year/\number\month/\number\day
    % \date{\beginday~-~\endday}
    % if same as \beginday, \dait{\beginday} only

\input{../hair.tex}
\input{../head.tex}

% options
\showemail
    % default hide email
\contentfalse
    % default show content
\parskiptrue
    % default no extra parskip

\begin{document}
\firstandforemost
\section{偏微分方程的定解问题}
    % mainbody starts here...
\end{document}
```
## head.tex

`head.tex` 中定义了一些定义帮助简化输入。

### example 1:

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

$$\int_{-\infty}^{+\infty}\mathrm e^{-x^2}\hspace{1pt}\mathrm dx=\sqrt\pi.$$

### example 2:

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

### example 3:

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

example 4:

```LaTeX
\ave A=\bra\psi A\ket\psi=\int\bra\psi A\ket x\bs3\brkt x\psi\d x.
% \bra x = <x|
% \ket x = |x>
% \brkt x\psi = <x|ψ>
% \bs3 = backspace 3 pt
```
vs.
```LaTeX
\left\langle A\right\rangle=\left\langle\psi\right\vert A\left\vert\psi\right\rangle=\int\left\langle\psi\right\vert A\left\vert x\right\rangle\hspace{-3pt}\left\langle x\middle\vert\psi\right\rangle\,\mathrm dx.
```
$$\left\langle A\right\rangle=\left\langle\psi\right\vert A\left\vert\psi\right\rangle=\int\left\langle\psi\right\vert A\left\vert x\right\rangle\hspace{-3pt}\left\langle x\middle\vert\psi\right\rangle\,\mathrm dx.$$

About space
```LaTeX
\qquad      % 2em
\quad       % 1em
\enspace    % 0.5em
\;          % 5/18em
\:          % 4/18em
\,          % 3/18em
\!          % -3/18em
```