function testout_find4(step,lower,upper)
% step=0.05;
% upper=0.95;
capa=zeros(floor((upper-lower)/step),1);
 dens=zeros(floor((upper-lower)/step),1);
 for j=5:9
    for i=80:floor((upper-lower)/step)
     [capa(i,1),dens(i,1)]=cellular(lower+i*step,1-j*0.1);
    end
    s=['capa_dens',num2str(j),'.csv'];
    eval(['csvwrite(','''capa_dens_5_',num2str(j),'.csv''',',[dens,capa]);']);
    %figure
   % hold on;
   % plot([dens,capa]);
 end