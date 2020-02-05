function histogram = histdxdy(img, sigma, bins)
	% this function assumes that the image is double and in the range 0..255

	% calculate the gaussian derivatives
	[imgDx, imgDy] = gaussderiv(img, sigma);

	% define a 2D histogram with "bins^2" entries
	histogram = zeros(bins, bins); % dy and dx

	% execute the loop for each pixel in the image
	for i = 1:size(img, 1)
		for j = 1:size(img, 2)
			% increment a histogram bin which corresponds to
			% the value of pixel i,j; h(dx,dy)
			x = round( (imgDx(i, j) + 256)/511 * bins ) + 1;
			y = round( (imgDy(i, j) + 256)/511 * bins ) + 1;
			histogram(x, y) = histogram(x,y) + 1;
		end
	end

	% normalize the histogram such that its integral (sum) is equal 1
	histogram = histogram / sum(histogram(:));

	% reshape the histogram to obtain a 1D row vector of size 1 x bins^2
	histogram = reshape(histogram, 1, bins^2);
end
