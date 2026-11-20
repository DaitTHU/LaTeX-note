# 旧版笔记勘误

以下选取会改变计算结果、实验解释或定理适用条件的旧版问题。量子力学和经典力学曾调整章节顺序，链接均指向现版正文。

## 微积分与线性代数

- **反函数的导数取值点。** 对连续可微的同维映射 $F$，若 $DF(x_0)$ 可逆，则 $F$ 在 $x_0$ 附近有可微逆映射。旧版混用了输入点和像点。令 $y_0=F(x_0)$，正确公式为 $D(F^{-1})(y_0)=[DF(x_0)]^{-1}$。导数在一点可逆给出局部结论。[微积分·隐函数与反函数](../Calculus/chapters/chap01.tex)
- **原矩阵的列空间。** 行化简可用来找主元列的编号，列空间的基要回到原矩阵取。例如 $A=\left(\begin{smallmatrix}1&2\\1&2\end{smallmatrix}\right)$ 的第一列是 $(1,1)^{\mathsf T}$，化简后第一列 $(1,0)^{\mathsf T}$ 已经落在原列空间之外。[线性代数·向量空间](../Linear%20Algebra/chapters/chap03.tex)
- **奇异点的行列式导数。** 对可微方阵 $A(t)$，有 $(\det A)'=\operatorname{tr}(\operatorname{adj}(A)A')$。只有 $A$ 可逆时，才可将伴随矩阵改写为 $(\det A)A^{-1}$。取 $A(t)=\operatorname{diag}(t,2,3)$，在 $t=0$ 处矩阵奇异，行列式 $6t$ 的导数仍为 $6$。[线性代数·行列式](../Linear%20Algebra/chapters/chap05.tex) · [Kahan 的 Jacobi 公式推导](https://people.eecs.berkeley.edu/~wkahan/MathH110/jacobi.pdf)

## 数学物理、概率统计与数值分析

- **热传导边界的导数方向。** 旧版在 Neumann 条件和半轴的 Robin 条件中写入了时间导数。给定边界通量时，应沿空间外法向取导数。半轴 $x>0$ 在左端满足 $\partial_n u=-\partial_xu$，故 $\partial_n u+\sigma u=g$ 在此处写成 $-u_x(0,t)+\sigma u(0,t)=g(t)$。[数学物理方法·定解条件](../Method%20of%20Mathematics%20and%20Physics/chapters/chap01.tex)
- **显著性水平和不拒绝。** 显著性水平 $\alpha$ 是事先规定的第一类错误概率上界。对给定的零假设分布，$p$ 值是检验统计量出现当前观测值或更极端取值的概率，哪些取值更极端由检验预先规定。$p>\alpha$ 时结论为不拒绝零假设。旧版把小概率直接称为显著性水平，并把某些不拒绝结果解释成接受。[概率统计·假设检验](../Probability%20and%20Statistics/chapters/part2/chap02.tex) · [NIST 对临界值与 p 值的说明](https://www.itl.nist.gov/div898/handbook/prc/section1/prc131.htm)
- **高阶常微分方程降阶。** 若原方程为 $y^{(n)}=f(x,y,\ldots,y^{(n-1)})$，将 $Y=(y,y',\ldots,y^{(n-1)})^{\mathsf T}$ 作为状态，则 $Y'$ 的最后一个分量仍是 $f$。旧版额外的负号会把 $y''=-\omega^2y$ 的振荡解改成指数解。[数值分析·常微分方程初值问题](../Numerical%20Analysis/chapters/chap09.tex)

## 经典力学与电动力学

- **绝热不变量的慢变条件。** 仅在某时段测得 $|\dot\omega|/\omega^2\ll1$，尚不足以断言谐振子的 $E/\omega$ 近似守恒。在无量纲时间下取 $\omega^2(t)=1+0.02\cos(2t)$，这个比值很小，调制频率却落在参量共振区。现版要求参数随慢时间平滑变化，瞬时周期轨道远离分离曲线，频率保持远离零。[经典力学·慢变化参数](../Classical%20Mechanics/chapters/part3/chap02.tex) · [Wells 与 Siklos 的绝热不变量推导](https://arxiv.org/abs/physics/0610084)
- **固有时间。** 粒子相对惯性系的速率为 $u$ 时，固有时间元为 $\mathrm d\tau=\mathrm dt\sqrt{1-u^2/c^2}=\mathrm dt/\gamma_u$。旧版把 $\gamma_u$ 放到了分子。沿类时世界线用 $c^2\mathrm d\tau^2=c^2\mathrm dt^2-\lVert\mathrm d\boldsymbol{x}\rVert^2$ 即可核对。[电动力学·相对论](../Electrodynamics/chapters/chap09.tex)
- **电偶极辐射的方向和功率。** 对真空中沿固定方向作简谐振荡的电偶极子，取峰值复振幅 $p_0$。在电偶极近似下，远场时均角功率正比于 $\sin^2\theta$，在垂直偶极轴方向最大。对立体角积分得 $P=\omega^4|p_0|^2/(12\pi\varepsilon_0 c^3)$。旧版把垂直方向写成零，且总功率多计了一次真空阻抗。[电动力学·电偶极辐射](../Electrodynamics/chapters/chap08.tex)

## 统计力学

- **转动热容的峰和声子热容的低温系数。** 刚性异核转子的热容可直接由各能级的正则权重计算，$C_{V,\mathrm r}/(Nk_{\mathrm B})=\beta^2\operatorname{Var}(\varepsilon_{\mathrm r})$。峰值为 $1.0976$，位于 $T/\theta_{\mathrm r}=0.8072$。旧图将连续两次差分的结果画在网格端点，偏移了峰位。Debye 图则在越来越长的积分区间上使用固定数目的等距点，在旧网格的第一个正温点仅算出正确热容的约 18%。用热容积分重算，低温极限恢复 $C_V/(Nk_{\mathrm B})\sim(12\pi^4/5)(T/\theta_{\mathrm D})^3$。[统计力学·分子转动](../Statistical%20Mechanics/chapters/part2/chap02.tex) · [统计力学·声子气体](../Statistical%20Mechanics/chapters/part2/chap03.tex) · [Tong《Statistical Physics》第 3 章](https://www.damtp.cam.ac.uk/user/tong/statphys/statmechhtml/S3.html)
- **自由膨胀的熵变。** 理想气体绝热地向真空膨胀时，初末平衡态温度相同。可沿连接这两态的可逆等温路径计算 $\Delta S=nR\ln(V_2/V_1)$。实际膨胀的吸热和做功均为零，中间状态通常不能用整团气体的同一组 $T,p$ 描述。[统计力学·热力学第二定律](../Statistical%20Mechanics/chapters/part1/chap01.tex)
- **巨配分函数对逆温度的偏导。** 固定体积时，$-\partial_\beta\ln\Xi$ 在固定逸度下给出 $U$，在固定化学势 $\mu$ 下给出 $U-\mu\langle N\rangle$。计算固定平均粒子数的热容时，须随温度调节逸度。[统计力学·量子气体](../Statistical%20Mechanics/chapters/part2/chap03.tex) · [统计力学·巨正则系综](../Statistical%20Mechanics/chapters/part2/chap04.tex)
- **气液共存的自由能判据。** 固定温度、外压和物质的量，均匀相的摩尔体积 $v$ 使 $f(T,v)+p_{\rm ext}v$ 取极小，其中 $f$ 是摩尔 Helmholtz 自由能。两极小值等深给出共存压强。旧版直接比较不同密度的 $G/V$，改变每摩尔能量的参考零点就会移动其极小值。[统计力学·气液相变](../Statistical%20Mechanics/chapters/part1/chap03.tex)
- **节流与退磁的温度变化。** van der Waals 气体在力学稳定的单相分支上降压节流，制冷条件为 $T<2a(1-b/v)^2/(Rb)$。普通 Curie 顺磁体在恒压下可逆绝热退磁也会降温，因为 $(\partial T/\partial B)_{S,p}=-(T/C_{p,B})(\partial m/\partial T)_{p,B}>0$。旧版在这两处写反了方向。[统计力学·节流膨胀](../Statistical%20Mechanics/chapters/part1/chap01.tex) · [统计力学·磁热效应](../Statistical%20Mechanics/chapters/part1/chap02.tex)
- **正则熵的计数。** 对 $M$ 个可区分的系统副本，$M!/\prod_s M_s!$ 计数的是全部副本的分配方式。取对数后须除以 $M$ 再取极限，才得到单个系统的熵 $-k_{\rm B}\sum_s\rho_s\ln\rho_s$。[统计力学·正则系综](../Statistical%20Mechanics/chapters/part2/chap04.tex)
- **Bose 凝聚点的热容。** 对三维均匀理想 Bose 气体，$C_V(T_c)/(Nk_{\rm B})=15\zeta(5/2)/[4\zeta(3/2)]\simeq1.926$。从高温侧接近临界点时，逸度从下方趋于 1，$\operatorname{Li}_{1/2}$ 发散。旧版将这个极限归因于 $\zeta(s)$ 在 $s=1/2$ 有极点，并在热容公式中漏掉 $Nk_{\rm B}$。[统计力学·Bose 气体](../Statistical%20Mechanics/chapters/part2/chap03.tex) · [NIST 对 ζ 函数的定义](https://dlmf.nist.gov/25.2)
- **固定物质的量与化学势。** 单组分均匀系统仅有体积功且可忽略表面效应时，内能对广延量一阶齐次，故 $U=TS-pV+\mu n$。取微分并与热力学基本关系比较，得到 $S\,\mathrm dT-V\,\mathrm dp+n\,\mathrm d\mu=0$。沿固定 $n$ 的过程可以令 $\mathrm dn=0$，但 $\mu n$ 和 $n\,\mathrm d\mu$ 仍须保留。[统计力学·Euler 方程与 Gibbs–Duhem 关系](../Statistical%20Mechanics/chapters/part1/chap02.tex)
- **Fermi 巨配分函数的幂次。** 逆温度为 $\beta=1/(k_{\mathrm B}T)$。单个独立粒子态只允许占据 $0$ 或 $1$ 个费米子，因此对两种可能求和得到 $1+\exp[-\beta(\varepsilon-\mu)]$。简并度为 $g$ 的独立能级贡献这个因子的 $g$ 次幂，旧版的负幂会算错平均占据数。[统计力学·巨正则系综](../Statistical%20Mechanics/chapters/part2/chap04.tex)

## 量子力学

- **氢原子波函数的衰减和归一化。** 旧稿把 $1s$ 总波函数的指数写成了正号。束缚态在无穷远处衰减，故 $\psi_{100}(r)=(\pi a_Z^3)^{-1/2}\exp(-r/a_Z)$。对一般径向态，体积元 $r^2\,\mathrm dr$ 使归一化积分比广义 Laguerre 多项式的正交权多一个径向因子，这时不同次数间的积分可以非零。[量子力学·氢原子的径向波函数](../Quantum%20Mechanics/chapters/chap06.tex)
- **无限深方阱的宇称。** 旧稿把平移到箱中心后的奇偶解对调了。若能级从 $n=1$ 开始编号，关于中心反射的本征值为 $(-1)^{n+1}$。基态在中心的概率密度最大，第一激发态在中心有节点。[量子力学·箱中驻波](../Quantum%20Mechanics/chapters/position_well.tex)
- **非简并微扰的能量分母。** 设 $H=H_0+\lambda V$。孤立非简并态 $n$ 的一阶态修正在第 $m\ne n$ 态上的分量为 $V_{mn}/(E_n^{(0)}-E_m^{(0)})$。旧版反写了能量差。对于离散谱的非简并基态，二阶能量修正中的每个分母都为负，可据此检查符号。简并时应先在简并子空间内处理扰动。[量子力学·定态近似方法](../Quantum%20Mechanics/chapters/chap07.tex)
- **规范变换下的动量。** 对电荷 $q$，速度对应的机械动量为 $\boldsymbol\pi=\boldsymbol p-q\boldsymbol A$。同时变换态与矢势后，机械动量的期望值保持不变，旧版误把这一性质归给了正则动量 $\boldsymbol p$。[量子力学·机械动量与正则动量](../Quantum%20Mechanics/chapters/chap09.tex)

透射概率的通量因子、寿命线宽和能谱截断另有可直接演算的例子。[量子力学·核对附录](../Quantum%20Mechanics/chapters/checks.tex)

## 核辐射物理及探测学

- **反散射峰与 Compton 边缘。** 入射光子能量为 $E_\gamma$，近似自由且静止的电子把光子反向散射时，出射光子能量为 $E'_\gamma=E_\gamma/[1+2E_\gamma/(m_ec^2)]$。若散射发生在探测器外而光子随后被全吸收，反散射峰在 $E'_\gamma$ 附近。若散射发生在探测器内，反冲电子沉积全部动能而光子逃逸，则电子能谱边缘在 $E_\gamma-E'_\gamma$。旧版混淆了这两个能量。[核辐射物理·光子与物质的相互作用](../Nuclear%20Radiation%20and%20Detection/chapters/part1/chap06.tex)
- **死时间修正。** 对稳定 Poisson 入射流，设真实计数率为 $n$、记录率为 $m$、死时间为 $\tau$。若每次入射都会重启死时间，则 $m=n\exp(-n\tau)$。若死时间内的事件被丢弃且不延长死时间，则 $m=n/(1+n\tau)$。旧版只给了前式。在 $n\tau\ll1$ 时二者的首项损失均为 $n^2\tau$，高计数率下必须区分仪器采用的响应模型。[核辐射探测·计数统计](../Nuclear%20Radiation%20and%20Detection/chapters/part2/chap01.tex)
