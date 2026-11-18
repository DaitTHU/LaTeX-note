figure
m = 0 : .0001 : 1;
% MATLAB takes the parameter m. The note defines K and E using the modulus k.
[K, E] = ellipke(m);

lincomp(plot(m, K, m, E, LineWidth=2), ylim=[0 3])

grid on
xlabel('$m=k^2$', Interpreter='latex')
ylim([0 3])
text(0, pi/2, "$\pi/2~$", Interpreter="latex", HorizontalAlignment="right")
yticks(0:3)

pad_legend(legend(["$K(k)$", "$E(k)$"], Interpreter='latex', Location='southeast'));

set(gcf, Position=[200 200 700 400])

exportgraphics(gca, '../ellipseKE.pdf', ContentType='vector', BackgroundColor='none')
