function [TT,Y]=sol_SDE_mtG_sti_con(tau,C0,stimulus0,eps_val,T,dt)
% Y is the dynamics of the coupled switches when noise in EGF and species. 
% tau: a vector consisting time scales of species
% C0:  initial state
% stimulus0: the mean value of EGF
% eps_val: a vector indicating amplitudes of noise in stimulus and species
% T: simualtion time
% dt: time step size

TT=0:dt:(T+dt);  n=length(TT)-1;
eps_sti=eps_val(1);   eps_con=eps_val(2);  
rand_d=normrnd(0,1,length(C0)+1,n)*sqrt(dt);
Y=ones(n+1,length(C0));
eta_sti=0; 
Y(1,:)=C0';
for j=2:n+1
    y=Y(j-1,:);
    mGEF=y(1);   mGAP=y(2);    mG  =y(3);

    tGEF=y(4);   tG  =y(5);    tGAP=y(6);

    secretion=y(7);   X=y(8);

    EC=0.5;n=1.4;para=[EC,n];

    dy=zeros(length(C0),1);
     
    eta_sti= eta_sti -dt*eta_sti +eps_sti *rand_d(1,j-1) + 0.5*eps_sti^2*(rand_d(1,j-1).^2-dt);

    
    dy(1)=(f_act(para,stimulus0+eta_sti)+0.008-mGEF)/tau(1);                    % mGEF     
    dy(2)=(f_act(para,tGEF)*f_act(para,tG)+0.014-mGAP)/tau(2);    % mGAP    
    dy(3)=((f_act(para,mGEF))*(1-mG)-f_act(para,mGAP)*mG)/tau(3); % mG

    dy(4)=(f_act([0.5 5],mG)-tGEF)/tau(4);                                 %tGEF
    dy(5)=((f_act([0.3 5],tGEF)+0.01)*(1-tG)-f_act(para,tGAP)*tG)/tau(5);  %tG*
    dy(6)=0.5-tGAP;                                                        %tGAP
    

    % fine-tuned value
    beta=100 ; alpha=100; r=1.67e-2;  K2=0.3;
    dy(7)= (  beta*(f_act([0.15 1.4],mGAP)+0.105)  -  alpha*secretion/(secretion+K2)  ) *X- r*secretion;     %secretion 
    lambda=1.67e-3;  mu=1.67e-4;  K=1e-3;  K1=0.25;  
    dy(8)=X * ( lambda *( secretion/(secretion+K1))*(1-X/K) - mu);   

    
    temp=Y(j-1,:)'+dy*dt;
    Y(j,:)=(abs(temp)+temp)/2; 
end
end
