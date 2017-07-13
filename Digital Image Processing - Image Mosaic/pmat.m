function [ P ] = pmat( c1, c2 )
% This function takes in the correspondences between two images and then 
% calculates the perspective matrix. This function is called by 
% transform.m.

% c1 is base, c2 is being transformed

[rowSize, colSize] = size(c1);

corr = zeros(2*rowSize, 2*colSize + 4); % sizing the matrix of all correspondences

corr(1:rowSize, 1:colSize) = -1.*c2;

corr(1:rowSize, colSize + 1) = -1;

corr((rowSize + 1): (2*rowSize), (colSize + 2):(2*colSize+1)) = -1.*c2;

corr((rowSize + 1): (2*rowSize), 2*colSize + 2) = -1;

x = zeros(2*rowSize, 1);
y = zeros(2*rowSize, 1);

x(1:rowSize, 1) = c2(:, 1) .* c1(:,1);
x(rowSize + 1:2*rowSize, 1) = c2(:,1) .* c1(:,2);

y(1:rowSize, 1) = c2(:,2) .* c1(:,1);
y(rowSize + 1:2*rowSize, 1) = c2(:,2) .* c1(:,2);

corr(:, 2*colSize + 3) = x;
corr(:, 2*colSize + 4) = y;

b = [c1(:,1); c1(:,2)];
b = -b;

tP = pinv(corr)*b;

tP = [tP;1];

P = reshape(tP, [3,3]);
P = P';

end

