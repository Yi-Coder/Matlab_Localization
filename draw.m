function [Dist,d,index] = draw( s,t,w )

TestData = dir ('.\turning\*.csv');
% 
% windowSize = 5;
% b = (1/windowSize)*ones(1,windowSize);
% a = 1;

for i = 1: length(TestData)
      file1{i} = strcat('.\turning\', TestData(i).name);
      temp1{i} = cvs2mat(file1{i}); 
end
k = 8;
figure(1)
plot(temp1{1}(48:148,k),'LineWidth',1);
hold on 
plot(temp1{4}(60:160,k),'LineWidth',1);
hold on
plot(temp1{5}(1:100,k),'LineWidth',1);

% file1 = '.\turning\2016-07-13_19-59-14.csv';
% file2 = '.\turning\2016-07-13_20-00-16.csv';
% file3 = '.\turning\2016-07-13_20-03-25.csv';

% data =[30.48,5.1816, 20.7264 ,1995.587, 305.7754,9.144,257.49504, 370.1491, 177.0278 ,23.7744 ,67.6656 ,125.273, 337.9622, 20.7264, 1593.2506,  917.3261, 116.738 ];
%  temp = load('./oneRoadLocalization/estimationerror.mat');
%  data = temp.data;
% j=1;
% k =1;
% for i = 1:length(data)
%     if(data(i)<3000)
%         data1(j)= data(i);
%         j= j+1;
%     end
%     if(data(i)<2000)
%         data2(k)= data(i);
%         k= k+1;
%     end
% end
% 
% mu = 0;
% sigma = 1;
% pd = makedist('Normal',mu,sigma);
% 
% y = cdf(pd,data1);
% 
% newdata = [mean(data1) mean(data2)];
% 
% figure(1)
% % cdfplot(data1);
% 
% bar(1,newdata(1),0.4,'r');
% hold on
% bar(2,newdata(2),0.4,'b');
% hold on
% cdfplot(data2);
% plot(data1,'.');

end