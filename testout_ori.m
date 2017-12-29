function testout(step,lower,upper)
% step=0.05;
% upper=0.95;
capa=zeros(floor((upper-lower)/step),1);
 dens=zeros(floor((upper-lower)/step),1);
 
 for i=1:floor((upper-lower)/step)
     [capa(i,1),dens(i,1)]=cellular(lower+i*step);
 end

 csvwrite('capa_dens.csv',[dens,capa]);
 %plot(dens,capa);
