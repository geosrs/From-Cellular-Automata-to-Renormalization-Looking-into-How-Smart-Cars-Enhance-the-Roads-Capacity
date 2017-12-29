function [capacity,density]=cellular(probc,oratio);
clc;
%clear all;
close all;

B=4;             %The number of the lanes
plazalength=150;  %The length of the simulating highways
h=NaN;           %h is the handle of the image
freshtime=0.01;
a=0.73/5.0;   %max acceleration
b=1.67/5.0;   %max decceleration
T=1.5;   %driver's reaction time
flux_cnt=zeros(plazalength,1);
probe_itvl=5;  %the probing interval for detecting capacity
[plaza,v]=create_plaza(B,plazalength);
h=show_plaza(plaza,h,freshtime);

iterations=300;     
density=probc;      % density of cars(/km)
probv=[oratio 1];      % ���ֳ������ܶȷֲ�
probslow=0.5;       % �����ĸ���
pch=0.9;            %probability of changing lanes
Dsafe=1;            % ��ʾ�����³���������泵������ٸ���λ���㰲ȫ
VTypes=[12,18];       %��·��һ���м�������ٶȲ�ͬ�ĳ���,�ٶ���ʲô
[plaza,v,vmax]=new_cars(plaza,v,probc,probv,VTypes);%һ��ʼ���ڳ����ϲ��ó�����������ѭ����ʻ��Ҳ����۲������ܶ�֮��Ĺ�ϵ

size(find(plaza~=0))
PLAZA=rot90(plaza,2);
h=show_plaza(PLAZA,h,freshtime);
for t=1:iterations;
    size(find(plaza~=0))
    PLAZA=rot90(plaza,2);
    h=show_plaza(PLAZA,h,freshtime);
    [v,gap,lfront,lback,rfront,rback]=para_count(plaza,v,vmax,a,b,T,probslow);
    [plaza,v,vmax]=switch_lane(plaza,v,vmax,gap,lfront,lback,rfront,rback,pch);
   % [plaza,v,vmax]=random_slow(plaza,v,vmax,probslow);
    [plaza,v,vmax,flux_cnt]=move_forward(plaza,v,vmax,t,probe_itvl,flux_cnt);
    
end
flux_cnt
capacity=sum(flux_cnt)/(0.5*iterations);
%%/(floor(plazalength/probe_itvl));




