function [ corrCell, infoCell, numCorr ] = ReadFile( parameterFile )
% ReadFile takes all of the information from the parameter file and outputs
% the information in variables. The parameter file must present the data in
% the correct order for this function to work.

% Open the file and give read permissions
fid = fopen(parameterFile, 'r');

line = nextLine(fid);

% Dim contains the size of the correspondence matrix
dim = num(line);

corrExists = zeros(dim(1), dim(2)); 

% This for loop will get the array that shows whether correspondences exist
% line by line. The loop runs based on the number of images give by the
% first line of the parameter file.
for i = 1:dim(1)
    
    line = nextLine(fid);
    val = num(line);
    corrExists(i, :) = val;

end

% This for loop grabs all of the image names and puts them in a cell.
images = cell(1, dim(1));

for i = 1:dim(1)
    
    line = nextLine(fid);    
    images{1, i} = line;
    
end

% This is the total number of correspondence arrays needed
numCorr = sum(sum(corrExists));

% Correspondence Cell that contains all of the information of which images
% correspond to others, how many pixels, and the pixel number
corrCell = cell(1, numCorr, 3);

i = 1; % keeps track of the current correspondence 
while(i < ((2*numCorr) + 1))
    
    line = nextLine(fid);
    val = num(line);
    
    corrCell{1, i, 1} = val;
    
    line = nextLine(fid);
    val = num(line);
    
    corrCell{1, i, 2} = val;
    
    arr = zeros(val(1), val(2));
    
    for j = 1:val(1)
       
       line = nextLine(fid);
       index = num(line);
       
       arr(j, :) = index;
       
    end
    
    corrCell{1, i, 3} = arr;
    
    i = i + 1;  
    
end

line = nextLine(fid);
base = num(line);

outName = nextLine(fid);

infoCell = cell(1,4);

infoCell{1,1} = corrExists;
infoCell{1,2} = images;
infoCell{1,3} = base;
infoCell{1,4} = outName;


end

