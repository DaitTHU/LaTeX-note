clear
close all

n = 10;
p1 = 0.2;
p2 = 0.3;
p3 = 1 - (p1 + p2);

x1 = (0 : n)';
x2 = 0 : n;
x3 = n - (x1 + x2);
x3(x3 < 0) = inf;
f = factorial(n)./ (factorial(x1).* factorial(x2).* factorial(x3)).* p1.^x1.* p2.^x2.* p3.^x3;
f(isinf(x3)) = nan;

b = bar3(x1, f, 1);
for ii = 1 : length(b)
    b(ii).CData = b(ii).ZData;
    % b(ii).FaceColor = 'interp';
    b(ii).XData = b(ii).XData - 1;
    b(ii).ZData(b(ii).XData + b(ii).YData > n + 1) = NaN;
end

xlabel("$k_1$", Interpreter="latex")
ylabel("$k_2$", Interpreter="latex")
zlabel("${\rm P}(X_1=k_1,X_2=k_2,X_3=n-k_1-k_2)$", Interpreter="latex")

xlim([-0.5 n+0.5])
ylim([-0.5 n+0.5])
xticks(x1)

cb = colorbar;

view(45, 30)

set(gcf, Position=[200 200 600 500])

exportgraphics(gca, "../pdf_bin3.pdf", ContentType="vector", BackgroundColor="none")
