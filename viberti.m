function [ output_args ] = viberti( input_args )

states={'road1','road2','road3','road4','road5','road6','road7','road8','road9','road10','road11','road12'}; %The 12 "hidden" states   
Nst=length(states);% length of state

road{1} = [1 2 3 4];
road{2} = [1 4 5 7];
road{3} = [1 3 4 1 2];
road{4} = [4 4 2 4 7];
road{5} = [1 3 2 8 6 2 3];
road{6} = [7 7 2 3 4 5 1];
road{7} = [2 0 9 5 2];
road{8} = [2 1 8 9 2];
road{9} = [1 5 4 9 7 6];
road{10} = [9 6 4 8 2 3 1];
road{11} = [6 7 2 3 9 4 8];
road{12} = [1 2 3 6];

% [~,ml] = min(length(road{:}));
maxlength = length(road{1});
for i=2:length(road)
    if(length(road{i})>= maxlength)
       maxlength = length(road{i});
    end
end


observation = [1 3 4 1 2 2 1 ];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
lobservation = length(observation);


%Initial Probabilities of states
I_prob=[1/12, 1/12, 1/12, 1/12, 1/12, 1/12, 1/12, 1/12, 1/12, 1/12, 1/12, 1/12 ]';

% Transition Probabilities of states
T_prob=[
0.00	0.50	0.00	0.50	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00
0.00	0.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00
0.00	0.00	0.00	0.00	0.00	0.50	0.00	0.50	0.00	0.00	0.00	0.00
0.00	0.00	0.00	0.00	0.00	0.33	0.33	0.00	0.33	0.00	0.00	0.00
0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1.00	0.00	0.00
0.00	0.00	0.00	0.00	0.00	0.00	0.50	0.00	0.50	0.00	0.00	0.00
0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1.00	0.00	0.00
0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1.00	0.00
0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1.00
0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00
0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1.00
0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00
]; 
lob= 4; % observation length
del=zeros(Nst,lob);% collection of the maximum probability values at each stage
maxlist=del;
mx=zeros(1,12);
%Initialization
for t = 1:5
  if t==1
       [end_point,distance,segment_road]= find_right_segment(1,observation);
       del(:,t)= I_prob.*distance'; %Initialization   
       [p mx(t)]= max(del(:,t));  
%        disp(mx(t));
    disp(del(:,t));
        continue;    
  end
  disp('-------');
%    Recursive Phase
     if(lobservation - end_point+1 >= maxlength) 
         for j=1:Nst
             temp = del(:,t-1).*T_prob(:,j);
             temp = (temp - min(temp))/(max(temp)-min(temp));
           [del(j,t) maxlist(j,t)]= max(temp);           
         end         
%        disp(del(:,t));
%       disp(maxlist(:,t));
%        disp(end_point);
      [end_point,distance,segment_road]= find_right_segment(end_point,observation);
       del(:,t)=del(:,t).*distance';
       [p mx(t)]=max(del(:,t));
%        disp(mx(t));
     else
        del(:,t) = -1;
        maxlist(:,t) = -1;    
     end     
     disp(del(:,t));
end
%  disp(del(:,:));
%         % Termination and Backtrack stage
dec_state=zeros(1,lob);
decode_state=cell(1,lob);
% [pstar dec_state(lob)]= max(del(:,lob));

k = lob+1;
for i= lob:-1:1
    if (del(:,i) < 0)
        k = i;
    end      
end

%  disp(k);
[pstar dec_state(k-1)]= max(del(:,k-1));

%  disp(del(:,k-1));
for t=k-2:-1:1
    dec_state(t)= maxlist(dec_state(t+1),t+1);
end

for t=1:k-1
        decode_state{t}=states{dec_state(t)};  
end

disp(decode_state);

end

