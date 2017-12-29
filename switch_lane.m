function [plaza,v,vmax]=switch_lane(plaza,v,vmax,gap,lfront,lback,rfront,rback,pch);
    [L,W]=size(plaza);%车道大小，包括边界
    changeL=zeros(L,W);%可向左变道
    changeR=zeros(L,W);%可向右变道
    
    %check if can  change to the left lane
for lanes=3:W-1;
        temp=find(plaza(:,lanes)~=0);
        nn=length(temp); 
    for k=1:nn;
            i=temp(k);
            l=min(v(i,lanes),vmax(i,lanes));
        
        if(plaza(i,lanes)==1)  %when the object is an ordinary car
            lb=vmax(i,lanes);
            %lr=rand;
            if(l>gap(i,lanes)&&lfront(i,lanes)>l&&lback(i,lanes)>lb&&rand<pch)
                  changeL(i,lanes)=1;
            end
        end
        
        if(plaza(i,lanes)==2)    %when the object is a smart car
            if(plaza(temp(mod(k+1,nn)+1),lanes)==1)
                lb=vmax(i,lanes);
            %lr=rand;
                if(l>gap(i,lanes)&&lfront(i,lanes)>l&&lback(i,lanes)>lb)
                  changeL(i,lanes)=1;
                end
            end
            
            if(plaza(temp(mod(k+1,nn)+1),lanes)==2)
                changeL(i,lanes)=0;
            end
        end
        
        
    end
end

    %check if can  change to the right lane
    for lanes=2:W-2;
          temp=find(plaza(:,lanes)~=0);
        nn=length(temp); 
    for k=1:nn;
            i=temp(k);
            l=min(v(i,lanes),vmax(i,lanes));
        
        if(plaza(i,lanes)==1)  %when the object is an ordinary car
            lb=vmax(i,lanes);
            %lr=rand;
            if(l>gap(i,lanes)&&rfront(i,lanes)>l&&rback(i,lanes)>lb&&rand<pch)
                  changeR(i,lanes)=1;
                  if(changeL(i,lanes)==1)
                      if(rand<0.5)
                           changeL(i,lanes)=0;
                      else
                          changeR(i,lanes)=0;
                      end
                  end
            end
        end
        
        if(plaza(i,lanes)==2)    %when the object is a smart car
            if(plaza(temp(mod(k+1,nn)+1),lanes)==1)
                lb=vmax(i,lanes);
            %lr=rand;
                if(l>gap(i,lanes)&&rfront(i,lanes)>l&&rback(i,lanes)>lb)
                  changeR(i,lanes)=1;
                  if(changeL(i,lanes)==1)
                      if(rand<0.5)
                           changeL(i,lanes)=0;
                      else
                          changeR(i,lanes)=0;
                      end
                  end
                end
            end
            
            if(plaza(temp(mod(k+1,nn)+1),lanes)==2)
                changeR(i,lanes)=0;
            end
        end
        
        
    end
end

    
    %change to the left lane
    for lanes=3:W-1;
        temp=find(changeL(:,lanes)==1);
        nn=length(temp);
        for k=1:nn;
            i=temp(k);
            plaza(i,lanes-1)=plaza(i,lanes);
            v(i,lanes-1)=v(i,lanes);
            vmax(i,lanes-1)=vmax(i,lanes);
            plaza(i,lanes)=0;
            v(i,lanes)=0;
            vmax(i,lanes)=0;          
            
            changeL(i,lanes)=0;
        end
    end
    %change to the right lane
    for lanes=2:W-2
        temp=find(changeR(:,lanes)==1);
        nn=length(temp);
        for k=1:nn;
            i=temp(k);
            plaza(i,lanes+1)=plaza(i,lanes);
            v(i,lanes+1)=v(i,lanes);
            vmax(i,lanes+1)=vmax(i,lanes);
            plaza(i,lanes)=0;
            v(i,lanes)=0;
            vmax(i,lanes)=0;
        end
    end
end