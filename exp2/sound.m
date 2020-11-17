clc;clear all; close all;

% 数据录入
path = './train';
[y1,fs1]=audioread('train/2_mic1.wav');
[y2,fs2]=audioread('train/2_mic2.wav');
[y3,fs3]=audioread('train/2_mic3.wav');
[y4,fs4]=audioread('train/2_mic4.wav');
t=1:1:length(y1);

% draw
figure(1);
subplot(2,2,1);
stem(t,y1,'b');
subplot(2,2,2);
stem(t,y2,'g');
subplot(2,2,3);
stem(t,y3);
subplot(2,2,4);
stem(t,y4,'r');

% pre
pre_emphasis=0.97;
z1=[0 y1'];
z2=[0 y2'];
z3=[0 y3'];
z4=[0 y4'];
y1_pre=zeros(length(y1),1);
y2_pre=zeros(length(y2),1);
y3_pre=zeros(length(y3),1);
y4_pre=zeros(length(y4),1);
for i=2:length(z1)
    y1_pre(i-1)=z1(i)-pre_emphasis*z1(i-1);
    y2_pre(i-1)=z2(i)-pre_emphasis*z2(i-1);
    y3_pre(i-1)=z3(i)-pre_emphasis*z3(i-1);
    y4_pre(i-1)=z4(i)-pre_emphasis*z4(i-1);
end

%draw post-pre 
figure(2);
subplot(2,2,1);
stem(t,y1_pre,'b');
subplot(2,2,2);
stem(t,y2_pre,'g');
subplot(2,2,3);
stem(t,y3_pre);
subplot(2,2,4);
stem(t,y4_pre,'r');

y1_pre=y1_pre*1.0/max(abs(y1_pre));
y2_pre=y2_pre*1.0/max(abs(y2_pre));
y3_pre=y3_pre*1.0/max(abs(y3_pre));
y4_pre=y4_pre*1.0/max(abs(y4_pre));

%figure(3);
%stem(t,y1_pre);
 
%找起始点：
y1_init=find(y1_pre,1); 
y2_init=find(y2_pre,1);
y3_init=find(y3_pre,1);
y4_init=find(y4_pre,1);

%判定使用区域： judge_area()函数
y_init=[y1_init y2_init y3_init y4_init];
[t1,t2,t3,label]=judge_area(y_init,fs1);
switch label
    case 1
        theta=cal_direction_b(t1,t2,t3);
    case 2
        theta=cal_direction_s(t1,t2,t3);
    case 3
        theta=cal_direction_b(t1,t2,t3)-pi*3/2;
    case 4
        theta=cal_direction_s(t1,t2,t3)+pi/2;
    case 5
        theta=cal_direction_b(t1,t2,t3)-pi;
    case 6
        theta=cal_direction_b(t1,t2,t3)+pi;
    case 7
        theta=cal_direction_b(t1,t2,t3)+3*pi/2;
    case 8
        theta=cal_direction_b(t1,t2,t3)-pi/2;
end







