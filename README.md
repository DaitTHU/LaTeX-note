# LaTeX-note

大学期间用 LaTeX 编写的十卷中文数理课程笔记。

> Chinese-language notes on mathematics and physics courses at Tsinghua University, with LaTeX sources and MATLAB figure scripts.

**[下载十卷笔记 PDF（ZIP）](https://github.com/DaitTHU/LaTeX-note/releases/latest/download/course-notes.zip)**。解压后，每门课程对应一个目录，可离线阅读。旧版本可在[历次发布](https://github.com/DaitTHU/LaTeX-note/releases)中查找。

## 课程目录

| 课程 | LaTeX 入口 | 主要内容 |
| --- | --- | --- |
| 微积分 | [Calc.tex](Calculus/Calc.tex) | 多元微分、含参积分、重积分、曲线积分与曲面积分 |
| 线性代数 | [LA.tex](Linear%20Algebra/LA.tex) | 线性方程组、正交性、特征值、奇异值分解与线性映射 |
| 概率论与数理统计 | [PS.tex](Probability%20and%20Statistics/PS.tex) | 概率分布、极限定理、估计与检验、回归、随机过程与测量不确定度 |
| 数学物理方法 | [MMP.tex](Method%20of%20Mathematics%20and%20Physics/MMP.tex) | 定解问题、分离变量、积分变换与基本解。部分推导从略 |
| 数值分析 | [NA.tex](Numerical%20Analysis/NA.tex) | 方程求解、特征值、插值与逼近、数值积分与常微分方程。部分内容待补 |
| 经典力学 | [CM.tex](Classical%20Mechanics/CM.tex) | 从牛顿力学、中心力和振动到刚体与哈密顿力学，附复习题 |
| 量子力学 | [QM.tex](Quantum%20Mechanics/QM.tex) | 从实验引入量子态与测量，再讨论动力学、角动量、近似方法、光谱和散射，附公式核对 |
| 统计力学 | [SM.tex](Statistical%20Mechanics/SM.tex) | 热力学与临界现象、系综与 Ising 链、量子气体和费米液体、输运与线性响应、有限温度格林函数 |
| 电动力学 | [ED.tex](Electrodynamics/ED.tex) | 电磁场、平面波、波导、多极辐射与相对论。第十章为提纲 |
| 核辐射物理及探测学 | [NRD.tex](Nuclear%20Radiation%20and%20Detection/NRD.tex) | 放射性衰变、辐射与物质的相互作用、探测器和计数测量。上下两部分的第五章待补 |

使用旧版笔记时，可查阅[勘误](docs/errata.md)。九份独立图册可在对应提交的 [GitHub Actions 构建](https://github.com/DaitTHU/LaTeX-note/actions/workflows/latex.yml)中下载 `supplements`（需登录 GitHub）。

## 从源码编译

需要 Python 3、XeLaTeX 和 latexmk。首次构建时，在仓库根目录用基础 MATLAB R2025b 生成插图，再编译十卷笔记并打包。Ubuntu 的 TeX Live 包和中文字体清单见[构建工作流](.github/workflows/latex.yml)。

```sh
matlab -batch "addpath('figures/matlab'); build_figures"
python3 scripts/build_notes.py --archive course-notes.zip
```

插图生成后，也可以只编译一门课，例如 `python3 scripts/build_notes.py QM`。脚本会先编译该卷的 TikZ 图册，再编译正文，并将 PDF 写入课程目录。复分析目前只收录了一幅共形映射图，可用 `python3 scripts/build_notes.py CA` 单独编译图册。

GitHub Actions 会复用同一构建环境下已校验的插图和笔记。只改一章正文时，通常只重编该卷。修改 MATLAB 脚本或绘图数据时，会重画该课程的 MATLAB 图。每次发布都将完整的十卷 PDF 打包。

## 勘误与贡献

欢迎通过 Issue 或 Pull Request 提交勘误。请注明课程、章节和公式或源文件位置，并附推导、反例或参考出处。绘图约定、数据来源和构建排查见[贡献指南](CONTRIBUTING.md)，跨卷共用记号见[数学符号与排版示例](mathdef_example.md)。

笔记整理自课程讲义及教材。[共享排版类](thunote.cls)主要参考 [ThuThesis](https://github.com/tuna/thuthesis)。项目自有代码与文档采用 [GPL-3.0 许可证](LICENSE)。第三方图例、照片与数据保留各自的署名和许可条件。
