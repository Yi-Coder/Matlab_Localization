function [ output_args ] = roadDistinguish( input_args )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% folder = 
TestData = dir ('.\roadDistinguish\TestData\*.mat');
TrainingData = dir('.\roadDistinguish\TrainingData\*.mat');

Distance = zeros(22,1);
count = 0;
for i = 1: length(TestData)
     for j =1: length(TrainingData)
  temp1 = strcat('.\roadDistinguish\TestData\', TestData(i).name); 
  temp2 = strcat('.\roadDistinguish\TrainingData\', TrainingData(j).name); 
  
  testD1 = load(temp1);
  testD2 = load(temp2);
  f1=fieldnames(testD1);
  f2=fieldnames(testD2);
  
   Distance(j)= route_distance(testD1.(f1{1}), testD2.(f2{1}));
     end     
     [v,ind] = min(Distance);
     
     if(strcmp(TrainingData(ind).name,TestData(i).name))
         count = count + 1;
         disp(TestData(i).name);
         disp(TrainingData(ind).name)
     end
end
disp(count);

end

