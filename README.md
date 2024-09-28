# LaTeX-note

用 LaTeX 编写的数理课笔记。适用于期末复习，可能不适用于预习。

笔记语言：中文。为方便阅读（母语 + 字母符号在汉字中更易区分）。

已收录（排名并不按照学期顺序）：

- 微积分A（待补完） Calculus (unfinished)
- 线性代数 Linear Algebra
- 概率论与数理统计 Probability and Statistics
- 数学物理方法 Methods of Mathematics and Physics
- 经典力学（待补完） Classical Mechanics (unfinished)
- 量子力学（重写中） Quantum Mechanics (rewriting)
- 统计力学 Statistical Mechanics
- 电动力学 Electrodynamics
- 核辐射物理及探测学 Nuclear Radiation Physics and Detection

同时提供了 `.tex` 源文件和 `.pdf` 文件。



## 如何处理 `.tex` 文件

使用 XeLaTeX 编译，因为这样中英字符之间自动空格。

`thunote.cls` 主要参考自 [ThuThesis 项目](https://github.com/tuna/thuthesis)，每一个笔记都需要在开头导入。

`mathdef.tex` 中是一些简化代码的定义。可见 [mathdef_example.md](mathdef_example.md)

每个笔记对应一个文件夹，其主要内容都在 `/data` 子文件夹中。`main.tex` 中的典型内容为：

```LaTeX
\documentclass{../thunote}

\input{../mathdef.tex}

\begin{document}

\title{电动力学\\Electrodynamics}
\maketitle

\frontmatter
\tableofcontents

\mainmatter
\input{data/chap01.tex}

\appendix
\input{data/appendix.tex}

\end{document}
```



## 已知的可能导致编译报错的问题：

- `hair.tex` 的 `\catcode` 指令 (line 6-11)。其本意是编译时自动将中文句号变为全角实心句号，中文括号变为英文括号。将其注释掉可能会解决编译报错问题。
