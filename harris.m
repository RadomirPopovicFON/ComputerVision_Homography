function [px, py] = harris(img, sigma, thresh)

    % Identifying corners via Harris detector

    sigma_factor = 1.6;
    alpha = 0.06;
    
    % Calculate derivatives (including Gaussian smoothing using sigma)
    [imgDx, imgDy] = gaussderiv(img, sigma);
	
    % Calculate components of C matrix
    % incl. applying Gaussian window for each point
    imgDx2 = gaussianfilter(sigma^2 * imgDx.^2, sigma_factor*sigma);
    imgDy2 = gaussianfilter(sigma^2  * imgDy.^2, sigma_factor*sigma);
    imgDxy = gaussianfilter(sigma^2 * imgDx.*imgDy, sigma_factor*sigma);
    
    % Calculate determinant and trace for evert point
    detC = imgDx2.*imgDy2 - imgDxy.^2;
    traceC = imgDx2 + imgDy2;
    
    % Calculate Herris score
    R = detC - alpha * traceC.^2;
    
    R = nonmaxsup2d(R);
    [py, px] = find(R > thresh);

end
