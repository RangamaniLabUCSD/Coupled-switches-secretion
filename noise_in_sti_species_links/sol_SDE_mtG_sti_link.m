function [TT,Y]=sol_SDE_mtG_sti_link(tau,C0,stimulus0,eps_val,T,dt)
% Y is the dynamics of the coupled switches when noise in EGF and connections . 
% tau: a vector consisting time scales of species
% C0:  initial state
% stimulus0: the mean value of EGF
% eps_val: a vector indicating amplitudes of noise in stimulus and connections 
% T: simualtion time
% dt: time step size

TT=0:dt:(T+dt);  n=length(TT)-1;
eps_sti=eps_val(1);   eps_link=eps_val(2);  
rand_num=normrnd(0,1,n,length(C0))*sqrt(dt);
Y=ones(n+1,length(C0));  
Y(1,:)=C0';
sigma_link=zeros(7,1);
for j=2:n+1
    y=Y(j-1,:);
    mGEF=y(1);   mGAP=y(2);    mG  =y(3);

    tGEF=y(4);   tG  =y(5);    tGAP=y(6);

    secretion=y(7);  eta=y(8);

    EC=0.5;n=1.4;para=[EC,n];

    dy=zeros(length(C0),1);
    
    dy(8)=-eta;  
    sti=stimulus0+eta;   % EGF    
    
    dy(1)=(f_act(para,sti)+0.008-mGEF)/tau(1);                     sigma_link(1)=eps_link;                                                       % mGEF     
    dy(2)=(f_act(para,tGEF)*f_act(para,tG)+0.014-mGAP)/tau(2);     sigma_link(2)=sqrt((eps_link*f_act(para,tG))^2+(eps_link*f_act(para,tGEF))^2);% mGAP    
    dy(3)=((f_act(para,mGEF))*(1-mG)-f_act(para,mGAP)*mG)/tau(3);  sigma_link(3)=sqrt((eps_link*(1-mG)).^2+(eps_link*mG).^2);                    % mG

    dy(4)=(f_act([0.5 5],mG)-tGEF)/tau(4);                                  sigma_link(4)=eps_link;                                     %tGEF
    dy(5)=((f_act([0.3 5],tGEF)+0.01)*(1-tG)-f_act(para,tGAP)*tG)/tau(5);   sigma_link(5)=sqrt((eps_link*(1-tG)).^2+(eps_link*tG).^2);  %tG*
    dy(6)=(0.5-tGAP);                                                       sigma_link(6)=0;                                            %tGAP
    
    dy(7)=(f_act([0.2 1.4],mGAP)-secretion)/tau(7);                         sigma_link(7)=eps_link;%secretion
    
    sigma=[sigma_link;eps_sti]./[tau';1];
    temp2=Y(j-1,:)'+dy*dt+sigma.*rand_num(j-1,:)'...
        +0.5*(sigma.^2).*((rand_num(j-1,:)').^2-dt);   
    tposi=(abs(temp2)+temp2)/2;
    Y(j,:)=[tposi(1:(end-1),:);temp2(end)];  %Milstein scheme
end
end
