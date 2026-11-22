# 数学宏与公式排版

## 跨卷共用的符号

十卷正文共用 `mathdef.tex`。选命令时先看公式中对象的定义，再看字形。下表给出正文里最容易混用的几组。

| 对象 | 统一写法 | 使用约定 |
| --- | --- | --- |
| 数集与函数空间 | `\RR`、`\CC`、`\FF`、`\cont^k`、`\poly_n` | `\cont^k` 表示函数及其直到第 *k* 阶的各阶导数均连续。单变量多项式空间 `\poly_n` 包含次数不超过 *n* 的多项式，维数为 *n* + 1。 |
| 矩阵和线性映射 | `A\transp`、`A\adjoint`、`A\inv`、`\rank A`、`\tr A`、`\diag`、`\colsp(A)`、`\nullsp(A)`、`\Span(S)` | 分别区分转置、共轭转置和逆。物理公式中 `z\conj` 表示复共轭，线性代数中对偶空间的 `V^\ast` 有单独的含义。 |
| 最优化与数量级 | `\argmin`、`\argmax`、`\bigo` | `\argmin_{x\in S} f(x)` 取使目标函数最小的点，`\min_{x\in S} f(x)` 取最小值。 |
| 矢量与场 | `\bm v`、`\dotbm v`、`v_r\uvec r`、`\grad f`、`\div\bm F`、`\curl\bm F`、`\laplacian f` | `\uvec` 表示单位矢量。对源坐标求散度写作 `\nabla'\cdot\bm F`。 |
| 概率、矩与分布 | `\P(A\mid B)`、`\E(X)`、`\Var(X)`、`\BinDist(n,p)`、`\NormalDist(\mu,\sigma^2)` | 概率卷和探测学卷的正态分布都以方差为第二参数。样本平均可写 `\avg X`，量子态中某可观测量的期望可写 `\ave{\op A}`。 |
| 特殊函数与奇异积分 | `\Beta(a,b)`、`\sinc x`、`\PV` | `\Beta` 是 Euler 的 Beta 函数，概率卷另用 `\BetaDist` 表示 Beta 分布。`\sinc x` 取 `\sin x/x`，在零点取 1。`\PV` 表示 Cauchy 主值。 |
| 物理常数、粒子与下标 | `\NA`、`\kB`、`\muB`、`m_\electron`、`m_\proton`、`\CM`、`\FWHM` | `\electron`、`\proton` 分别是正体的电子、质子标签。质心写作 `R_\CM`。有效量、总量写作 `H_\eff`、`E_\tot`，复合标签写作 `E_{n,\eff}`。最大、最小值直接写 `v_{\max}`、`v_{\min}`。角度数值可写 `\ang{90}`。 |

概率和期望分别写作 `\P`、`\E`，都排成正体算符。量子力学卷用 `\op\Pi_a` 表示读数为 $a$ 的投影，用 `\op P` 表示正则动量。热力学中的压强 `P` 用斜体。文本段落符号 ¶ 可用 `\textparagraph`。

单位矢量沿用微分 `\d` 的间距写法。分量展开直接写 `v_r\uvec r + v_\theta\uvec\theta`，点乘写 `\bm v \cdot \uvec n`。TeX 按前一个数学原子的类别决定间距。一元负号直接作用在单位矢量上时，用 `-{\uvec n}` 把符号与矢量排紧。

下标的字体由含义决定。描述性标签用正体，例如起点和终点的坐标 `x_\initial`、`x_\final`，高低能级的能量 `E_\hi`、`E_\lo`，以及核磁子 `\mu_\nucleus`。代表变量或物理量的下标用斜体，例如 `\sum_f \abs{V_{fi}}^2` 中的末态编号 $f$、`C_V` 中的体积 $V$。在 `m_\lo` 中，磁量子数 $m$ 可以取不同值，正体下标仅说明它属于低能级。[NIST SP 811，第 10 章](https://www.nist.gov/pml/special-publication-811/nist-guide-si-chapter-10-more-printing-and-using-symbols-and-numbers)

二能级系统用 `\excitedstate`、`\groundstate` 标出激发态和基态。例如 `\rho_{\excitedstate\groundstate}` 表示矩阵元 `\mel{\excitedstate}{\op\rho}{\groundstate}`，两个下标都用正体。写成任意两个能量本征态的矩阵元 `\rho_{mn}` 时，态编号 `m,n` 都用斜体。希腊字母也按含义区分，例如光子能量 `E_\upgamma` 中的 γ 是粒子标签。

`\tau_{\external,\CM}` 同时标出外力矩和取矩中心。电、磁响应写作 `\chi_\electric`、`\chi_\magnetic`。入射波标签 `\incident` 和初态标签 `\initial` 都排作正体 i。横向和纵向分量分别写作 `v_\transv` 和 `v_\longit`。

## 各卷单独定义的符号

课程入口先加载共享记号，再定义本卷实际使用的算符和物理标签。量子力学、电动力学、统计力学和核辐射四卷把正文与独立图册共用的本卷符号放在同目录的 `notation.tex`。只在一道例题中代表某个数的 *x*、*k*、*T* 等，含义写在例题中即可。

| 笔记 | 留在本卷的约定与定义位置 |
| --- | --- |
| 微积分 · [Calc.tex](Calculus/Calc.tex) | `\vimplies`、`\viff` 排列竖式推理链。连续可微性、梯度与多元函数的偏导采用共享写法。 |
| 线性代数 · [LA.tex](Linear%20Algebra/LA.tex) | 列空间与零空间沿用共享的 `\colsp(A)`、`\nullsp(A)`。`\cof`、`\adj` 为余子式矩阵与伴随矩阵的算符，`\AM`、`\GM` 标出代数与几何重数。复内积 `\inp{u}{v}` 对第二个变元线性。 |
| 数值分析 · [NA.tex](Numerical%20Analysis/NA.tex) | `\frobnorm{A}` 和 `\cond(A)` 分别给出 Frobenius 范数和条件数。本卷复内积对第一个变元线性，展开系数时共轭的位置随之确定。 |
| 数学物理方法 · [MMP.tex](Method%20of%20Mathematics%20and%20Physics/MMP.tex) | `\LT` 与 `\SLop` 都排作花体 L，分别表示 Laplace 变换与 Sturm–Liouville 微分算子。`\testspace`、`\Schwartz` 分别是紧支撑光滑试验函数空间和 Schwartz 空间。分布对试验函数的作用是线性配对。 |
| 概率论与数理统计 · [PS.tex](Probability%20and%20Statistics/PS.tex) | 事件补集、矩母函数、特征函数、单卷用到的分布族和三种收敛箭头在此定义。一次 Bernoulli 试验用 `\BernDist(p)`，二项计数用 `\BinDist(n,p)`，多项计数用 `\MultDist`。 |
| 经典力学 · [CM.tex](Classical%20Mechanics/CM.tex) | 非保守力、外力、转动与惯性参考系的下标由 `\nonconservative`、`\external`、`\rotating`、`\inertial` 给出。位置、动量、角动量等随具体力学问题定义。 |
| 量子力学 · [QM.tex](Quantum%20Mechanics/QM.tex) | `\op A`、`\one`、`\HH`、`\Dom` 标明算符、单位算符、Hilbert 空间与定义域。态和矩阵元采用共享 Dirac 括号。 |
| 统计力学 · [SM.tex](Statistical%20Mechanics/SM.tex) | `\pvat{S}{T}{V}` 标明偏导中固定的变量。平动、转动、振动分别用 `\transl`、`\rot`、`\vib` 作下标；Einstein、Brillouin、Debye 函数也在入口定义。相图与正文复用固、液、气相的标签。 |
| 电动力学 · [ED.tex](Electrodynamics/ED.tex) | `\relative` 和 `\reflected` 均排作正体 r，分别标记相对介电常数和反射波。临界角、导体、截止频率也各有其定义。频域的 `\hatbm E` 表示矢量场的 Fourier 分量。 |
| 核辐射物理及探测学 · [NRD.tex](Nuclear%20Radiation%20and%20Detection/NRD.tex) | 核素写作 `\nuclide[6]{14}{C}`，省略原子序数可写 `\nuclide{14}{C}`。反应道、衰变箭头和阈值标签由本卷定义。约化波长用 `\lambdabar`，质心系与实验室系的标记同时用于散射公式与图。 |

分布族的宏名统一以 `Dist` 结尾，共用的有 `\BinDist` 和 `\NormalDist`。概率卷另有 `\BernDist`、`\PoisDist`、`\TDist`、`\FDist`、`\ChiSqDist` 等。比如 `\BetaDist(a,b)` 是分布，归一化常数中出现的 `\Beta(a,b)` 是函数。检验统计量 `t`、`F`、`\chi^2` 与临界值 `t_{\alpha/2}(n-1)` 可直接写各自的符号。

角括号的含义也要看操作对象。统计力学中，`\ave{S_i}` 表示格点自旋的热平均，Ising 模型的求和指标 `\langle ij\rangle` 则枚举最近邻格点对。

复分析目前只有独立图册。图中的虚数单位使用共享的 `\i`，圆盘、上半平面和映射变量沿用图内定义。

数学物理方法用 `\FT` 表示 Fourier 变换，系数 `1/(2\pi)` 放在逆变换中。量子力学以动量 *p* 标记平面波，位置与动量表象之间的正逆变换各带系数 `1/\sqrt{2\pi\hbar}`。从一卷取用另一卷的变换表时，要同时换算积分变量和归一化系数。

## 微分与指数

`\d` 自带微分所需的间距，`\nd` 用于不应增加间距的分母。
`\e` 也已处理乘积中的间距，不要在这些宏前重复加薄空格。

~~~LaTeX
\begin{align*}
    \intR \e^{-x^2}\d x &= \sqrt{\pi},\\
    \intRplus \e^{-x}\d x &= 1.
\end{align*}
~~~

同一个一阶导数可以用斜线、分数线或导数宏表示。高阶导数和混合偏导数也有对应的宏。

~~~LaTeX
\d f/\nd t,\qquad \frac{\d f}{\nd t},\qquad \dv{f}{t}.
\dd[n-1]{x}\dv{y}{x}=\dv[n]{y}{x}.
\pv{y}{x},\qquad \pv[n]{y}{x},\qquad \pw{z}{x}{y}.
~~~

数学模式中 `\i` 表示虚数单位，`\e` 表示自然指数的底，基本电荷写作斜体 `e`。热量、功的过程微元可写 `\vd Q`、`\vd W`，状态函数的全微分写 `\d U`，有限增量写 `\Delta U`。Dirac 分布 `\delta(x)` 和 Kronecker 符号 `\delta_{ij}` 使用普通的希腊字母。一维积分反复用到两个固定区间。`\intR` 展开为 `\int_{-\infty}^\infty`，`\intRplus` 展开为 `\int_0^\infty`。上限是变量的 `\int_{-\infty}^x`、从 `a` 起的尾积分 `\int_a^\infty` 及端点代入 `\eval{F}_0^\infty` 直接写界限。

正文需要无点的 i 或带下点的字母时，可用 `\dotlessi` 或 `\dotbelow{a}`。

## 外国人名

正文采用本人发表著作时的拉丁拼法或该术语在专业文献中的通行拼法。拉丁字母姓名保留所用的变音符号，如 Hänchen、Lévy。Gauss 的《算术研究》题名页署作 *Carolo Friderico Gauss*，德文目录也作 *Carl Friedrich Gauß*。本笔记在 Gauss 定律和 Gauss–Seidel 迭代法等名称中统一写 Gauss。[《算术研究》初版书目与影印本](https://www.e-rara.ch/zut/content/titleinfo/1254642)

俄语姓名有多种拉丁转写时，同一术语沿用学科惯例，如 Чебышёв 在多项式名中写 Chebyshev。日本学者可以在首次介绍时并列汉字姓名与本人惯用的罗马字，如仁科芳雄（Yoshio Nishina），公式名写 Klein–Nishina。参考文献保留原作的署名、姓名次序和题名。[NIST 的 Chebyshev 多项式条目](https://dlmf.nist.gov/18.3) · [仁科纪念财团所列原论文](https://www.nishina-mf.or.jp/digitalmemorial_4/)

本库用 XeLaTeX 编译，姓名可直接输入 UTF-8 字符。需要纯 ASCII 源码时，下列三种文本写法依次排作 ä、è、ß；单个字母的重音参数可省略花括号，例如 `\"a`。

~~~tex
\"{a}    \`{e}    \ss{}
~~~

## 连字符与破折号

| 符号 | LaTeX 文本写法 | 笔记中的用法 |
| --- | --- | --- |
| 连字符（hyphen，-） | `-` | 连接复合词的组成部分，如 `two-level system`，也保留人名自身的拼写，如 `Levi-Civita`。 |
| 半字线（en dash，–） | `--` | 连接共同命名一个效应或定理的不同人名，如 `Goos--Hänchen`、`Cauchy--Schwarz`。页码范围也用半字线，如 `pp.~843--847`。 |
| 长破折号（em dash，—） | `---` | 英文句中用来插入说明或表示转折。中文句中使用占两格的破折号 `——`。 |

物理量的相互关系也可用半字线，如“自旋–轨道耦合”。公式里的 `$E_2-E_1$` 用数学减号，图名中的 `$p\vs V$` 表示压强与体积的关系。

## 图的两个变量与物理单位

`$p\vs V$ 图` 表示以压强 *p* 为纵轴、以体积 *V* 为横轴的图，排作紧邻的 p–V。写三维坐标时列出三个变量。写时间、能量等量的区间时给出两端数值和单位。

| 场合 | 源码示例 |
| --- | --- |
| 数值和单位 | `\qty{1.5}{\micro\second}`、`\qty{13.6}{\electronvolt}` |
| 量的区间 | `\qtyrange{2}{5}{\kilo\electronvolt}` |
| 有量纲的数值轴或表头 | `$t/\unit{\second}$`、`$v/(\unit{\metre\per\second})$` |
| 归一化的坐标轴 | `$t/\tau$`、`$r/a$` |
| 带复合单位的量 | `\qty{9.81}{\metre\per\second\squared}` |
| 数值角度 | `\ang{90}` |

全库采用 siunitx v3 的命令。`\qty` 同时接收数值和单位，`\unit` 排印单独的单位，`\qtyrange` 接收区间两端的数值与共用单位。应按量的含义选单位。计数变量 *N*、折射率 *n*、数学区间以及解析式中的角变量直接写在数学模式中。

数值轴和表头中的单位是除数。例如，`$t/\unit{\second}$` 的刻度 2 表示 2 秒。更多示例见[坐标轴和色标](CONTRIBUTING.md#坐标轴和色标)。

## 括号尺寸与 Dirac 记号

期望值、绝对值、范数和 Dirac 记号默认采用当前数学样式的普通尺寸。例如，行内的 `\ave{\hat A}` 与 `\langle\hat A\rangle` 相同，放进下标也会随下标缩小。帽号或一个上下标通常用普通尺寸就足够。遇到分式、积分或嵌套结构时，可在宏名前加 `big`、`Big`、`bigg`、`Bigg`，按由小到大的顺序选取能看清层次的一档。

~~~LaTeX
\ave{\hat A},\qquad (\Delta A)^2=\ave{\hat A^2}-\ave{\hat A}^2.
\bigave{\hat N(\hat N-1)},\qquad \Bigave{\frac{\hat A+\hat B}{2}}.
\Bigabs{\frac{x-y}{x+y}},\qquad \Bigeval{\dv{f}{x}}_{x=0}.
~~~

| 用途 | 普通尺寸 | 显式尺寸示例 |
| --- | --- | --- |
| 绝对值、范数、期望值 | `\abs{x}`、`\norm{u}`、`\ave{A}` | `\bigabs`、`\Bignorm`、`\biggave` |
| 取值、下取整、上取整 | `\eval{f}_a^b`、`\floor{x}`、`\ceil{x}` | `\Bigeval`、`\bigfloor`、`\Bigceil` |
| 集合、斜线除式、内积 | `\set{x}{x>0}`、`\division{a}{b}`、`\inp{u}{v}` | `\Bigset`、`\Biggdivision`、`\biginp` |
| 左矢、右矢、内积、外积、矩阵元 | `\bra{a}`、`\ket{b}`、`\braket{a}{b}`、`\ketbra{a}{b}`、`\mel{a}{A}{b}` | `\bigbra`、`\Bigket`、`\biggbraket`、`\bigketbra`、`\Bigmel` |
| 圆、方、花括号 | `(x)`、`[x]`、`\{x\}` | `\bigp`、`\Bigb`、`\biggB` |

同一条 Dirac 内积或矩阵元里，中间的竖线与两端括号使用同一档尺寸。外积将右矢与左矢相接。

~~~LaTeX
\hat A\ket{\psi},\qquad \bra{\phi}\hat A,\qquad \ketbra{a}{b}\ket{\psi}.
\mel{\phi}{\hat A}{\psi}
    =\sum_n\mel{\phi}{\hat A}{n}\braket{n}{\psi}.
\ket{s=1/2,m=1/2}.
\Bigmel{\phi}{\frac{\hat A+\hat B}{2}}{\psi}.
~~~

多行方程组的左花括号要覆盖整组方程。已有的 `\eqnset{\begin{aligned}…\end{aligned}}` 按实际行高排版。分段函数用 `cases`，矩阵可用 `pmatrix` 或 `bmatrix`。

## 行内运算符与分式

读者要辨认积分上下限、跟随求和推导或在后文引用的关系，宜放在行间。正文里引用一个简短条件时可留在句中。课程模板 `thunote.cls` 采用 `\everymath{\displaystyle}`，例如句中的归一化条件可写作 `$\textstyle\sum_i p_i=1$`，让求和指标排在右侧。独立 TikZ 图册按自身文档类选择样式。

简单比值在行内写作 `$\hbar/2$`、`$(x-\mu)/\sigma$` 或 `$p^2/(2m)$`，用括号标明斜线的作用范围。分母本身是比值时，上下分式更容易辨认，例如统计表中的 `$\frac{\avg X-\mu}{S/\sqrt n}$`。表格或图注确实需要紧凑的上下分式时可用 `\tfrac`，并在最终字号下检查可读性。

## 行间公式的编号、分组与对齐

只有能从上下文确认是一次性代入、算术核对或随即消去的辅助式，才将单行公式写作 `\[ ... \]`。后文要按式号调用的关系，以及读者会反复查阅的核心公式，用 `equation` 编号，给它一个说明含义的 `\label{eq:...}`，在正文中用 `\eqref{eq:...}` 引用。量子力学卷推导时间演化时，态的瞬时变化率写在无编号的行间。随后得到的 Schrödinger 方程有标签 `eq:schrket`，下一节转到位置表象时还要用它。即使暂时没有显式引用，重要定义、适用条件和可独立使用的结论也值得编号。用途尚不明确时保留已有编号。修改旧公式前，先核对已有标签和正文中手写的式号，因为增删一个编号也会改变后续式号。模板加载了 `amsmath`，其中 `\[ ... \]` 与 `equation*` 等价。[amsmath 使用手册 §3.2](https://www.latex-project.org/help/documentation/amsldoc.pdf#page=8)

独立关系若在正文中分别说明或引用，就各占一行。需要共享主编号时用 `subequations`，在 `align` 中按共同的关系符对齐，或在 `gather` 中逐行居中。组标签放在 `subequations` 开头，具体子式的标签放在对应行。下面两行给出 $x$ 方向两个自旋本征态，后文可分别引用。

~~~LaTeX
\begin{subequations}
    \label{eq:two-level-states}
    \begin{align}
        \ket{+x} &= \frac{\ket{+z} + \ket{-z}}{\sqrt{2}}, \label{eq:spin-plus-x} \\
        \ket{-x} &= \frac{\ket{+z} - \ket{-z}}{\sqrt{2}}. \label{eq:spin-minus-x}
    \end{align}
\end{subequations}
~~~

量子力学卷中，投影到这两个态的算符分别为 `$\op\Pi_{\pm x} = \ketbra{\pm x}{\pm x}$`。同一个等式的连续推导只需一个编号时，将 `aligned` 放在 `equation` 内。原本无编号的推导可用 `align*` 或 `gather*`。

~~~LaTeX
\begin{equation}
    \label{eq:spin-x-projection}
    \begin{aligned}
        \op\Pi_{+x}\ket{+z}
        &= \ket{+x}\braket{+x}{+z} \\
        &= \frac{1}{\sqrt{2}}\ket{+x}.
    \end{aligned}
\end{equation}
~~~

Hamilton 正则方程等成对短式可以并排，便于横向比较两个正则变量的位置和符号。适用条件和指标范围也可紧随主式。确有多列需要逐行对照时，用 `alignat` 并以 `\quad` 等命令设置列组间距。

章、节、小节分别使用 chapref、secref、ssecref。
重要结论连同条件放入 theorem，具体计算放入 example，
概念与符号约定放入 definition，不给孤立公式加框。

## 数学源码中的空格

新写或实质修订公式时，用普通空格帮助读源码的人看清结构。在主关系符和连接各项的二元加减号两侧各留一个空格，例如 `E = p^2/(2m) + V(x)`、`a \le b`。显式的点乘或叉乘也可这样写，如 `\bm L = \bm r \times \bm p`。对齐点放在关系符前，写作 `x &= -y + z`。一元正负号贴着操作数，简单斜线比、幂和短指标保持紧凑，如 `-x`、`p/q`、`x^2`、`a_{i+1}`、`\sum_{n=0}^N`。

数学模式中的普通源码空格通常不产生可见间距。例如 `a+b` 和 `a + b` 排印相同。控制词后接字母时要留出边界，如 `\sin x`；`\text{for all}` 里的空格属于文字。实际的数学间距由符号类别和宏决定，例如 `\int_a^b f(x) \d x` 中的微分宏已处理微分前的间距。
