function [ canvas ] = canvas( imgs, base, coordinates, numImgs, numCorr )
% The inputs are all generated previously and are used by canvas.m to 
% create the final image. The output is a matrix that was converted to an 
% image by using mat2gray(). The size of the image outputted is the 
% smallest possible size for the stitched images.

baseImg = imread(imgs{base+1});

[br, bc, dim] = size(baseImg);

baseX = zeros(br,bc);
baseY = zeros(br,bc);

for q = 1:br
    baseX(q,:) = 1:bc;
end
for q = 1:bc
    baseY(:,q) = 1:br;
end

minX = min(min(baseX));
minY = min(min(baseY));

% Find min coordinate of the new image for canvas
for i = 1:numImgs - 1
    
    imgXMin = min(min(coordinates{1,i,2}));
    imgYMin = min(min(coordinates{1,i,3}));
    
    if (imgXMin < minX)
        minX = imgXMin;
    end
    
    if (imgYMin < minY)
        minY = imgYMin;
    end
    
end

minX = round(abs(minX));
minY = round(abs(minY));

baseX = baseX + minX;
baseY = baseY + minY;

for i = 1:numImgs - 1
    
    coordinates{1, i, 2} = round(coordinates{1, i, 2} + minX);
    coordinates{1, i, 3} = round(coordinates{1, i, 3} + minY);

end

maxX = max(max(baseX));
maxY = max(max(baseY));

for i = 1:numImgs - 1
    
    imgXMax = max(max(coordinates{1,i,2}));
    imgYMax = max(max(coordinates{1,i,3}));
    
    if (imgXMax > maxX)
        maxX = imgXMax;
    end
    
    if (imgYMax > maxY)
        maxY = imgYMax;
    end
    
end

canvas = zeros(maxY, maxX, dim);

% Put base image on canvas
for i = 1:br
    for j = 1:bc
               
        x = baseX(i,j);
        y = baseY(i,j);
        
        canvas(y, x, 1) = baseImg(i, j, 1);
        canvas(y, x, 2) = baseImg(i, j, 2);
        canvas(y, x, 3) = baseImg(i, j, 3);

    end
end

for i = 1:numCorr
    
    img = imread(imgs{coordinates{1,i,1} + 1});
    [row, col, dim] = size(img);
    
    imgx = coordinates{1,i,2};
    imgy = coordinates{1,i,3};
    
    for j = 1:row
        for k = 1:col
            
            x = imgx(j,k);
            y = imgy(j,k);
            
            if( x == 0)
                x = 1;
            end
            
            if( y == 0)
                y = 1;
            end
            
            a = k+2;
            b = x+2;
            c = j+2;
            d = y+2;
            
            if(a > col)
                a = col;
                diff = a - k;
                b = x + diff;
            end
            
            if (b>maxX)
                b = maxX;
                diff = b - x;
                a = k + diff;
            end
            
            if (c>row)
                c = row;
                diff = c - j;
                d = y + diff;
            end
            
            if (d>maxY)
                d = maxY;
                diff = d - y;
                c = j + diff;
            end
            
            
            canvas(y:d, x:b, 1) = img(j:c, k:a, 1);
            canvas(y:d, x:b, 2) = img(j:c, k:a, 2);
            canvas(y:d, x:b, 3) = img(j:c, k:a, 3);
        end
    end
end

canvas = mat2gray(canvas);


end

