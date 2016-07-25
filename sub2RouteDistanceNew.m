function [d] = sub2RouteDistanceNew( temp1, temp2 )

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

        d1 = mydtw(signal_1_ax,raw_signal2_ax,2400);
%         [Dist2,d2,index2] = subdtw(signal_1_ay,raw_signal2_ay,2400);
        d3 = mydtw(signal_1_az,raw_signal2_az,2400);
        d4 = mydtw(signal_1_gx,raw_signal2_gx,2400);
        d5 = mydtw(signal_1_gy,raw_signal2_gy,2400);
        d6 = mydtw(signal_1_gz,raw_signal2_gz,2400);
        
        d = d1+d3+d4+d5+d6; 

%         [d,index] = min(Dist(1,:));
        
%        disp(d);
%        disp(d1);
%        disp(location1(k1(i+1),:))
%        disp(location2(k2(i+1),:))
%        disp(location2(index,:));
%        disp('-----------------------');

end

