function [TT,Y]=sol_SDE_mG_sti(tau,C0,stimulus0,eps_val,T,dt)
% Y is the dynamics of single switch when noise in EGF and species . 
% tau: a vector consisting time scales of species
% C0:  initial state
% stimulus0: the mean value of EGF
% eps_val: a vector indicating amplitudes of noise in stimulus and species
% T: simualtion time
% dt: time step size

TT=0:dt:(T+dt);  n=length(TT)-1;
eps_sti=eps_val(1);   eps_con=eps_val(2);    
rand_d=normrnd(0,1,9,n)*sqrt(dt);
Y=ones(n+1,length(C0));   
Y(1,:)=C0';   
eta_sti=0;  
for j=2:n+1
    y=Y(j-1,:);
    mGEF=y(1);   mGAP=y(2);    mG  =y(3);  secretion=y(4);   X=y(5);
     

    eta_sti= eta_sti -dt*eta_sti +eps_sti *rand_d(1,j-1) + 0.5*eps_sti^2*(rand_d(1,j-1).^2-dt);
     
    EC=0.5;n=1.4;para=[EC,n];

    dy=zeros(length(C0),1); 
    dy(1)=(f_act(para,stimulus0+eta_sti)+0.008-mGEF)/tau(1);                    % mGEF     
    dy(2)=(0.014-mGAP)/tau(2);           
    dy(3)=((f_act(para,mGEF))*(1-mG)-(f_act(para,mGAP))*mG)/tau(3); % mG
                                 

    beta=100 ; alpha=100; r=1.67e-2;  K2=0.3;
    dy(4)= (  beta*(f_act([0.15 1.4],mGAP)+0.105)  -  alpha*secretion/(secretion+K2)  ) *X- r*secretion;     %secretion 
    lambda=1.67e-3;  mu=1.67e-4;  K=1e-3;  K1=0.25;  
    dy(5)=X * ( lambda *( secretion/(secretion+K1))*(1-X/K) - mu);   




    
    temp=Y(j-1,:)'+dy*dt;
    
    Y(j,:)=(abs(temp)+temp)/2;  
    
end

end
