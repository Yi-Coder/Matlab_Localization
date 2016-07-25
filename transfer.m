function  [out_args] = transfer( input_args )
location = load('location.mat');

La = location.locationLatitude;
Lo = location.locationLongitude;

locationMat = zeros(length(La),2);
format long

for i=1:length(La) 
       if (~strcmp(La(i),''))  
         locationMat(i,1) = str2double(La(i));
       end
end

for j = 1:length(Lo)    
       if (~strcmp(Lo(j),''))
       locationMat(j,2) = str2double(Lo(j)); 
       end
end
out_args = locationMat;
save('locationMat.mat','locationMat');
end


