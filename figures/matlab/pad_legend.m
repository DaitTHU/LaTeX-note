function lgd = pad_legend(lgd)
% Leave space between the longest label and the vector PDF legend frame.
if strcmp(lgd.Interpreter, 'latex')
    padding = "\hspace{0.6em}";
else
    padding = string(char([160 160]));  % MATLAB trims ordinary trailing spaces.
end
lgd.String = string(lgd.String) + padding;
end
