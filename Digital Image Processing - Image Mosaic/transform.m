function [ pArr ] = transform( corrCell, tree, numCorr )
% This function creates the perspective transformations using the tree cell 
% to know which images should be transformed and which images should not 
% be. The correspondence cell is need to calculate the 3x3 matrix. The 
% output is a cell that contains the p matrix for every correspondence. 
% Mosaic.m calls this function.

pArr = cell(1,numCorr,2);

row = 1;
col = 1;
j = 1;

i = 1;

while(i <= numCorr)
   
    baseImg = tree{row,col};
   
    if (isempty(tree{row + j, col}))
        row = 1;
        j = 1;
        col = col + 1;
        continue;
    end

    child = tree{row + j, col};
    
    for k = 1:2:2*numCorr
        
        if (corrCell{1, k, 1} == [baseImg; child])
            baseCorr = corrCell{1,k,3};
            childCorr = corrCell{1, k+1, 3};
        elseif (corrCell{1, k + 1, 1} == [baseImg; child])
            baseCorr = corrCell{1,k+1,3};
            childCorr = corrCell{1,k,3};
        end    
    end
    
    pArr{1, i, 1} = [baseImg, child];
    pArr{1, i, 2} = pmat(baseCorr, childCorr);
    
    j = j + 1;
    i = i + 1;
    
end


end

