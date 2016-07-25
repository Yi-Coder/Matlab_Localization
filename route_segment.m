function [ output_args ] = route_segment( file1, file2 )

%  file1 = './oneRoadLocalization/yi/2015-12-01_08-15-10.csv';
%  file2 = './oneRoadLocalization/yi/2015-12-02_08-15-06.csv';
 temp1 = cvs2mat(file1); 
 temp2 = cvs2mat(file2); 
%  temp3 = cvs2mat('2015-12-03_08-15-15.csv');
%  temp4 = cvs2mat('2015-12-04_08-15-58.csv'); 
%  temp5 = cvs2mat('2015-12-07_08-15-07.csv'); 
%  temp6 = cvs2mat('2015-12-09_08-15-04.csv'); 
 
 location1 = temp1(:,1:2);
 location2 = temp2(:,1:2);
%  location3 = temp3(:,1:2);
%  location4 = temp4(:,1:2);
%  location5 = temp5(:,1:2);
%  location6 = temp6(:,1:2);
 
route_point=[33.852092, -84.335437;  % liangyi
33.844321, -84.327373;
% 33.839688, -84.320390;
% 33.832716, -84.335979;
% 33.830798, -84.339101;
33.825395, -84.348535;
33.823800, -84.352655;
% 33.819826, -84.361501;
% 33.803170, -84.385586;
% 33.800365, -84.390320;
33.797539, -84.393471;
% 33.789095, -84.391572;
% 33.774568, -84.390507;
% 33.769212, -84.390512;
% 33.766456, -84.387615;
% 33.765439, -84.385888;
33.755573, -84.387001;];

% route_point = [33.889820, -84.449556;   %guoliang
% % 33.889677, -84.451397;
% 33.893983, -84.453012;   
% 33.890492, -84.455877;  
% 33.887648, -84.455426;  
% 33.881728, -84.452857;  
% 33.880494, -84.453600;   
% 33.869556, -84.443125;  
% 33.851950, -84.431171;  
% 33.834783, -84.428151;  
% 33.807767, -84.417236;  
% 33.801144, -84.400736;  
% 33.798141, -84.395862;  
% 33.765602, -84.386101;  
% 33.762238, -84.384147; 
% % 33.755819, -84.384325;   
% 33.755588, -84.386100;]; 
% 
% route_point = [ 30.497889, 114.412091;  //china
% 30.505113, 114.380296; 
% 30.509957, 114.349397;
% 30.527254, 114.289463;
% 30.551594, 114.241571;
% 30.558611, 114.245423;
% 30.554477, 114.279230;
% 30.541223, 114.305821;
% 30.540188, 114.318535;
% 30.534200, 114.331216;
% 30.544281, 114.336688;
% 30.545307, 114.341999;
% 30.545922, 114.353310;
% 30.543410, 114.370790;
% 30.534447, 114.377624;
% 30.519263, 114.370156;
% % 30.515039, 114.368107;
% % 30.512409, 114.370275;
% 30.502582, 114.370896;];



k1 = dsearchn(location1, route_point);
k2 = dsearchn(location2, route_point);
% k3 = dsearchn(location3, route_point);
% k4 = dsearchn(location4, route_point);
% k5 = dsearchn(location5, route_point);
% k6 = dsearchn(location6, route_point);

% %  
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

segments = length(route_point)-1;

dax = zeros(segments,segments);
day = zeros(segments,segments);
daz = zeros(segments,segments);
% 
dgx = zeros(segments,segments);
dgy = zeros(segments,segments);
dgz = zeros(segments,segments);
d  = zeros(segments,segments);
count = 0;
for i=1:segments;
     signal_1_ax = raw_signal1_ax(k1(i):k1(i+1));
     signal_1_ay = raw_signal1_ay(k1(i):k1(i+1));
     signal_1_az = raw_signal1_az(k1(i):k1(i+1));
     
     signal_1_gx = raw_signal1_gx(k1(i):k1(i+1));
     signal_1_gy = raw_signal1_gy(k1(i):k1(i+1));
     signal_1_gz = raw_signal1_gz(k1(i):k1(i+1));
    for j=1:segments
        signal_2_ax = raw_signal2_ax(k2(j):k2(j+1));
        signal_2_ay = raw_signal2_ay(k2(j):k2(j+1));
        signal_2_az = raw_signal2_az(k2(j):k2(j+1));
        
        signal_2_gx = raw_signal2_gx(k2(j):k2(j+1));        
        signal_2_gy = raw_signal2_gy(k2(j):k2(j+1));
        signal_2_gz = raw_signal2_gz(k2(j):k2(j+1));
        
        dax(i,j) = mydtw(signal_1_ax,signal_2_ax,1);
%         day(i,j) = mydtw(signal_1_ay,signal_2_ay,1);
        daz(i,j) = mydtw(signal_1_az,signal_2_az,1);
        
        dgx(i,j) = mydtw(signal_1_gx,signal_2_gx,1);
        dgy(i,j) = mydtw(signal_1_gy,signal_2_gy,1);
        dgz(i,j) = mydtw(signal_1_gz,signal_2_gz,1);
        
        
        d(i,j) = dax(i,j)+daz(i,j)+dgx(i,j)+dgy(i,j)+dgz(i,j);
%       d(i,j) = dgx(i,j)+dgy(i,j)+dgz(i,j);
%         disp(d);
    end
        [~,ind]=  min(d(i,:));
        index= [i,ind];
        if(i==ind)
            count = count+1;
        end
% %     index = [i index_x index_y index_z];
     disp(index);
end
disp(count/5);

output_args = d;
% for i=1:length(d);
%     [value,index] = min(d(i,:));
%     disp(index); 
% end
% output_args = d;
%Save2ws('d',d)


% seg1 = raw_signal1(k1(1):k1(2));
% seg2 = raw_signal2(k2(2):k2(3));

% d = mydtw(seg1,seg2,1);
% disp(d);
% disp(k1);
% disp(k2);
% figure(1)
% plot(temp1(k1(1):k1(2),4));
% figure(2)
% plot(temp1(k1(2):k1(3),4));
% figure(3)
% plot(seg1);
% figure(4)
% plot(seg2);
% disp(location(k,:));


end

