function [ output_args ] = cvs2mat( filename )
% temp = readtable('yi/2015-12-02_08-15-06.csv');
 temp = readtable(filename);
index = [6,7,22,23,24,26,27,28];%which column to use
t = temp(:,index);
%disp(t(1,1));
c = table2cell(t);
d = cell2mat(c);
d (isnan(d))= 0;
[m,n] =size(d);

for i = 1:m
    for j = 1: n 
         if(d(i,j)==0)
               d(i,j)=d(i-1,j);
         end
    end
end

% disp(d);
% [v,index] = find(isnan(d));
% disp(v);
output_args = d;
end

