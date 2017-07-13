function [ out ] = treeFunc( cp, base, numImgs )
% The inputs to this function are the matrix displaying the correspondences
% between images, the number of the base image, and the number of images. 
% A cell is created with this information. The cell is the output. The cell 
% contains all of the connections of images, with the base being the first 
% input. The cell is basically a flattened tree. Mosaic.m calls this
% function

% output is a cell that contains what images touch one another. The cell is
% ordered in a fashion that displays what the images should transform too.

tree = cell(numImgs, numImgs);

tree{1,1} = base;
row = 2;
cnt = 0;

% Find which images touch the base image
for i = 1:numImgs
   
    if (cp(base+1, i) || cp(i, base+1))
       tree{row, 1} = i - 1; 
       row = row + 1;
       cp(base+1, i) = 0;
       cp(i, base+1) = 0;
       cnt = cnt + 1;
    end
    
end

i =2;

% place each image that touches the base image in its own column
while(~isempty(tree{i, 1}))
   
    tree{1, i} = tree{i, 1};
    i = i +1;
    
    if(i == numImgs)
        break;
    end
    
end

% beginning index for next image connections
row = 1;
col = 2;

while(~min(min(cp < 1)))
    
    loc = tree{row, col};
    
    for i = 1:numImgs
        
        if (cp(loc + 1, i) || cp(i, loc+1))
            row = row + 1;
            tree{row, col} = i - 1;
            cp(loc + 1, i) = 0;
            cp(i, loc+1) = 0;
        end
    end
    
    row = 2;
    i = cnt;
    while(~isempty(tree{row, col}))
        tree{1, col + i} = tree{row,col};
        row = row + 1;
        i = i + 1;
    end
    cnt = i;
    col = col + 1;
    row = 1;

end

out = tree;

end

