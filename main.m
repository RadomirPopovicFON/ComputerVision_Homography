%% -------------------------------------------------------------------------
fprintf('\n----- Part a: Harris detector -----\n');

affine_trans = [1 0.25 0; 0.25 1 0; 0 0 1];
img1 = rgb2gray(imread('black_square_5.jpg'));
img2 = imwarp(img1, affine2d(affine_trans));

subplot(2,1,1);
imshow(img1, []);
subplot(2,1,2);
imshow(img2, []);

sigma = 1.6;
threshold_harris = 25;

[px1, py1] = harris(img1, sigma, threshold_harris);
fprintf('img1: found %d interest points\n', size(px1, 1));
[px2, py2] = harris(img2, sigma, threshold_harris);
fprintf('img2: found %d interest points\n', size(px2, 1));

%% -------------------------------------------------------------------------
fprintf('\n----- Part b: Generating histogram descriptor -----\n');

descriptor_no_bins = 16; 
window_size_descriptor = 10;
D1 = descriptors_maglap(img1, px1, py1, window_size_descriptor, sigma, descriptor_no_bins);
D2 = descriptors_maglap(img2, px2, py2, window_size_descriptor, sigma, descriptor_no_bins);

%% -------------------------------------------------------------------------
fprintf('\n----- Part c: Matching based on descriptors -----\n');
[Idx, Dist] = findnn(D1, D2);

number_of_matches = min(20, size(Dist, 1));
displaymatches(img1, px1, py1, img2, px2, py2, Idx, Dist, number_of_matches);

%% -------------------------------------------------------------------------
fprintf('\n----- Part d: Computing histogram -----\n');

[~, SIdx] = sort(Dist, 'ascend');

x1 = px1(SIdx(1:number_of_matches));
y1 = py1(SIdx(1:number_of_matches));
x2 = px2(Idx(SIdx(1:number_of_matches)));
y2 = py2(Idx(SIdx(1:number_of_matches)));
H = estimate_homography(x1, y1, x2, y2);

disp('Computed homography:');
disp(H);