function [output] = test(input)

TestData = dir ('./AllMapLocalizatoin/Lin/*.mat');
TrainingData = dir('./AllMapLocalizatoin/Liang/*.mat');

for i = 1: length(TestData)
        temp1 = load(strcat('./AllMapLocalizatoin/Lin/', TestData(i).name)); 
        f1=fieldnames(temp1);
        road{i} = temp1.(f1{1});
     for j =1: length(TrainingData)
  
            temp2 = load(strcat('./AllMapLocalizatoin/Liang/', TrainingData(j).name)); 
            f2=fieldnames(temp2);
            troad{j} = temp2.(f2{1});
            d(j) = route_distance( road{i},troad{j});
           disp('------------------------------------------------------------------------')         
     end
        [v,ind]= min(d); 
        index = [i,ind];
        disp(index);     
     disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
end






end