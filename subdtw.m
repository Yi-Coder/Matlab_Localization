function [Dist,d,index] = subdtw( s,t,w )
% dynamic time warping of two signals
% s: signal 1, size is ns*k, row for time, colume for channel 
% t: signal 2, size is nt*k, row for time, colume for channel 
% w: window parameter
%      if s(i) is matched with t(j) then |i-j|<=w
% d: resulting distance


% s = [4;3];
% t = [1;3;5;3;1];

if nargin<3
    w=Inf;
end
% % 
  s = (s-mean(s))/std(s);   %normalize s and t
  t = (t-mean(t))/std(t);

[N,column]=size(s);
[M,column]=size(t);
if size(s,2)~=size(t,2)
    error('Error in d .tw(): the dimensions of the two input signals do not match.');
end
w=max(w, abs(M-N)); % adapt window size

%% cost matrix
c=(repmat(s(:),1,M)-repmat(t(:)',N,1)).^2;
% disp(c);
%% initialization
D=zeros(N+1,M+1)+Inf; % cache matrix
D(1,:) = 0;

for i= 2:N+1
    D(i,2) = sum(c(1:i-1,1));
end

for j= 2:M+1
    D(2,j) = c(1,j-1);
end

D(1,1)= 0;

% disp(D)
%% begin dynamic programming
for i=1:N
    for j= max(i-w,1):min(i+w,M)
        D(i+1,j+1)=c(i,j)+min( [D(i,j+1), D(i+1,j), D(i,j)] );
    end
end
%   disp(D);
Dist = D(N+1,:)/(M+N);
[d,index] = min(D(N+1,:));
d= d/(M+N);
index = index -1;

end



