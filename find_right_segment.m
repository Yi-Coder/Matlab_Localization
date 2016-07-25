function [ endpoint, distance,segment_number] = find_right_segment(start_point,observation, road)
%UNTITLED8 Summary of this function goes here

lob = length(observation);

% disp(length(lob));

% start_point =   3029;
for i = 1:12
%   disp(lob - start_point+1);
   if(length(road{i}) <= (lob - start_point+1))
%       [d(i),index(i)] = sub2RouteDistance(observation(start_point:(start_point+length(road{i})-1),:),road{i});
       d(i) = sub2RouteDistanceNew(road{i},observation(start_point:(start_point+length(road{i})-1),:));
%       disp(index(i));
   else
        d(i) = 1000;
%         index(i) = -1;
   end
   
end
    
%     disp(d);
    
%      d = (d - min(d))/(max(d)-min(d));
     d = 1./d;
     disp(d);
     [v,ind] = max(d);
     disp('..............')
%    disp(ind);
%    disp(index(ind));

    distance = d;
%     endpoint = start_point+ index(ind)-1;
    endpoint = start_point+ length(road{ind})-1;
%     disp(ind);  
%     disp(index(ind));
%     disp(endpoint);  
    segment_number = ind;
end

