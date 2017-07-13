function [ out ] = num( line )
% This function takes in a line that contains numbers and converts the  
% string of numbers into a vector of those numbers. ReadFile.m calls this 
% function

tsplit = strsplit(line);
tsplit = char(tsplit);
out = str2num(tsplit);

end

