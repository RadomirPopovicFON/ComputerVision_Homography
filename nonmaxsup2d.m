function imgResult = nonmaxsup2d(imgHough)
	imgResult = zeros(size(imgHough));

	% iterate inner image
	for y = 2:size(imgHough, 1)-1
		for x = 2:size(imgHough, 2)-1

			% check these neighbours
			offx = [1 1 0 -1 -1 -1  0  1];
			offy = [0 1 1  1  0 -1 -1 -1];
 	 	  
			val = imgHough(y, x);

			is_max = true;
			for i=1:8
				if val < imgHough(y+offy(i), x+offx(i))
					is_max = false;
					break;
				end
			end

			if is_max
				imgResult(y, x) = val;
			end
		end
	end
 	 	  
end
