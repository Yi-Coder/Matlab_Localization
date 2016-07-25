function [ d1m,d2m ] = distanceByGps( la1,lo1,la2,lo2 )
% this function is used to compute the distance between two points given
% the GPS informatoin

radius=6371000;  % earth radius
lat1=la1*pi/180;
lat2=la2*pi/180;
lon1=lo1*pi/180;
lon2=lo2*pi/180;
deltaLat=lat2-lat1;
deltaLon=lon2-lon1;
a=sin((deltaLat)/2)^2 + cos(lat1)*cos(lat2) * sin(deltaLon/2)^2;
c=2*atan2(sqrt(a),sqrt(1-a));
d1m=radius*c;    %Haversine distance

x=deltaLon*cos((lat1+lat2)/2);
y=deltaLat;
d2m=radius*sqrt(x*x + y*y); %Pythagoran distance

end


