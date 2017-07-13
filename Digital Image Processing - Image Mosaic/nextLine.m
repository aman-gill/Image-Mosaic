function [ line ] = nextLine( fid )
% This functions takes in the open file and outputs the next line that is 
% not a comment. ReadFile.m calls this function

while (~feof(fid))
    
    line = fgetl(fid);
    
   if (line(1,1) == '/' && line(1,2) == '/')
        continue;
    else
        break;
    end
    
end
end

