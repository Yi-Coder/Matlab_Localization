function [ output_args ] = subSequenceDistinguish( input_args )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
file1 = './roadDistinguish/yi/2015-12-02_08-15-06.csv';
file2 = './roadDistinguish/yi/2015-12-04_08-15-58.csv'; 
temp1 = cvs2mat(file1); 
temp2 = cvs2mat(file2); 

location1 = temp1(:,1:2);
location2 = temp2(:,1:2);

windowSize = 5;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
%  
raw_signal1_ax= filter(b,a,temp1(:,3));
% raw_signal1_ay= filter(b,a,temp1(:,4)); 
% raw_signal1_az= filter(b,a,temp1(:,5));
% 
raw_signal2_ax= filter(b,a,temp2(:,3));
% raw_signal2_ay= filter(b,a,temp2(:,4));
% raw_signal2_az= filter(b,a,temp2(:,5));
% 
raw_signal1_gx= filter(b,a,temp1(:,6));
raw_signal1_gy= filter(b,a,temp1(:,7));
raw_signal1_gz= filter(b,a,temp1(:,8));
% 
raw_signal2_gx= filter(b,a,temp2(:,6));
raw_signal2_gy= filter(b,a,temp2(:,7));
raw_signal2_gz= filter(b,a,temp2(:,8));

route_point=[33.852092, -84.335437;
33.844321, -84.327373;
33.839688, -84.320390;
33.832716, -84.335979;
33.830798, -84.339101;
33.825395, -84.348535;
33.823800, -84.352655;
33.819826, -84.361501;
33.803170, -84.385586;
% 33.800365, -84.390320;
% 33.797539, -84.393471;
% 33.789095, -84.391572;
% 33.774568, -84.390507;
% 33.769212, -84.390512;
% 33.766456, -84.387615;
33.765439, -84.385888;
33.755573, -84.387001;];

k1 = dsearchn(location1, route_point);
k2 = dsearchn(location2, route_point);

segments = length(route_point)-1;

for i=1:segments;
     signal_1_ax = raw_signal1_ax(k1(i):k1(i+1));
%      signal_1_ay = raw_signal1_ay(k1(i):k1(i+1));
%      signal_1_az = raw_signal1_az(k1(i):k1(i+1));
     
     signal_1_gx = raw_signal1_gx(k1(i):k1(i+1));
     signal_1_gy = raw_signal1_gy(k1(i):k1(i+1));
     signal_1_gz = raw_signal1_gz(k1(i):k1(i+1));

        [Dist1,d1,index1] = subdtw(signal_1_ax,raw_signal2_ax,2400);
        [Dist2,d2,index2] = subdtw(signal_1_gx,raw_signal2_gx,2400);
        [Dist3,d3,index3] = subdtw(signal_1_gy,raw_signal2_gy,2400);
        [Dist4,d4,index4] = subdtw(signal_1_gz,raw_signal2_gz,2400);
       
       Dist = Dist1+Dist2+Dist3+Dist4;
       [d,index] = min(Dist(1,:));
       disp(location1(k1(i+1),:))
       disp(location2(k2(i+1),:))
       disp(location2(index,:));
       disp('-----------------------');
%        [d2,index2] = subdtw(signal_1_ay,raw_signal2_ay,2400);
%        [d3,index3] = subdtw(signal_1_az,raw_signal2_az,2400);
%        [d4,index4] = subdtw(signal_1_gx,raw_signal2_gx,2400);
%        [d5,index5] = subdtw(signal_1_gy,raw_signal2_gy,2400);
%        [d6,index6] = subdtw(signal_1_gz,raw_signal2_gz,2400);

end
end

