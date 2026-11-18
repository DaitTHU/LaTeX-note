# LaTeX-note

大学期间用 LaTeX 编写的中文数理课程笔记，共十卷。

> Chinese-language notes on mathematics and physics courses at Tsinghua University. Ten volumes, with LaTeX sources and MATLAB figure scripts.

## 阅读与内容状态

在 [GitHub Releases](https://github.com/DaitTHU/LaTeX-note/releases) 下载正式版 `course-notes.zip`。压缩包按课程分目录，解压后即可离线阅读全部十卷。首个正式版发布前，或想阅读某次提交的编译稿，可从[对应的成功构建](https://github.com/DaitTHU/LaTeX-note/actions/workflows/latex.yml)下载 PDF 压缩包（需登录 GitHub）。

下表表示内容覆盖程度，不代表所有公式已经校验。具体勘误、审阅范围和后续建议见 [第一轮审阅记录](docs/review-2026-11.md)、[数学审阅与经典力学重写](docs/review-math-mechanics-2026-11.md)及[量子力学重写与核验](docs/review-quantum-mechanics-2026-11.md)。

| 课程 | LaTeX 入口 | 内容状态 |
| --- | --- | --- |
| 微积分 / Calculus | [Calc.tex](Calculus/Calc.tex) | 多元微积分与含参积分四章 |
| 线性代数 / Linear Algebra | [LA.tex](Linear%20Algebra/LA.tex) | 已有十章，补齐 Jordan 等关键证明 |
| 概率论与数理统计 / Probability and Statistics | [PS.tex](Probability%20and%20Statistics/PS.tex) | 已有成稿 |
| 数学物理方法 / Methods of Mathematics and Physics | [MMP.tex](Method%20of%20Mathematics%20and%20Physics/MMP.tex) | 已有成稿，部分推导省略 |
| 数值分析 / Numerical Analysis | [NA.tex](Numerical%20Analysis/NA.tex) | 已有成稿，部分内容待补 |
| 经典力学 / Classical Mechanics | [CM.tex](Classical%20Mechanics/CM.tex) | 九章核心内容与复习题；以物理问题为主线 |
| 量子力学 / Quantum Mechanics | [QM.tex](Quantum%20Mechanics/QM.tex) | 十六章与公式核对附录；从实验目的、方法和结果展开 Dirac 记号下的推导，含定义、定理及有解例题 |
| 统计力学 / Statistical Mechanics | [SM.tex](Statistical%20Mechanics/SM.tex) | 已有成稿 |
| 电动力学 / Electrodynamics | [ED.tex](Electrodynamics/ED.tex) | 主体已有成稿；辐射部分较简略，第十章为提纲 |
| 核辐射物理及探测学 / Nuclear Radiation Physics and Detection | [NRD.tex](Nuclear%20Radiation%20and%20Detection/NRD.tex) | 主体已有成稿；两部分的第五章尚为占位 |

## 本地编译

需要 Python 3、XeLaTeX 和 latexmk。推荐安装完整的 TeX Live 或 MacTeX；精简安装至少应包含中文支持、`standalone`、`tikz`/`pgfplots`、`siunitx` v3、`tcolorbox` 等依赖。Linux 还应安装 `fonts-noto-cjk`：模板会用它补齐默认 Fandol 缺少的专业汉字，如“㶲、㷻”。Ubuntu 的安装命令见 [构建工作流](.github/workflows/latex.yml)。

首次从源文件编译时，在仓库根目录先用基础 MATLAB R2025b 生成插图，再用 Python 编译笔记。仅修改正文时可以复用已生成的插图。

```sh
matlab -batch "addpath('figures/matlab'); build_figures"

# 编译所有笔记
python3 scripts/build_notes.py

# 本地生成与发布版相同结构的十卷压缩包
python3 scripts/build_notes.py --archive course-notes.zip

# 只编译指定课程（缩写见上表入口文件）
python3 scripts/build_notes.py ED QM MMP
```

复分析目前收录了一幅圆盘到上半平面映射图，可用 `python3 scripts/build_notes.py CA` 单独编译图册。

脚本会先编译所选课程的 `figures/tikz.tex`（如有），生成图册 PDF 和带页码的 `.aux`，再编译正文。量子力学还会编译共用图册和数学记号的[独立英文笔记](Quantum%20Mechanics/ref/QM.tex)。课程 PDF 写回各课程目录。CI 的 `supplements` 下载项另含九份图册和这份英文笔记。完整输出保存在相应的 `*.build.log`，排版诊断在 `*.log`。编译错误、未解析引用、重复标签和缺失字符会使构建失败。

已有 MATLAB 插图时，也可以手动编译量子力学卷及其英文笔记：

```sh
cd 'Quantum Mechanics'
(cd figures && latexmk -xelatex -halt-on-error tikz.tex)
latexmk -xelatex -halt-on-error QM.tex
(cd ref && latexmk -xelatex -halt-on-error QM.tex)
```

GitHub Actions 在推送和拉取请求时从源码重建插图与笔记。推送 `v*` 版本标签时，发布流程把这次构建的十卷 PDF 打包为 GitHub Release 附件。

量子力学还附有代表性公式的独立数值检查，需要 NumPy 2 或更新版本：

~~~sh
python3 scripts/check_quantum_formulas.py
~~~

它检验两态动力学、微扰、辐射、纠缠、正负能解耦、光谱算例和光子符合等十四组公式；检查方法与范围见[量子力学审校记录](docs/review-quantum-mechanics-2026-11.md)。

## 源文件结构

- 各课程的 `chapters/` 存放章节、附录等正文源文件，课程入口控制阅读顺序。
- 每门用到 TikZ 的课程有一份 `figures/tikz.tex`。每页图有稳定的标签，正文按标签选页。新增、移动图页的写法见[贡献指南](CONTRIBUTING.md#插图)。
- MATLAB 绘图脚本放在各卷的 `figures/matlab/`，共用辅助函数放在仓库根目录的 `figures/matlab/`。生成的 PDF 和 PNG 写入各卷的 `figures/`。绘图需要的原始照片、核数据和衰变链表随源码提供。重画命令和数据来源见[绘图说明](CONTRIBUTING.md#matlab-绘图)。
- [thunote.cls](thunote.cls) 是共享排版类，主要参考 [ThuThesis](https://github.com/tuna/thuthesis)。中文排版由 `ctexbook` 提供，使用 XeLaTeX 编译。
- [mathdef.tex](mathdef.tex) 定义跨卷共用的数学记号，各卷入口定义课程专用符号。按概念和课程查找符号、比较约定和查看写法，可读[符号索引与公式排版示例](mathdef_example.md)。

## 常见编译问题

- 遇到 `Unknown TikZ figure` 时，先用构建脚本编译对应课程，再检查正文引用的名称是否与图页上的标签一致。
- `tcolorbox` 跨页警告：检查对应页是否有留白、丢失内容或公式溢出。编译成功不保证排版正确。
- 模板会自动替换中文句号和括号；若在特殊宏参数中发生冲突，可检查 `thunote.cls` 中的活动字符定义。
- 不同系统的默认中文字体可能不同，PDF 不保证逐字节一致。

## 勘误与贡献

欢迎通过 Issue 或 Pull Request 提交勘误。请注明课程、章节、公式或源文件位置，并给出推导、反例或教材出处；具体要求见 [贡献指南](CONTRIBUTING.md)。

本项目由个人维护，内容整理自课程讲义及教材。项目自有代码与文档（含 MATLAB 绘图脚本和辅助函数）按 [GPL-3.0 许可证](LICENSE) 提供。第三方图例、照片与数据保留各自的署名和许可条件。
