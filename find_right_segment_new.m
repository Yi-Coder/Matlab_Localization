function [ endpoint, distance,segment_number] = find_right_segment_new(start_point,observation, road)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
temp1 = load('./Lin/road1.mat');
temp2 = load('./Lin/road2.mat');
temp3 = load('./Lin/road3.mat');
temp4 = load('./Lin/road4.mat');
temp5 = load('./Lin/road5.mat');
temp6 = load('./Lin/road6.mat');
temp7 = load('./Lin/road7.mat');
temp8 = load('./Lin/road8.mat');
temp9 = load('./Lin/road9.mat');
temp10 = load('./Lin/road10.mat');
temp11 = load('./Lin/road11.mat');
temp12 = load('./Lin/road12.mat');

road{1} = temp1.road1;
road{2} = temp2.road2;
road{3} = temp3.road3;
road{4} = temp4.road4;
road{5} = temp5.road5;
road{6} = temp6.road6;
road{7} = temp7.road7;
road{8} = temp8.road8;
road{9} = temp9.road9;
road{10} = temp10.road10;
road{11} = temp11.road11;
road{12} = temp12.road12;


temp11 = load('./Liang/road1.mat');
temp22 = load('./Liang/road2.mat');
temp33 = load('./Liang/road3.mat');
temp44 = load('./Liang/road4.mat');
temp55 = load('./Liang/road5.mat');
temp66 = load('./Liang/road6.mat');
temp77 = load('./Liang/road7.mat');
temp88 = load('./Liang/road8.mat');
temp99 = load('./Liang/road9.mat');
temp1010 = load('./Liang/road10.mat');
temp1111 = load('./Liang/road11.mat');
temp1212 = load('./Liang/road12.mat');

troad{1} = temp11.road1;
troad{2} = temp22.road2;
troad{3} = temp33.road3;
troad{4} = temp44.road4;
troad{5} = temp55.road5;
troad{6} = temp66.road6;
troad{7} = temp77.road7;
troad{8} = temp88.road8;
troad{9} = temp99.road9;
troad{10} = temp1010.road10;
troad{11} = temp1111.road11;
troad{12} = temp1212.road12;

observation = vertcat(troad{2},troad{3},troad{4},troad{12});
% disp(length(road{1}));
% disp(length(road{4}));
% disp(length(road{9}));
% disp(length(road{12}));
lob = length(observation);
% disp(length(lob));

start_point = 1;
for i = 1:12
%   disp(lob - start_point+1);
   if(length(road{i}) <= (lob - start_point+1))
      [d(i),index(i)] = sub2RouteDistance(road{i},observation(1:lob,:));
%       disp(index(i));
   else
        d(i) = 1000;
        index(i) = -1;
   end
end
    disp(d);
    [m mi] = sort(d);
    disp(mi);
 
     d = (d - min(d))/(max(d)-min(d));
     d = 1-d;
     disp(d);
     [v,ind] = max(d);
     disp('..............')

    distance = d;
    endpoint = start_point+ index(ind)-1;
%     disp(ind);
%     disp(index(ind));
%     disp(endpoint);  
    segment_number = ind;
end

