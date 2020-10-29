T = readtable('DCS.csv');
a = T(:, 2);
array=table2array(a)

%%Quantization
f=290
n=8
q=f/(2^n-1)
t=1:1:290
x0=fix(array/q)
y1=x0*q
figure(1);
plot(t,array)
xlabel('Days', 'fontsize', 12, 'fontweight', 'bold')
ylabel('Magnitude (Richter Scale)', 'fontsize', 12, 'fontweight', 'bold')
set(gca , 'FontSize',13,'FontWeight','bold')
title('Raw data plot','fontsize', 12, 'fontweight', 'bold')
grid on;
figure(2);
plot(t,y1,"r");
xlabel('Days', 'fontsize', 12, 'fontweight', 'bold')
ylabel('Magnitude (Richter Scale)', 'fontsize', 12, 'fontweight', 'bold')
set(gca , 'FontSize',13,'FontWeight','bold')
title('Quantized data plot','fontsize', 12, 'fontweight', 'bold')
grid on;


%DELTA MODULATED SIGNAL
del=0.5; %delta without slope overload
%Start a loop and initialise output arrays to 0.
%Compare current and previous values and assign a 1 or 0 based on the result
%If value is 1 : Add delta value to the prev value in the recovered signal
%array and append the value to the array
%If value is 0 : Subtract delta value from the prev value and append the value
%to the array
flag=0; %intializing array with 0 for sine
for i=1:290 %for sine wave
if y(i)>=flag(i)
z(i)=1;
flag(i+1)=flag(i)+del;
else
z(i)=0;
flag(i+1)=flag(i)-del;
end
end
figure(3);
plot(array,'g', 'LineWidth',1.3) %setting linewidth and color for visibility
hold on
stairs(flag,'r','LineWidth',0.65) %setting linewidth and color for visibility
xlim([10 300])
legend('sine wave', 'DM sine wave')
xlabel('Time')
ylabel('Amplitude')
title('Without slope overload')
hold off

%DEMODULATION WITH LOW PASS FILTER
[num,den]=butter(2,0.4,'low');
m1=filter(num,den,flag);
figure(4);
plot(m1,'g');
title('Demodulated signal with low pass');
xlim([9 300])
xlabel('TIME','fontsize',10,'fontweight','bold');
ylabel('AMPLITUDE','fontsize',10,'fontweight','bold');
grid on;


