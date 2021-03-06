function [v,gap,lfront,lback,rfront,rback]=para_count(plaza,v,vmax,a,b,T,probslow);
    [L,W]=size(plaza);%车道大小，包括边界
    %step1:每辆车在为了达到预期最大速度的时候会一个周期加一次速度
    for lanes=2:W-1;
        temp=find(plaza(:,lanes)~=0); 
        for k=1:length(temp)
            i=temp(k);
            v(i,lanes)=min(v(i,lanes)+1,vmax(i,lanes));
        end
    end
    %step2:计算每辆车与前面一辆车的距离gap
    gap=zeros(L,W);
    for lanes=2:W-1;
        temp=find(plaza(:,lanes)~=0);
        nn=length(temp);%该车道的车的数量
        for k=1:nn;
            i=temp(k);
            if(k==nn)
                gap(i,lanes)=L-(temp(k)-temp(1)+1);%为周期边界循环预处理的车距
                continue;
            end
           gap(i,lanes)=temp(k+1)-temp(k)-1; 
            
          if(plaza(i,lanes)==1) 
            
            v1(i,lanes)=min([ceil(v(i,lanes)+a),vmax(i,lanes)]);
            v_ps1=fix(v(i,lanes)+(gap(i,lanes)-v(i,lanes)*T)/((v(i,lanes)+v(temp(k+1)))/(2*b)+T));
            v2(i,lanes)=min([v1(i,lanes),v_ps1]);
            if(rand<=probslow)
                v(i,lanes)=max(floor(v2(i,lanes)-b),0);
            else
                v(i,lanes)=v2(i,lanes);
            end
          end
          
          
          
          if(plaza(i,lanes)==2) 
           
            v1(i,lanes)=min([ceil(v(i,lanes)+a),vmax(i,lanes)]);
            v_cs=v(temp(k+1),lanes)+gap(i,lanes);
            v2(i,lanes)=min([v1(i,lanes),v_cs]);
            v(i,lanes)=v2(i,lanes);
           
          end
        end
 end
    
   

    %step3:计算每车左车道的前后车的距离是否在要求范围内
    lfront=zeros(L,W);
    lback=zeros(L,W);
    rfront=zeros(L,W);
    rback=zeros(L,W);
    
    %calculate the front and back gaps on the left
    for lanes=3:W-1;
        temp=find(plaza(:,lanes)~=0);
        nn=length(temp);
        for k=1:nn;
            i=temp(k);
            while(i+lfront(i,lanes)<=L&&plaza(mod(i+lfront(i,lanes)-1,L)+1,lanes-1)==0)
                lfront(i,lanes)=lfront(i,lanes)+1;
            end
            tmod=mod(i-lback(i,lanes)+L,L);
            if (tmod==0) tmod=L;
            end
            while(i-lback(i,lanes)>=1&&plaza(tmod,lanes-1)==0)
                lback(i,lanes)=lback(i,lanes)+1;
                tmod=mod(i-lback(i,lanes)+L,L);
            if (tmod==0) tmod=L;
            end
            end
        end
    end
    
     %calculate the front and back gaps on the right
    for lanes=2:W-2;
        temp=find(plaza(:,lanes)~=0);
        nn=length(temp);
        for k=1:nn;
            i=temp(k);
            xmod=mod(i+rfront(i,lanes)-1,L)+1;  %next position along the road
            while(plaza(xmod,lanes+1)==0&&i+rfront(i,lanes)<=L)
                rfront(i,lanes)=rfront(i,lanes)+1;
                xmod=mod(i+rfront(i,lanes)-1,L)+1;
            end
             tmod=mod(i-rback(i,lanes)+L,L);
            if (tmod==0) tmod=L;
            end
            while(plaza(tmod,lanes+1)==0&&i-rback(i,lanes)>=1)
                rback(i,lanes)=rback(i,lanes)+1;
                tmod=mod(i-rback(i,lanes)+L,L);
            if (tmod==0) tmod=L;
            end
            end
        end
    end
    
        
        
        
%             lback(i,lanes)=(plaza(mod(i-2,L)+1,lanes+1)==0);
%             if(k==nn)
%                 if(sum(plaza([i:L],lanes+1))==0 & sum(plaza([1:mod(i+gap(i,lanes),L)+1],lanes+1))==0)
%                     lfront(i,lanes)=1;
%                 end
%                 continue;
%             end
%             if(sum(plaza([i:i+gap(i,lanes)+1],lanes+1))==0)
%                 lfront(i,lanes)=1;
%             end
%         end
%     end


%     for i=1:L;
%         for j=1:W;
%             if(plaza(i,j)~=1)
%                     LUP(i,j)=-88;
%             end
%         end
%     end
%     LUP
end