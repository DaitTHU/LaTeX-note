# 贡献指南

欢迎公式勘误、推导补全、例题和排版改进。请尽量一次处理一个明确问题，保留作者原有符号约定和章节结构。

## 提交物理或数学勘误

请说明：

1. 课程、章节及源文件位置，原式或原论断是什么。
2. 修正后的表达式，以及使用的单位制、符号约定和适用条件。
3. 验证依据：简短推导、量纲检查、守恒律、极限情形或独立计算。若查阅资料，注明作者、书名、版本和页码，或给出公开讲义的稳定链接。

避免只替换结论而保留错误的中间步骤。对复振幅明确时间约定，对量子态明确归一化和边界条件，对统计结果区分模型假设、近似和实测结论。尚未确认的问题可以先在 Issue 中讨论，不必改成确定结论。

## 编译与排版检查

首次构建时先按下文的 MATLAB 命令生成插图。在仓库根目录运行 `python3 scripts/build_notes.py 课程缩写`。修改共享模板或数学宏时，应运行 `python3 scripts/build_notes.py` 检查所有入口。

打开生成的 PDF，检查修改页及相邻页的公式换行、图表、引用和页眉。提交源文件即可，课程 PDF、TikZ 图册和可重画的插图由 CI 生成。`.aux`、`.log`、`.xdv` 等中间文件由本地构建生成。

当前自动检查不能验证物理正确性，也不把所有排版警告视为错误。请在 PR 中简述验证方法和仍未解决的问题。

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

### MATLAB 绘图

从仓库根目录运行以下命令，可使用仓库自带的输入一次生成全部 MATLAB 插图。

```sh
matlab -batch "addpath('figures/matlab'); build_figures"
```

修改单幅图时，也可以在 MATLAB 中单独运行对应脚本。例如：

```matlab
addpath('figures/matlab')
run('Quantum Mechanics/figures/matlab/free_packet.m')
```

`run` 在脚本所在目录执行，图稿写回该卷的 `figures/`，会覆盖对应的 PDF 或 PNG。部分脚本一次生成多幅图，例如数值分析的 `Runge.m` 同时输出等距节点与 Chebyshev 节点的插值对照图。新增可自动重画的插图时，把脚本加到 `figures/matlab/build_figures.m`。课程目录和各卷 `figures/` 下生成的 PDF 已加入 `.gitignore`。

这些脚本在基础 MATLAB R2025b 上运行。分布曲线直接计算概率质量或密度，自助抽样用 `randi` 生成有放回的抽样索引，费米积分用 `integral` 计算。

导出带图例的矢量 PDF 时，用 `pad_legend(legend(...))` 给文字右侧留白。已有图例句柄也可以直接传给 `pad_legend(lgd)`。LaTeX 图例使用 `\hspace{0.6em}`，其他图例使用两个不换行空格。普通行尾空格在导出时会被 MATLAB 裁掉。

线性代数和核辐射卷的绘图输入保存在各卷的 `figures/matlab/inputs/` 中。

- `svcompress.m` 对 `Original_Doge_meme.jpg` 的灰度矩阵作奇异值分解，比较不同截断秩的近似。原照片由佐藤敦子（Atsuko Sato）拍摄，著作权归原作者。[照片来源与权利说明](https://en.wiktionary.org/wiki/File:Original_Doge_meme.jpg)
- `binding_energy.m` 使用 NuDat 导出的 `nndc_nudat_data_export.csv` 和元素符号表 `symbol.mat`。CSV 中的 `z`、`n` 分别是质子数和中子数，`bindingEnergy(keV)` 是以 keV 表示的每核子结合能。[NNDC NuDat](https://www.nndc.bnl.gov/nudat3/)
- `halflife.m` 使用 `halfLife.mat` 中的矩阵 `halfLife(N,Z)`，单位为秒。无穷大表示稳定核素，NaN 表示缺少数据。
- `decay_system.m` 从随附的边表绘制钍系、铀系和锕铀系三页衰变链，正文按此顺序选页。表中各分支的母核、子核、分支比、半衰期和同质异能跃迁标记取自作者本科项目的衰变链计算。[Radiation](https://github.com/DaitTHU/Radiation)

核壳层模型的自旋–轨道分裂图由 `figures/tikz.tex` 中的 `spin-orbit-splitting` 图页生成。

绘图脚本和共用辅助函数采用仓库的 [GPL-3.0 许可](LICENSE)。引入其他作者的代码、照片或数据时，请在相应文件或说明中保留来源和许可。
