function draw
% step=0.05;
% upper=0.95;
% capa=zeros(floor(upper/step),1);
% dens=zeros(floor(upper/step),1);
% 
% for i=1:floor(upper/step)
%     [capa(i,1),dens(i,1)]=cellular(i*step);
% end

% csvwrite('capa_dens.csv',[dens,capa]);
% plot(dens,capa);
lstr='''p=10%''';
figure
for j=1:9
    eval(['out',num2str(j),'=csvread(','''capa_dens_4_',num2str(j),'.csv''',');']);
%     xx=0:0.0005:0.9;
%     eval(['yy=spline(out',num2str(j),'(:,1),out',num2str(j),'(:,2),xx);']);
      eval(['plot(out',num2str(j),'(:,1),out',num2str(j),'(:,2));']);
      if (j>=2)
      lstr=strcat(lstr,[',''p=',num2str(j*10),'%''']);
      end
%     eval(['plot(out',num2str(j),'(:,1),out',num2str(j),'(:,2),''o'',xx,yy);']);
    hold on
end

eval(['legend(',lstr,');']);