function [ output_args ] = roadSegmentDistinguish( input_args )

TestData = dir ('./oneRoadLocalization/yi/*.csv');
TrainingData = dir('./oneRoadLocalization/yi/*.csv');

for i = 1: length(TestData)
     for j =i+1: length(TrainingData)
        temp1 = strcat('./oneRoadLocalization/yi/', TestData(i).name); 
        temp2 = strcat('./oneRoadLocalization/yi/', TrainingData(j).name);   
        route_segment(temp1, temp2);
     end     
end
end

