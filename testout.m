function testout(step,upper)
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
op=csvread('capa_dens.csv');
figure;
plot(op(:,1),op(:,2));
