function [ outputFile ] = mosaic( parameterFile )
%The function 'mosaic' takes in a parameter file that states the
%correspondences between images. The parameter file is specific to the
%images that are used to create a mosaic.
%   'mosaic' is the main function that calls other functions to complete
%   the process of creating a mosaic.

disp('Reading File')
[corrCell, info, numCorr] = ReadFile(parameterFile);

corrExists = info{1,1};
imgs = info{1,2};
base = info{1,3};
outName = info{1,4};
    
numImgs = max(size(imgs)); % returns the number of images

cp = double(corrExists);

disp('Making tree')
tree = treeFunc(cp, base, numImgs);

disp('Creating P arrays')
pArr = transform( corrCell, tree, numCorr );

% Direction is a cell that contains the direction of transforms from each
% image to the base image
disp('Creating Connected Image List')
direction = listFunc(tree);

disp('Altering image coordinates to base perspective')
coordinates = coordTF(direction, imgs, numCorr, pArr);

disp('Stitching images')
outputFile = canvas(imgs, base, coordinates, numImgs, numCorr);

imwrite(outputFile, outName);
disp('Finished')
end

