function [ output_args ] = viberti_pro( input_args )
states={'road1','road2','road3','road4','road5','road6','road7','road8','road9','road10','road11','road12'}; %The 12 "hidden" states   
Nst=length(states);% length of state


TestData = dir ('./AllMapLocalizatoin/Lin/*.mat');
TrainingData = dir('./AllMapLocalizatoin/Liang/*.mat');

     for i =1: length(TestData)
        temp1 = load(strcat('./AllMapLocalizatoin/Lin/', TestData(i).name)); 
        f1=fieldnames(temp1);
        road{i} = temp1.(f1{1});
        disp(length(road{i}));
     end
     
     for j =1: length(TrainingData)     
       temp2 = load(strcat('./AllMapLocalizatoin/Liang/', TrainingData(j).name)); 
       f2=fieldnames(temp2);
       troad{j} = temp2.(f2{1});
       disp(length(troad{j}));
    end


maxlength = length(road{12});

for i=2:length(road)
    if(length(road{i}) >= maxlength)
       maxlength = length(road{i});
    end
end
% disp(maxlength);


observation = vertcat(troad{3},troad{6},troad{7},troad{10});

lobservation = length(observation);

% disp(lobservation);


%Initial Probabilities of states
I_prob=[1/12 1/12 1/12 1/12 1/12 1/12 1/12 1/12 1/12 1/12 1/12 1/12];

% Transition Probabilities of states
T_prob=[
0.00	0.50	0.00	0.50	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00
0.00	0.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00
0.00	0.00	0.00	0.00	0.00	0.50	0.00	0.50	0.00	0.00	0.00	0.00
0.00	0.00	0.00	0.00	0.00	0.00	0.50	0.00	0.50	0.00	0.00	0.00
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
for t = 1:4
  if t==1
       [end_point,distance,segment_road]= find_right_segment(1,observation,road);
       del(:,t)= (I_prob.*distance)'; %Initialization
%        del(:,t) = mapminmax(del(:,t),0,1);
%        disp(mx(t));
    disp(del(:,t));
        continue;    
  end
 

  disp('ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt');
%    Recursive Phase
     disp(end_point);
     if(lobservation - end_point+1 >= maxlength) 
%          [del(:,t-1),~] = mapminmax(del(:,t-1),0,1);
         for j=1:Nst            
            temp= del(:,t-1).*T_prob(:,j);        
%             temp = (temp - min(temp))/(max(temp)-min(temp));
%             disp(temp);
           [del(j,t) maxlist(j,t)]= max(temp);
% %            disp(del(:,t));
         end                 
%           del(:,t)= (del(:,t) - min(del(:,t)))/(max(del(:,t))-min(del(:,t)));
%           disp(del(:,t));
%        disp(maxlist(:,t));
%        disp(end_point);
      [end_point,distance,segment_road]= find_right_segment(end_point,observation,road);

        disp('-------------------------------------------------------------------------');
%        disp(distance');
       del(:,t)=del(:,t).*distance';
%         disp(del(:,t));
%        [p mx(t)]=max(del(:,t));
%        disp(mx(t));
     else
        del(:,t) = -1;
        maxlist(:,t) = -1;    
     end     
%      disp(del(:,t));
end
  disp(del(:,:));
  disp(maxlist);
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


