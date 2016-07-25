function [ output_args ] = allMapLocalizatoin( input_args )
 
TestData = dir ('./AllMapLocalizatoin/Lin/*.mat');
TrainingData = dir('./AllMapLocalizatoin/Liang/*.mat');

k1=1;
     for i =1: length(TestData)            
          for j =1: length(TrainingData)
              if(strcmp(TestData(i).name,TrainingData(j).name))
                    temp1 = load(strcat('./AllMapLocalizatoin/Lin/', TestData(i).name)); 
                    temp2 = load(strcat('./AllMapLocalizatoin/Liang/', TrainingData(j).name)); 
                    
                    f1=fieldnames(temp1);
                    road{i} = temp1.(f1{1});
            
                    
                    f2=fieldnames(temp2);
                    troad{j} = temp2.(f2{1});
                    
                    
                    location1 = road{i}(:,1:2);
                    location2 = troad{j}(:,1:2);

                    windowSize = 5;
                    b = (1/windowSize)*ones(1,windowSize);
                    a = 1;
                    %  
                    raw_signal1_ax= filter(b,a, road{i}(:,3));
                    % raw_signal1_ay= filter(b,a, road{i}(:,4)); 
                    % raw_signal1_az= filter(b,a, road{i}(:,5));
                    % 
                    raw_signal2_ax= filter(b,a,troad{j}(:,3));
                    % raw_signal2_ay= filter(b,a,troad{j}(:,4));
                    % raw_signal2_az= filter(b,a,troad{j}(:,5));
                    % 
                    raw_signal1_gx= filter(b,a,road{i}(:,6));
                    raw_signal1_gy= filter(b,a,road{i}(:,7));
                    raw_signal1_gz= filter(b,a,road{i}(:,8));
                    % 
                    raw_signal2_gx= filter(b,a,troad{j}(:,6));
                    raw_signal2_gy= filter(b,a,troad{j}(:,7));
                    raw_signal2_gz= filter(b,a,troad{j}(:,8));
                    
                    for k =1:100:length(road{i})-500
                        disp(k);
                        signal_1_ax = raw_signal1_ax(k:k+500);
                        %signal_1_ay = raw_signal1_ay(k1(i):k1(i+1));
                        %signal_1_az = raw_signal1_az(k1(i):k1(i+1));

                        signal_1_gx = raw_signal1_gx(k:k+500);
                        signal_1_gy = raw_signal1_gy(k:k+500);
                        signal_1_gz = raw_signal1_gz(k:k+500);
                        
                        [Dist1,d1,index1] = subdtw(signal_1_ax,raw_signal2_ax,2400);
                        [Dist2,d2,index2] = subdtw(signal_1_gx,raw_signal2_gx,2400);
                        [Dist3,d3,index3] = subdtw(signal_1_gy,raw_signal2_gy,2400);
                        [Dist4,d4,index4] = subdtw(signal_1_gz,raw_signal2_gz,2400);
                        
                        Dist = Dist1+Dist2+Dist3+Dist4;
                        [d,index] = min(Dist(1,:));

                         disp(location1(k+500,:));
                %        disp(location2(i+600,:));
                         disp(location2(index,:));

                        [d1,~] = distanceByGps(location1(k+500,1),location1(k+500,2),location2(index,1),location2(index,2));   
                            disp(d1);
%                           if(d1 <=2000.00)
                            data(k1) = d1;
                            k1 = k1+1;
                        
                    end
                    
              end
          end
     end   
     
    save('./AllMapEstimationError.mat','data');
    disp(data);
    mu = 0;
    sigma = 1;
    pd = makedist('Normal',mu,sigma);

    y = cdf(pd,data);

    figure(1)
    cdfplot(data);


end

