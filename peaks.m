function [ output_args ] = peaks( input_args )

test = load('test.mat');
disp(test);

[pks2,locs2] = findpeaks(test.aY2,'MinPeakHeight',0.2,'MinPeakDistance',20);
[pks4,locs4] = findpeaks(test.aY4,'MinPeakHeight',0.2,'MinPeakDistance',20);

figure(2)
plot(1:length(test.aY2),test.aY2);
hold on
plot(locs2,pks2,'or');

figure(4)
plot(1:length(test.aY4),test.aY4);
hold on
plot(locs4,pks4,'or');


end

