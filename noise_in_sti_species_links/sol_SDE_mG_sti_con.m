function [TT,Y]=sol_SDE_mG_sti_con(tau,C0,stimulus0,eps_val,T,dt)
% this file is the same as the sol_SDE_mG_sti_con.m in the folder "noise_in_stimulus"
TT=0:dt:(T+dt);  n=length(TT)-1;
eps_sti=eps_val(1);   eps_con=eps_val(2);    
rand_num=normrnd(0,1,n,length(C0))*sqrt(dt);
Y=ones(n+1,length(C0));  
Y(1,:)=C0';   temp=[];
for j=2:n+1
    y=Y(j-1,:);
    mGEF=y(1);   mGAP=y(2);    mG  =y(3);
    
    eta=y(4);

    EC=0.5;n=1.4;para=[EC,n];

    dy=zeros(length(C0),1);
    
    dy(4)=-eta;  
    sti=stimulus0+eta;   % EGF
    
    dy(1)=(f_act(para,sti)+0.008-mGEF)/tau(1);                    % mGEF     
    dy(2)=(0.014-mGAP)/tau(2);                                    % mGAP    
    dy(3)=((f_act(para,mGEF))*(1-mG)-f_act(para,mGAP)*mG)/tau(3); % mG

    sigma=[eps_con*ones(3,1);eps_sti]./[tau';1];
    temp2=Y(j-1,:)'+dy*dt+sigma.*rand_num(j-1,:)'...
        +0.5*(sigma.^2).*((rand_num(j-1,:)').^2-dt);   
    tposi=(abs(temp2)+temp2)/2;
    Y(j,:)=[tposi(1:(end-1),:);temp2(end)];
end

end
