function [] = myfilter( input_args )
%load('third');
%Fs = 10;
%N = length(second);
%rng default;
%x = first;
%t = (0:N-1)/Fs;
%Fnorm = 10/(Fs/2);
%df = designfilt('lowpassfir','PassbandFrequency',0.005,'StopbandFrequency',0.01 );
%fvtool(df);
%dataout = filter(df,third);
% grpdelay(df,2048,Fs);
% D = mean(grpdelay(df));
% y = filter(df,[first; zeros(D,1)]);
% y = y(D+1:end);
% figure;
% plot(t,first,t,y,'r','linewidth',1.5);
% title('filtered waveform');
%temp = transfer;
raw_signal = temp(1)
d =fdesign.bandpass('N,F3dB1,F3dB2',10,0.05,2,10);
Hd = design(d,'butter');
filtered_signal = filter(Hd,raw_signal);

figure(1)
plot(raw_signal);
figure(2)
plot(filtered_signal);

end

