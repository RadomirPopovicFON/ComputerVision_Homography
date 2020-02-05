function H = estimate_homography(px1, py1, px2, py2, fix_h33)

% [px1, mu_px1, sig_px1] = standardize(px1);
% [py1, mu_py1, sig_py1] = standardize(py1);
% [px2, mu_px2, sig_px2] = standardize(px2);
% [py2, mu_py2, sig_py2] = standardize(py2);


if nargin < 5
    fix_h33 = true;
end

N = size(px1, 1);

val = add_zeros(px1);
% First 3 columns
A1_3 = cat(2, add_zeros(px1), add_zeros(py1), add_zeros(ones(N,1)));

% columns 4 to 6 (add zeros at top and remove last row of zeros from A1)
A4_6 = cat(1, zeros(1, 3), A1_3(1:end-1,:));

% Calculate products needed for columns 7 and 8
x1x2 = px1 .* px2;
y1y2 = py1 .* py2;
x1y2 = px1 .* py2;
y1x2 = px2 .* py1;

% Calculated columns by merging vectors
A7 = -1 * merge_vectors(x1x2, x1y2);
A8 = -1 * merge_vectors(y1x2, y1y2);
A9 = -1 * merge_vectors(px2, py2);

% Concatenate all columns
A = [A1_3, A4_6, A7, A8, A9];

[U, D, V] = svd(A, 'econ');

h = V(:, end);

test = h(end);

if fix_h33 && abs(h(end)) > 0
    h = h ./ h(end);
end

H = reshape(h(:), 3, 3)';

end

function res = merge_vectors(x, y)
    res = cat(1, x', y');
    res = res(:);
end

function res = add_zeros(x)
    [N, ~] = size(x);
    res = merge_vectors(x, zeros(N, 1));    
end

