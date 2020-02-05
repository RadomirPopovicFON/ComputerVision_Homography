function [Idx, Dist] = findnn(D1, D2)
	% D1 D2: one histogram per line
	% Idx should be a  vector,​where Idx(a) contains the index of the 
	% descriptor in D2 that matches the descriptor with index a in D1.
	% Dist should be a column vector that contains the distance between 
	% those two descriptors.
	dists = zeros(size(D1, 1), size(D2, 1));
	for i = 1:size(D1, 1)
		for j = 1:size(D2, 1)
			dists(i, j) = norm(D1(i, :) - D2(j, :), 2);
		end
	end
	 	 		
	Dist = zeros(size(D1, 1), 1);
	Idx = zeros(size(D1, 1), 1);
	for i = 1:size(D1, 1)
		[Dist(i), Idx(i)] = min(dists(i, :));
	end
end
