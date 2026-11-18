# 数学宏与公式排版

## 微分与指数

`\d` 自带微分所需的间距，`\nd` 用于不应增加间距的分母。
`\e` 也已处理乘积中的间距，不要在这些宏前重复加薄空格。

~~~LaTeX
\int_{-\infty}^{\infty}\e^{-x^2}\d x=\sqrt{\pi}.

\d f/\nd t,\qquad \frac{\d f}{\nd t},\qquad \dv{f}{t}.
\dd[n-1]{x}\dv{y}{x}=\dv[n]{y}{x}.
\pv{y}{x},\qquad \pv[n]{y}{x},\qquad \pw{z}{x}{y}.
~~~

普通乘法紧邻书写；单位与数值之间仍可使用薄空格。

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
| 左矢、右矢、内积、外积、矩阵元 | `\bra{a}`、`\ket{b}`、`\brkt{a}{b}`、`\ktbr{a}{b}`、`\mel{a}{A}{b}` | `\bigbra`、`\Bigket`、`\biggbrkt`、`\bigktbr`、`\Bigmel` |
| 圆、方、花括号 | `(x)`、`[x]`、`\{x\}` | `\bigp`、`\Bigb`、`\biggB` |

同一条 Dirac 内积或矩阵元里，中间的竖线与两端括号使用同一档尺寸。外积将右矢与左矢相接。

~~~LaTeX
\hat A\ket{\psi},\qquad \bra{\phi}\hat A,\qquad \ktbr{a}{b}\ket{\psi}.
\mel{\phi}{\hat A}{\psi}
    =\sum_n\mel{\phi}{\hat A}{n}\brkt{n}{\psi}.
\Bigket{s=\frac12,m=\frac12},\qquad
\Bigmel{\phi}{\frac{\hat A+\hat B}{2}}{\psi}.
~~~

多行方程组的左花括号要覆盖整组方程。已有的 `\eqnset{\begin{aligned}…\end{aligned}}` 按实际行高排版。分段函数用 `cases`，矩阵可用 `pmatrix` 或 `bmatrix`。

## 分组、对齐与引用

并列关系使用 subequations。多列对齐使用 alignat，
列组之间显式加入 quad 或 enspace，不依赖自动拉伸间隔。
同一等式的连续推导使用 equation 配合 alignedat，共用一个编号。

~~~LaTeX
\begin{subequations}
    \label{eq:two-level-states}
    \begin{alignat}{2}
        \ket{+x}&=\frac{\ket{+z}+\ket{-z}}{\sqrt2},
        &\quad P_{+x}&=\ktbr{+x}{+x},\\
        \ket{-x}&=\frac{\ket{+z}-\ket{-z}}{\sqrt2},
        &\quad P_{-x}&=\ktbr{-x}{-x}.
    \end{alignat}
\end{subequations}

\begin{equation}
    \begin{alignedat}{1}
        P_{+x}\ket{+z}
        &=\ket{+x}\brkt{+x}{+z}\\
        &=\frac1{\sqrt2}\ket{+x}.
    \end{alignedat}
\end{equation}
~~~

只在数学步骤、并列关系或实际行宽需要时换行。
连续推导的等号纵向对齐；解释中间步骤的文字放在公式之间。

`\principalvalue` 表示 Cauchy 主值算符。

章、节、小节分别使用 chapref、secref、ssecref。
重要结论连同条件放入 theorem，具体计算放入 example，
概念与符号约定放入 definition，不给孤立公式加框。
