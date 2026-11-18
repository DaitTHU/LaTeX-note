# 微积分、线性代数审阅与经典力学重写（2026-11-17）

本轮继续第一轮勘误，逐章阅读了微积分现有四章、线性代数现有十章，重点检查公式、定理条件和推导中的逻辑缺口。经典力学按物理问题重新组织并补齐主体。以下记录是实际修改及验证的范围，不代表对全部数学结论作了形式化证明。

## 微积分：条件与公式一起修正

| 位置 | 主要问题 | 修改与理由 |
| --- | --- | --- |
| [多元微分](../Calculus/chapters/chap01.tex) | 混合偏导重复使用同一变量；Jacobian 输入输出维数颠倒 | 明确 `F:Rⁿ→Rᵐ` 的 Jacobian 为 `m×n`，修正偏导变量及非方阵链式法则。 |
| 同章：隐函数与反函数 | 仅假设连续；未强调局部性；反函数 Jacobian 取值点错误 | 补 `C¹`、非退化及局部唯一性；导数在对应点 `Y=F(X)` 计算。区分隐函数存在定理与已有隐函数的求导。 |
| 同章：二阶导数与极值 | 隐式求导中间式误用偏导；Taylor 余项、极值约束条件欠缺 | 重做链式求导；明确正则性、内点、约束梯度秩，说明半定 Hessian 与退化约束须另查。 |
| [含参积分](../Calculus/chapters/chap02.tex) | 一致收敛条件不一致；广义积分求导缺一个参数点的收敛；换序上下限混乱 | 统一无穷积分与瑕积分；Dirichlet/Abel 判别条件对参数一致成立；分别写出极限、求导、积分换序的充分条件。 |
| 同章：特殊积分 | Gamma/Beta 参数域缺失；Dirichlet 积分连续性论证跳步 | 补正参数域，先证一致收敛再交换极限，核对导数和端点值。 |
| [重积分](../Calculus/chapters/chap03.tex) | 球坐标被积函数漏半径；奇数维球体积阶乘错误 | 补 `x=r sinθ cosφ` 中的 `r`，把奇数维公式的普通阶乘改为双阶乘；补换元、曲面面积的正则性和覆盖条件。 |
| [曲线与曲面积分](../Calculus/chapters/chap04.tex) | Gauss 定理套用二维假设；有 Stokes 标题但无公式 | 写明三维区域、外法向与孔洞边界；补 Stokes 公式和边界方向约定，区分第一类与第二类积分的取向依赖。 |

采用的是便于复习和应用的标准充分条件，未试图寻找每条结论的最弱条件。现有内容仍不包含完整的单变量微积分课程。

## 线性代数：避免“结论碰巧对，证明却不成立”

| 章节 | 主要修改 |
| --- | --- |
| [1 矩阵](../Linear%20Algebra/chapters/chap01.tex) | 修复 Woodbury 验证、Sherman–Morrison 漏因子和幂零几何级数；补逆矩阵恒等式的可逆条件和分块尺寸。 |
| [2 线性方程组](../Linear%20Algebra/chapters/chap02.tex) | 修复行倍加矩阵方向、秩一逆公式；明确 `0=0` 并不自动意味着无穷多解；一般 LU 需要行置换，LDU 需要非零主元。 |
| [3 向量空间](../Linear%20Algebra/chapters/chap03.tex) | 列空间基必须取原矩阵的主元列，不能取 rref 的列；修复零空间基的主元行列指标、维数唯一性证明的反向不等式。 |
| [4 正交性](../Linear%20Algebra/chapters/chap04.tex) | 重写正交分解证明；区分最小二乘拟合向量唯一与系数唯一；修正直线拟合斜率符号；补 Gram–Schmidt 线性相关边界，薄 QR 中矩形 `Q` 仅列正交。 |
| [5 行列式](../Linear%20Algebra/chapters/chap05.tex) | 补 Schur 行列式证明及奇异对角块情况；明确伴随矩阵低维边界、反求原矩阵的多解和 Jacobi 公式在奇异点的形式。 |
| [6 特征值](../Linear%20Algebra/chapters/chap06.tex) | 修复特征多项式三阶系数、广义特征向量证明和 Fitting 分解；明确 Jordan 型的分裂域条件；补全幂零映射 Jordan 链构造；正定主元判据禁止任意换行。 |
| [7 SVD](../Linear%20Algebra/chapters/chap07.tex) | 修复左零空间基、秩一外积维度和范数证明；补伪逆四条件与全部最小二乘解；PCA 补转置、中心化、方向与得分的区别。 |
| [8 线性映射](../Linear%20Algebra/chapters/chap08.tex) | 修正核像、表示矩阵和对偶换基的指标；补秩–零化度证明、双重对偶有限维条件及张量积普遍性质。 |
| [9 复内积](../Linear%20Algebra/chapters/chap09.tex) | 修复线性公理的变量；首一 Legendre 二次多项式改为 `x²−1/3`；区分两套 Hermite 约定；补伴随、正规谱定理和非正交基的 Gram 矩阵。 |
| [10 群、环与域](../Linear%20Algebra/chapters/chap10.tex) | 补子群、循环群、正规子群条件；用一般群论证替代线性空间特例；补商群良定义、第一同构定理，以及原标题中缺失的环、域基础。 |

几项很短的反例能帮助记住条件：

- `A=[[1,2],[1,2]]` 的 rref 主元列不属于原列空间。
- `[[0,1],[1,0]]` 换行后可以出现正主元，但原矩阵不是正定矩阵，也没有不换行的通常 LU 分解。
- 三阶矩阵满足 `adj(I)=adj(−I)=I`，所以由伴随矩阵恢复原矩阵可能不唯一。
- `A(t)=diag(t,2,3)` 在 `t=0` 奇异，但行列式导数仍为 `6`；不能直接套含 `A⁻¹` 的表达。

仍保留明确标为“证明略”的部分；本轮补齐关键逻辑，不把讲义扩展成完整的抽象代数或无限维泛函分析教材。

## 经典力学：从运动问题出发的九章复习稿

入口为 [CM.tex](../Classical%20Mechanics/CM.tex)，成稿在十卷压缩包中的 `Classical Mechanics/CM.pdf`。移除了以仿射空间、拓扑、流形和图册定义开篇的组织方式。必要坐标工具在使用时简要引入，核心顺序改为：

1. **运动方程与守恒律**：受力、功率、质心、碰撞和火箭，先界定系统和参考系。
2. **中心力与两体问题**：约化质量、有效势、稳定圆轨道、Kepler 轨道、Rutherford 散射和 Virial 条件。
3. **振动、共振与相图**：自由与受迫响应、不同共振频率、有限振幅单摆与分离曲线；新增可直接编译的相图。
4. **非惯性系**：从基矢求导得到惯性力，解释旋转系能量和 Foucault 进动方向。
5. **约束与 Lagrange 方程**：从单摆和虚功推导方程，补驻定作用量、耗散、循环坐标、Noether 关系与旋转圆环例子。
6. **耦合小振动**：质量矩阵与广义特征值、双摆、零模，以及质点链到弦方程的连续极限。
7. **刚体**：惯性张量、Euler 方程、中间轴不稳定、自由和重对称陀螺、无滑动滚动的摩擦条件。
8. **Hamilton 方程与相空间**：Legendre 正则性、磁场中的正则动量、Poisson 括号、Liouville 定理、Verlet 方法。
9. **正则变换与 Hamilton–Jacobi**：生成函数、作用量–角变量、绝热不变量、完全积分和适用边界。

附录给出方法选择表和九道带核对结果的短题，覆盖圆轨道、共振、加速支点、零模、滚动、磁场、参数缓变与骤变、正则缩放和数值稳定性。正文使用固定端点变分、非退化小振动等明确条件；没有把“驻定”一概写成“最小”，也没有把 Hamiltonian 一概认作实验室系机械能。

参考书的取舍是：用 [Taylor](https://uscibooks.aip.org/books/classical-mechanics/) 组织本科力学主线，用 [Morin](https://davidmorin.physics.fas.harvard.edu/books/classical-mechanics/) 衔接问题求解与分析力学，用 [Tong 的公开讲义](https://davidtong.org/teaching/classical-dynamics/) 核对 Lagrange、刚体与 Hamilton 方法，Goldstein 第三版作为进阶查阅。推导和短题重新编写，不照搬教材原文或习题。各章给出主题阅读提示。

这是一份紧凑的本科核心复习稿；相对论、完整的连续介质力学、Dirac 约束理论以及混沌的系统数值研究不在本轮范围内。

## 验证记录

在仓库根目录运行：

```sh
python3 scripts/build_notes.py Calc LA CM
```

三卷均通过 XeLaTeX + latexmk 编译，并同步更新仓库中的 PDF。代表性公式另作独立代数、反例或数值核验：

- 微积分：非方阵链式法则、对应点反函数 Jacobian、二阶隐函数、1–9 维球体积、球内 `x²` 积分、阻尼 Dirichlet 积分及 Stokes 方向。
- 线性代数：100 组 Woodbury 恒等式；列空间反例和含跳列主元的零空间；秩亏最小二乘、薄 QR、奇异 Schur 块；30 个矩阵的特征系数与 Cayley–Hamilton；递归 Jordan 链；伪逆四条件、PCA、对偶换基、正交多项式及商群代表元。
- 经典力学：质心动能分解、圆锥曲线能量、幂律圆轨道曲率、阻尼功率峰宽、Foucault 进动符号；双摆模及质量内积；Euler 守恒量与重陀螺降维；Legendre 变换、磁场 Poisson 括号、两种正则平移、作用量周期关系与 Hamilton–Jacobi 残差；移动支点、骤变能量、绝热近似和 Verlet 临界步长。

绝热条件特别作了反例检查：`ω²=1+0.02 cos(2t)` 的 `|ω̇|/ω²` 虽很小，仍可发生参量共振。正文因此采用一致的慢时间假设，而不把一个小的一阶导数比值当作充分条件。有关讨论参阅 [Wells–Siklos 的绝热不变量推导](https://arxiv.org/html/physics/0610084v1)。

数值核验只检验代表性的公式与约定，不能替代定理证明。

最终 PDF 为微积分 **20 页**、线性代数 **85 页**、经典力学 **34 页**。微积分与经典力学逐页渲染查看，线性代数检查各章关键修改页及相邻页。修复了 Jacobian 框分页、LDU 孤句页、化学例后的强制留白、SVD 图题分离及经典力学章末孤页；核对目录链接与正文首页页锚。三卷最终日志无 Overfull/Underfull、缺失字符、未解析引用或重复标签，仍有模板原有的宋体斜体/倾斜体替代提示。

本轮未修改共享模板，因此内容修订后的重新编译范围为这三卷。本文审阅完成时尚未提交或推送；后续远端构建状态以 [GitHub Actions](https://github.com/DaitTHU/LaTeX-note/actions/workflows/latex.yml) 的实际记录为准。

提交前另以拟提交文件在临时目录中完成全部十卷的干净构建，不使用工作区的 `.aux`、`.log` 或 latexmk 缓存。十卷均通过，生成 PDF 的页数与工作区版本一致。

首次 Linux CI 编译通过前七卷后，在统计力学发现 Fandol 缺少“㶲、㷻”，因此被缺字检查阻止。后续在 CI 中安装 `fonts-noto-cjk`，共享模板按需启用 Noto Serif CJK SC 回退，保留原有主字体与专业术语。此项平台兼容修正发生在前述三卷内容审阅之后。

## 数学核对资料

- Rice：[逆函数与隐函数定理](https://math.rice.edu/~hardt/401F03/ift.pdf)；Keith Conrad：[积分号下求导](https://kconrad.math.uconn.edu/blurbs/analysis/diffunderint.pdf)。
- NIST DLMF：[Gamma 函数](https://dlmf.nist.gov/5.2)、[Beta 函数](https://dlmf.nist.gov/5.12)、[正交多项式约定](https://dlmf.nist.gov/18.3)；OpenStax：[Stokes 定理](https://openstax.org/books/calculus-volume-3/pages/6-7-stokes-theorem)。
- MIT：[矩阵分解](https://math.mit.edu/~gs/everyone/lucrweb.pdf)、[SVD 课程](https://ocw.mit.edu/courses/18-065-matrix-methods-in-data-analysis-signal-processing-and-machine-learning-spring-2018/resources/lecture-6-singular-value-decomposition-svd/)；Kahan：[Jacobi 行列式微分公式](https://people.eecs.berkeley.edu/~wkahan/MathH110/jacobi.pdf)。
- Sergei Treil：[Advanced Spectral Theory](https://www.math.brown.edu/streil/papers/LADW/HTML_2026_08-31/Ch9.html)；Waterloo：[陪集与商群](https://www.math.uwaterloo.ca/~snew/pmath347-2024-S/Notes/Chap5QuotientGroups.pdf)。
