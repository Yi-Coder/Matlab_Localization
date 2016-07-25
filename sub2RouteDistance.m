function [ d, index ] = sub2RouteDistance( temp1, temp2 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% file1 = './yi/2016-02-10_08-27-18.csv';
% file2 = './yi/2016-02-11_08-16-44.csv'; 
% temp1 = cvs2mat(file1); 
% temp2 = cvs2mat(file2); 

% temp1 = load('road1.mat');
% temp2 = load('road2.mat');
% temp3 = load('road3.mat');
% temp4 = load('road4.mat');
% temp5 = load('road5.mat');
% temp6 = load('road6.mat');
% temp7 = load('road7.mat');
% temp8 = load('road8.mat');
% temp9 = load('road9.mat');
% temp10 = load('road10.mat');
% temp11 = load('road11.mat');
% temp12 = load('road12.mat');
% 
% road{1} = temp1.road1;
% road{2} = temp2.road2;
% road{3} = temp3.road3;
% road{4} = temp4.road4;
% road{5} = temp5.road5;
% road{6} = temp6.road6;
% road{7} = temp7.road7;
% road{8} = temp8.road8;
% road{9} = temp9.road9;
% road{10} = temp10.road10;
% road{11} = temp11.road11;
% road{12} = temp12.road12;


%  location1 = temp1(:,1:2);
%  location2 = temp2(:,1:2);
% temp1 = road{4};
% temp2 = road{12};


windowSize = 5;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
%  
raw_signal1_ax= filter(b,a,temp1(:,3));
raw_signal1_ay= filter(b,a,temp1(:,4));
raw_signal1_az= filter(b,a,temp1(:,5));
raw_signal1_gx= filter(b,a,temp1(:,6));
raw_signal1_gy= filter(b,a,temp1(:,7));
raw_signal1_gz= filter(b,a,temp1(:,8));
%
raw_signal2_ax= filter(b,a,temp2(:,3));
raw_signal2_ay= filter(b,a,temp2(:,4));
raw_signal2_az= filter(b,a,temp2(:,5));
raw_signal2_gx= filter(b,a,temp2(:,6));
raw_signal2_gy= filter(b,a,temp2(:,7));
raw_signal2_gz= filter(b,a,temp2(:,8));


     signal_1_ax = raw_signal1_ax;
     signal_1_ay = raw_signal1_ay;    
     signal_1_az = raw_signal1_az;    
     
     signal_1_gx = raw_signal1_gx;
     signal_1_gy = raw_signal1_gy;
     signal_1_gz = raw_signal1_gz;

        [Dist1,d1,index1] = subdtw(signal_1_ax,raw_signal2_ax,2400);
%         [Dist2,d2,index2] = subdtw(signal_1_ay,raw_signal2_ay,2400);
        [Dist3,d3,index3] = subdtw(signal_1_az,raw_signal2_az,2400);
        [Dist4,d4,index4] = subdtw(signal_1_gx,raw_signal2_gx,2400);
        [Dist5,d5,index5] = subdtw(signal_1_gy,raw_signal2_gy,2400);
        [Dist6,d6,index6] = subdtw(signal_1_gz,raw_signal2_gz,2400);
        
%         d = d1+d2+d3+d4; 
%         Dist = Dist1+Dist2+Dist3+Dist4+Dist5+Dist6;
           Dist = Dist1+Dist3+Dist4+Dist5+Dist6;
%          disp(Dist);
        [d,index] = min(Dist(1,:));
        
%        disp(d);
%        disp(d1);
%        disp(location1(k1(i+1),:))
%        disp(location2(k2(i+1),:))
%        disp(location2(index,:));
%        disp('-----------------------');

end

