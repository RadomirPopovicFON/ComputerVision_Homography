function f = displaymatches(img1, px1, py1, img2, px2, py2, Idx, Dist, N)

	% sort the matches according to their scores
	[SDist, SIdx] = sort(Dist, 'ascend');

	% visualize the N best matches
	h1 = subplot(1, 2, 1);
	drawpoints(img1, px1, py1, 'y');
	h2 = subplot(1, 2, 2);
	drawpoints(img2, px2, py2, 'y');

	for i=1:N
		if numel(SDist) == 0
			continue;
		end
		disp(['Match ', num2str(i), ': dist=', num2str(SDist(i))]);

		subplot(h1);
		hold on;
		plot(px1(SIdx(i)), py1(SIdx(i)), 'ro', 'Linewidth', 2);
		ht = text(px1(SIdx(i)) + 10, py1(SIdx(i)) + 20, num2str(i));
		set(ht, 'Color', 'r');
		set(ht, 'FontWeight', 'bold');
		set(ht, 'FontSize', 12);

		subplot(h2);
		hold on;
		plot(px2(Idx(SIdx(i))), py2(Idx(SIdx(i))), 'ro', 'Linewidth', 2);
		ht = text(px2(Idx(SIdx(i))) + 10, py2(Idx(SIdx(i))) + 20, num2str(i));
		set(ht, 'Color', 'r');
		set(ht, 'FontWeight', 'bold');
		set(ht, 'FontSize', 12);

		drawnow;
	end

end
