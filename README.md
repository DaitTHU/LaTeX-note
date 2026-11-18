# LaTeX-note

大学期间用 LaTeX 编写的中文数理课程笔记，包含源文件与可直接阅读的 PDF。

> Chinese-language notes on mathematics and physics courses at Tsinghua University. LaTeX sources and compiled PDFs are included.

## 阅读与内容状态

下表表示内容覆盖程度，不代表所有公式已经校验。具体勘误、审阅范围和后续建议见 [第一轮审阅记录](docs/review-2026-11.md)及[数学审阅与经典力学重写](docs/review-math-mechanics-2026-11.md)。

| 课程 | PDF | LaTeX 入口 | 内容状态 |
| --- | --- | --- | --- |
| 微积分 / Calculus | [阅读](Calculus/Calc.pdf) | [Calc.tex](Calculus/Calc.tex) | 多元微积分与含参积分四章 |
| 线性代数 / Linear Algebra | [阅读](Linear%20Algebra/LA.pdf) | [LA.tex](Linear%20Algebra/LA.tex) | 已有十章，补齐 Jordan 等关键证明 |
| 概率论与数理统计 / Probability and Statistics | [阅读](Probability%20and%20Statistics/PS.pdf) | [PS.tex](Probability%20and%20Statistics/PS.tex) | 已有成稿 |
| 数学物理方法 / Methods of Mathematics and Physics | [阅读](Method%20of%20Mathematics%20and%20Physics/MMP.pdf) | [MMP.tex](Method%20of%20Mathematics%20and%20Physics/MMP.tex) | 已有成稿，部分推导省略 |
| 数值分析 / Numerical Analysis | [阅读](Numerical%20Analysis/NA.pdf) | [NA.tex](Numerical%20Analysis/NA.tex) | 已有成稿，部分内容待补 |
| 经典力学 / Classical Mechanics | [阅读](Classical%20Mechanics/CM.pdf) | [CM.tex](Classical%20Mechanics/CM.tex) | 九章核心内容与复习题；以物理问题为主线 |
| 量子力学 / Quantum Mechanics | [阅读](Quantum%20Mechanics/QM.pdf) | [QM.tex](Quantum%20Mechanics/QM.tex) | 重写中；`ref/` 为旧稿 |
| 统计力学 / Statistical Mechanics | [阅读](Statistical%20Mechanics/SM.pdf) | [SM.tex](Statistical%20Mechanics/SM.tex) | 已有成稿 |
| 电动力学 / Electrodynamics | [阅读](Electrodynamics/ED.pdf) | [ED.tex](Electrodynamics/ED.tex) | 主体已有成稿；辐射部分较简略，第十章为提纲 |
| 核辐射物理及探测学 / Nuclear Radiation Physics and Detection | [阅读](Nuclear%20Radiation%20and%20Detection/NRD.pdf) | [NRD.tex](Nuclear%20Radiation%20and%20Detection/NRD.tex) | 主体已有成稿；两部分的第五章尚为占位 |

## 本地编译

需要 Python 3、XeLaTeX 和 latexmk。推荐安装完整的 TeX Live 或 MacTeX；精简安装至少应包含中文支持、`standalone`、`tikz`/`pgfplots`、`siunitx`、`tcolorbox` 等依赖。Linux 还应安装 `fonts-noto-cjk`：模板会用它补齐默认 Fandol 缺少的专业汉字，如“㶲、㷻”。Ubuntu 的安装命令见 [构建工作流](.github/workflows/latex.yml)。

在仓库根目录运行：

```sh
# 编译所有笔记
python3 scripts/build_notes.py

# 只编译指定课程（缩写见上表入口文件）
python3 scripts/build_notes.py ED QM MMP
```

脚本会先编译电动力学、数值分析依赖的 TikZ 图册，生成外部引用需要的 `.aux`，再由 latexmk 自动完成多轮 XeLaTeX 编译。PDF 写回各课程目录；完整输出保存在相应的 `*.build.log`，详细排版诊断在 `*.log`。编译错误、未解析引用、重复标签和缺失字符会使构建失败；其他排版警告仍需人工检查。

单独手动编译时，应先进入课程目录，例如：

```sh
cd 'Method of Mathematics and Physics'
latexmk -xelatex -interaction=nonstopmode -halt-on-error MMP.tex
```

GitHub Actions 使用同一脚本，成功后提供 PDF 下载产物。自动编译检查的是文档构建，不能代替物理审阅。

## 源文件结构

- 各课程的 `chapters/` 存放正文，入口文件控制章节顺序。
- `figures/` 存放插图，`figures/tikz/` 中的 `.tex` 可单独编译；构建脚本使用已收录的插图 PDF，只自动重建有外部标签依赖的图册。
- [thunote.cls](thunote.cls) 是共享排版类，主要参考 [ThuThesis](https://github.com/tuna/thuthesis)。中文排版由 `ctexbook` 提供，使用 XeLaTeX 编译。
- [mathdef.tex](mathdef.tex) 定义共享数学宏，示例见 [mathdef_example.md](mathdef_example.md)。

## 常见编译问题

- `No file figures/tikz/layouts.aux`：先编译图册，或直接使用上面的构建脚本；不要忽略警告后继续使用错误的图页。
- `tcolorbox` 跨页警告：检查对应页是否有留白、丢失内容或公式溢出。编译成功不保证排版正确。
- 模板会自动替换中文句号和括号；若在特殊宏参数中发生冲突，可检查 `thunote.cls` 中的活动字符定义。
- 不同系统的默认中文字体可能不同，PDF 不保证逐字节一致。

## 勘误与贡献

欢迎通过 Issue 或 Pull Request 提交勘误。请注明课程、章节、公式或源文件位置，并给出推导、反例或教材出处；具体要求见 [贡献指南](CONTRIBUTING.md)。

本项目由个人维护，内容整理自课程讲义及教材，不宣称原创或无误。代码与文档按仓库中的 [GPL-3.0 许可证](LICENSE) 提供；引用课程材料时仍应注明原始来源。
