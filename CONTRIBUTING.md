# 贡献指南

欢迎公式勘误、推导补全、例题和排版改进。请尽量一次处理一个明确问题，保留作者原有符号约定和章节结构。

## 提交物理或数学勘误

请说明：

1. 课程、章节及源文件位置，原式或原论断是什么。
2. 修正后的表达式，以及使用的单位制、符号约定和适用条件。
3. 验证依据：简短推导、量纲检查、守恒律、极限情形或独立计算。若查阅资料，注明作者、书名、版本和页码，或给出公开讲义的稳定链接。

避免只替换结论而保留错误的中间步骤。对复振幅明确时间约定，对量子态明确归一化和边界条件，对统计结果区分模型假设、近似和实测结论。尚未确认的问题可以先在 Issue 中讨论，不必改成确定结论。

## 编译与排版检查

首次构建先按[MATLAB 绘图](#matlab-绘图)生成插图，再用 XeLaTeX 和 latexmk 编译笔记。Ubuntu 的 TeX Live 包和中文字体清单见[构建工作流](.github/workflows/latex.yml)。

从仓库根目录运行 `python3 scripts/build_notes.py QM` 可编译量子力学图册和正文。将 `QM` 换成其他课程缩写即可编译相应卷。修改共享模板或数学宏后，运行 `python3 scripts/build_notes.py` 编译所有入口。

CI 分别缓存每门课的 MATLAB 插图、每份 TikZ 图册及每个笔记入口。绘图脚本或输入数据变更会重画该课程的图，共用 MATLAB 函数的变更会重画所有 MATLAB 图。TeX 根据上次编译实际读过的文件逐项核对内容，图册的 PDF 和带页码的 `.aux` 一起恢复。修改某卷的正文通常只重编该卷。新增、删除或改名构建输入时，CI 会重新建立 TeX 缓存，以识别首次出现的可选输入。构建环境更新、缓存过期或校验失败时也会重新编译相应产物。

编译失败时，查看出错入口旁的 `*.build.log` 获取完整命令输出，或查看 `*.log` 定位 TeX 报错。出现 `Unknown TikZ figure` 时，核对正文引用与图册中的标签，再用构建脚本按顺序重编图册和正文。Linux 上如提示缺少“㶲”等专业汉字，检查是否安装了 `fonts-noto-cjk`。

打开生成的 PDF，检查修改页及相邻页的公式换行、图表、引用和页眉。遇到 `tcolorbox` 跨页警告时，着重检查框内文字与公式是否完整。提交源文件即可，课程 PDF、TikZ 图册和 MATLAB 插图由 CI 生成。

## 插图

同一课程的 TikZ 图片写在 `figures/tikz.tex`。例如，在量子力学图册的正文中加入一页：

```tex
\begin{tikzpicture}
  \label{spin-axis}
  \draw[->] (0,0) -- (0,1) node[above] {$z$};
\end{tikzpicture}
```

课程入口用 `\externaldocument[tikz:]{figures/tikz}` 读入页码。章节里用稳定的名称选图，`\tikzfigure` 的可选参数与 `\includegraphics` 相同：

```tex
\begin{figure}[htbp]
  \centering
  \tikzfigure[width=.3\linewidth]{spin-axis}
  \caption{自旋测量的量子化轴}\label{fig:spin-axis}
\end{figure}
```

图册里的 `spin-axis` 决定导入哪一页，章节里的 `fig:spin-axis` 用于引用正文图号。移动或增加图页后运行课程构建命令即可更新两者。图源含有作者、出处和许可说明时，请在对应图组旁保留。

### 让图表和题注同页

允许浮动时，把图与 `\caption` 一起放进 `figure`，把表与 `\caption` 一起放进 `table`。在例题框内或需要原位排版时，用模板提供的 `notecaptionblock`。它用当前行宽的 `minipage` 包住整组内容，页底空间不足时整组移到下一页。

```tex
\begin{notecaptionblock}
  \tikzfigure[width=.3\linewidth]{spin-axis}
  \captionof{figure}{自旋测量的量子化轴}\label{fig:spin-axis}
\end{notecaptionblock}
```

原位短表同样放在一个 `notecaptionblock` 内，先写 `\captionof{table}{表题}\label{...}`，再写 `tabular`。跨页长表使用 `longtable`，把表题和首段表头放在 `\endfirsthead` 之前，并用 `\endhead` 指定续页表头。

### 坐标轴和色标

对有量纲且带数值刻度的坐标轴，MATLAB 和 TikZ 都用“量符号 / 单位符号”。例如，`t/s` 轴的刻度 2 表示 2 秒。量符号用斜体，单位符号用正体；复合单位用括号括起，例如 $v/(\mathrm{m}\,\mathrm{s}^{-1})$。色条遵循同一写法。前缀应与送入绘图函数的数值一致，例如将以米记录的波长乘以 $10^9$ 后，轴标写作 $\lambda/\mathrm{nm}$。[BIPM《国际单位制手册》§5.4.1](https://www.bipm.org/en/publications/si-brochure)；[NIST SP 811 §7.1](https://www.nist.gov/pml/special-publication-811/nist-guide-si-chapter-7-rules-and-style-conventions-expressing-values)

归一化的量直接标出比值，例如 $t/\tau$；概率、量子数和核子计数直接写 $P$、$n$、$Z$。度和弧度用于数值角度轴时标明所选角单位。仅示意方向的坐标箭头可以只标符号。

### MATLAB 绘图

从仓库根目录运行以下命令，可使用仓库自带的输入一次生成全部 MATLAB 插图。

```sh
matlab -batch "addpath('figures/matlab'); build_figures"
```

只改一门课的插图时，可以运行 `build_figures("Quantum Mechanics")` 重画这一卷。修改单幅图时，也可以在 MATLAB 中单独运行对应脚本。例如：

```matlab
addpath('figures/matlab')
run('Quantum Mechanics/figures/matlab/free_packet.m')
```

`run` 在脚本所在目录执行，图稿写回该卷的 `figures/`，会覆盖对应的 PDF 或 PNG。部分脚本一次生成多幅图，例如数值分析的 `Runge.m` 同时输出等距节点与 Chebyshev 节点的插值对照图。新增可自动重画的插图时，把脚本加到 `figures/matlab/build_figures.m`。课程目录和各卷 `figures/` 下生成的 PDF 已加入 `.gitignore`。

这些脚本在基础 MATLAB R2025b 上运行。分布曲线直接计算概率质量或密度，自助抽样用 `randi` 生成有放回的抽样索引，费米积分用 `integral` 计算。

导出带图例的矢量 PDF 时，用 `pad_legend(legend(...))` 给文字右侧留白。已有图例句柄也可以直接传给 `pad_legend(lgd)`。LaTeX 图例使用 `\hspace{0.6em}`，其他图例使用两个不换行空格。普通行尾空格在导出时会被 MATLAB 裁掉。

电动力学、线性代数和核辐射卷的绘图输入保存在各卷的 `figures/matlab/inputs/` 中。

- `water_dispersion.m` 读取 `water_hale_querry_1973.csv` 中 25 °C 液态水的 108 组光学常数。三列依次为真空波长（µm）、折射率实部和消光系数。数据取自原论文表 I 在 0.35–10 µm 范围内的表值，电子转录采用 CC0 许可。图中的强度吸收系数由波长和消光系数换算。[Hale 与 Querry 原论文](https://doi.org/10.1364/AO.12.000555) · [电子数据与许可](https://refractiveindex.info/?shelf=main&book=H2O&page=Hale)
- `svcompress.m` 对 `Original_Doge_meme.jpg` 的灰度矩阵作奇异值分解，比较不同截断秩的近似。摄影者为佐藤敦子（Atsuko Sato）。来源页将原照片列为受著作权保护的非自由内容。[照片来源与权利说明](https://en.wiktionary.org/wiki/File:Original_Doge_meme.jpg)
- `binding_energy.m` 使用 NuDat 导出的 `nndc_nudat_data_export.csv` 和元素符号表 `symbol.mat`。CSV 中的 `z`、`n` 分别是质子数和中子数，`bindingEnergy(keV)` 是以 keV 表示的每核子结合能。[NNDC NuDat](https://www.nndc.bnl.gov/nudat3/)
- `halflife.m` 使用 `halfLife.mat` 中的矩阵 `halfLife(N,Z)`，单位为秒。无穷大表示稳定核素，NaN 表示缺少数据。
- `decay_system.m` 用 `decay_series.csv` 依次绘制钍系、铀系和锕铀系。边表取自作者的 Radiation 项目，保留原图中母核、子核、跃迁强度和半衰期的对应关系。原程序把相同质子数与中子数的核态合并到同一节点，`parentState` 标记产生该条边记录的母核态。[Radiation 的衰变链计算](https://github.com/DaitTHU/Radiation/blob/2629d2662865b396c23c6d0524886d3f662dd487/%40Nuclide/decayChain.m)

核壳层模型的自旋–轨道分裂图由 `figures/tikz.tex` 中的 `spin-orbit-splitting` 图页生成。

绘图脚本和共用辅助函数采用仓库的 [GPL-3.0 许可](LICENSE)。引入其他作者的代码、照片或数据时，请在相应文件或说明中保留来源和许可。
