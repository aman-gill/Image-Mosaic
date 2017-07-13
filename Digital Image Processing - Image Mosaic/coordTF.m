function [ coordinates ] = coordTF( direction, imgs, numCorr, pArr )
% This function creates a cell that contains all of the new coordinates for 
% the images that were perspective transformed back to the base image. This
% function is called by mosaic.m.

dr = 1;
dc = 1;

[drSize, dcSize] = size(direction);

coordinates = cell(1, numCorr, 3); % this cell contains all of the transformed coordinates
% transformed image on cell(:,:, 1), x on cell(:,:, 2), y on cell(:,:,3)

pos = 1;

while (~isempty(direction{dr, dc}))
    while (~isempty(direction{dr, dc}))
        arr = direction{dr, dc};
        i = length(arr);
        child = imread(imgs{arr(1) + 1});  % retrieved for coordinates of image being transformed
        [row,col,dim] = size(child);    % getting starting coordinates
        
        coordinates{1, pos, 1} = arr(1);
        newX = zeros(row, col);
        newY = zeros(row, col);
        
        for q = 1:row
            newX(q,:) = 1:col;
        end
        for q = 1:col
            newY(:,q) = 1:row;
        end
        
        % this loop makes all of the transformations from the current image
        % back to the base image.
        for j = 1:i-1  
            % the loop below grabs the p array for the transformation
            for k = 1:numCorr
                if([arr(j+1), arr(j)] == pArr{1,k,1})
                    p = pArr{1,k,2};
                    break;
                end
            end
            
            for r = 1:row
                for c = 1:col
                    
                    newCoor = p*[newX(r,c);newY(r,c);1];
                    
                    newCoor = newCoor./newCoor(3);
                    
                    newX(r, c) = newCoor(1);  % new x coordinate
                    newY(r, c) = newCoor(2);  % new y coordinate
                    
                end
            end
        end 
        
        coordinates{1, pos, 2} = newX;
        coordinates{1, pos, 3} = newY;
        
        dr = dr + 1;
        pos = pos + 1;
        if (dr > drSize)
            pos = pos - 1;
            break;
        end        
    end
    
    dr = 1;
    dc = dc + 1;
    
    if(dc > dcSize)
        break;
    end
    
end


end

