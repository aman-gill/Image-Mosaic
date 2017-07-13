function [ direction ] = listFunc( tree )
% The input is the tree cell that was created by treeFunc.m. The output is 
% a cell of lists that contain the direction of the perspective 
% transformations. I.e. transform image 3 to image 0 perspective, then to 
% image 1’s perspective. This function is called by mosaic.m.

% Direction is a cell that contains the direction of transforms from each
% image to the base image
direction = cell(1, length(tree(1,:)) - 1);

% start from the first image touching the base
row = 1;
col = 1;
rowInc = 1;
[maxR, maxC] = size(tree);

while(col <= length(tree(1,:)) - 1)
    
    while(~isempty(tree{row + rowInc, col}))
    
        parentImg = tree{row, col};
        childImg = tree{row + rowInc, col};
        
        direction{rowInc, col} = [childImg, parentImg];
        
        colStart = col;
        
        while (colStart > 1)
            r = 2;
            while(~isempty(tree{r,colStart - 1}))
                
                if(parentImg == tree{r,colStart - 1})
                    direction{rowInc,col} = [direction{rowInc,col}, tree{1, colStart - 1}];
                    break;
                else
                    r = r + 1;
                end
            end
            colStart = colStart - 1;
            
        end
        
        rowInc = rowInc + 1;
        if(row+rowInc > maxR)
            break;
        end
    end
    
    rowInc = 1;
    col = col + 1; 
    if(col > maxC)
        break;
    end
end

end

