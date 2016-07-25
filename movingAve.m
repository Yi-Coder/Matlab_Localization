function [ output_args ] = movingAve( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% file1 = './yi/2015-12-02_08-15-06.csv';
% file2 = './yi/2015-12-04_08-15-58.csv';
% temp1 = cvs2mat(file1); 
% temp2 = cvs2mat(file2); 

windowSize = 20;
b = (1/windowSize)*ones(1,windowSize);
a = 1;

y1 = filter(b,a,temp1(:,4));
y2 = filter(b,a,temp2(:,4));

% figure(1)
% plot(y1);
% figure(2)
% plot(y2);
% figure(3)
% plot(temp1(:,4));
% figure(4)
% plot(temp2(:,4));


end

