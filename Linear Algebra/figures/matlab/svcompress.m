% Set inputImage to the absolute path of an RGB or grayscale image before run().
% The original photograph used for the note was Original_Doge_meme.jpg.
if ~exist('inputImage', 'var')
    inputImage = 'Original_Doge_meme.jpg';
end
if ~isfile(inputImage)
    error('Set inputImage to the path of a local image before running svcompress.m.')
end
A = im2gray(imread(inputImage));

[U, S, V] = svd(double(A), "econ");

figure
t = tiledlayout(2, 3, TileSpacing="tight", Padding="tight");

for k = unique(min([1 5 10 20 40], min(size(A))))
    a = U(:, 1:k) * S(1:k, 1:k) * V(:, 1:k)';
    nexttile
    imshow(cast(a, 'like', A))
    title("$k = "+k+"$", Interpreter="latex")
end

nexttile
imshow(A)
title("$k = r = "+rank(double(A))+"$", Interpreter="latex")

set(gcf, Position=[200 200 600 400])
exportgraphics(t, "../svcompress.pdf", ContentType='vector', BackgroundColor='none')
