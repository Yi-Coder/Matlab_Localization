function [ output_args ] = MultiDays( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 file1 = 'yi/2015-12-02_08-15-06.csv';
%  file2 = 'yi/2015-12-01_08-15-10.csv'; 
 file3 = 'yi/2015-12-03_08-15-15.csv';
 file4 = 'yi/2015-12-04_08-15-58.csv'; 
 file5 = 'yi/2015-12-07_08-15-07.csv'; 
%  file6 = 'yi/2015-12-09_08-15-04.csv'; 
 
%  d2 = route_segment(file1,file2);
 d3 = route_segment(file1,file3);
 d4 = route_segment(file1,file4);
 d5 = route_segment(file1,file5);
%  d6 = route_segment(file1,file6);


d1 = d3+d4+d5;
 
 for i =1:length(d1);
  [~,ind]=  min(d1(i,:));
   index = [i,ind];
   disp(index);
end

