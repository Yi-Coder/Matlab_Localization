function [ output_args ] = route_distance( temp1, temp2 )

%  temp1 = cvs2mat(file1); 
%  temp2 = cvs2mat(file2); 

raw_signal1_ax= temp1(:,3);
raw_signal1_ay= temp1(:,4);
raw_signal1_az= temp1(:,5);
% 
raw_signal2_ax= temp2(:,3);
raw_signal2_ay= temp2(:,4);
raw_signal2_az= temp2(:,5);
% 
raw_signal1_gx= temp1(:,6);
raw_signal1_gy= temp1(:,7);
raw_signal1_gz= temp1(:,8);
% 
raw_signal2_gx= temp2(:,6);
raw_signal2_gy= temp2(:,7);
raw_signal2_gz= temp2(:,8);

        
        dax = mydtw(raw_signal1_ax,raw_signal2_ax,1);
%         day(i,j) = mydtw(signal_1_ay,signal_2_ay,1);
        daz = mydtw(raw_signal1_az,raw_signal2_az,1);
        
        dgx = mydtw(raw_signal1_gx,raw_signal2_gx,1);
        dgy = mydtw(raw_signal1_gy,raw_signal2_gy,1);
        dgz = mydtw(raw_signal1_gz,raw_signal2_gz,1);              
        d = dax+daz+dgx+dgy+dgz;       
%      disp(index);
       output_args = d;

end

