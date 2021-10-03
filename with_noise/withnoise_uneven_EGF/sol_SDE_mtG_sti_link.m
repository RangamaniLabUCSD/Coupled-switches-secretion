function [TT,Y]=sol_SDE_mtG_sti_link(tau,C0,stimulus0,eps_val,T,dt)
% Y is the dynamics of the coupled switches when noise in EGF and species. 
% tau: a vector consisting time scales of species
% C0:  initial state
% stimulus0: the mean value of EGF
% eps_val: a vector indicating amplitudes of noise in stimulus and species
% T: simualtion time
% dt: time step size

TT=0:dt:(T+dt);  n=length(TT)-1;
eps_sti=eps_val(1);   eps_con=eps_val(2);  
rand_d=normrnd(0,1,12,n)*sqrt(dt);
Y=ones(n+1,length(C0));
eta_sti=0;  eta_1=0;   eta_2=0;   eta_3=0;   eta_4=0;   eta_5=0;  eta_6=0;   eta_7=0;   eta_8=0; 
eta_9=0;   eta_10=0;   eta_11=0; 
Y(1,:)=C0';
for j=2:n+1
    y=Y(j-1,:);
    mGEF=y(1);   mGAP=y(2);    mG  =y(3);

    tGEF=y(4);   tG  =y(5);    tGAP=y(6);

    secretion=y(7);   X=y(8);

    EC=0.5;n=1.4;para=[EC,n];

    dy=zeros(length(C0),1);
     
    eta_sti= eta_sti -dt*eta_sti +eps_sti *rand_d(1,j-1) + 0.5*eps_sti^2*(rand_d(1,j-1).^2-dt);
    eta_1  = eta_1   -dt*eta_1   +eps_con *rand_d(2,j-1) + 0.5*eps_con^2*(rand_d(2,j-1).^2-dt);
    eta_2  = eta_2   -dt*eta_2   +eps_con *rand_d(3,j-1) + 0.5*eps_con^2*(rand_d(3,j-1).^2-dt);
    eta_3  = eta_3   -dt*eta_3   +eps_con *rand_d(4,j-1) + 0.5*eps_con^2*(rand_d(4,j-1).^2-dt);
    eta_4  = eta_4   -dt*eta_4   +eps_con *rand_d(5,j-1) + 0.5*eps_con^2*(rand_d(5,j-1).^2-dt);
    eta_5  = eta_5   -dt*eta_5   +eps_con *rand_d(6,j-1) + 0.5*eps_con^2*(rand_d(6,j-1).^2-dt);
    eta_6  = eta_6   -dt*eta_6   +eps_con *rand_d(7,j-1) + 0.5*eps_con^2*(rand_d(7,j-1).^2-dt);
    eta_7  = eta_7   -dt*eta_7   +eps_con *rand_d(8,j-1) + 0.5*eps_con^2*(rand_d(8,j-1).^2-dt);
    eta_8  = eta_8   -dt*eta_8   +eps_con *rand_d(9,j-1) + 0.5*eps_con^2*(rand_d(9,j-1).^2-dt);
    
    eta_9  = eta_9   -dt*eta_9   +eps_con *rand_d(9,j-1) + 0.5*eps_con^2*(rand_d(9,j-1).^2-dt);
    eta_10 = eta_10  -dt*eta_10  +eps_con *rand_d(10,j-1)+ 0.5*eps_con^2*(rand_d(10,j-1).^2-dt);
    eta_11 = eta_11  -dt*eta_11  +eps_con *rand_d(11,j-1)+ 0.5*eps_con^2*(rand_d(11,j-1).^2-dt);
   
    
    
    dy(1)=(f_act(para,stimulus0+eta_sti)+eta_1+0.008-mGEF)/tau(1);                    % mGEF     
    dy(2)=((f_act(para,tGEF)+eta_2)*(f_act(para,tG)+eta_3)+0.014-mGAP)/tau(2);    % mGAP    
    dy(3)=((f_act(para,mGEF)+eta_4)*(1-mG)-(f_act(para,mGAP)+eta_5)*mG)/tau(3); % mG

    dy(4)=(f_act([0.5 5],mG)+eta_6-tGEF)/tau(4);                                 %tGEF
    dy(5)=((f_act([0.3 5],tGEF)+eta_7+0.01)*(1-tG)-(f_act(para,tGAP)+eta_8)*tG)/tau(5);  %tG*
    dy(6)=0.5-tGAP;                                                        %tGAP
    
                                
    beta=100 ; alpha=100; r=1.67e-2;  K2=0.3;
    dy(7)= (  beta*(f_act([0.15 1.4],mGAP)+0.105)+eta_9  -  alpha*secretion/(secretion+K2)  +eta_10 ) *X- r*secretion;     %secretion 
    lambda=1.67e-3;  mu=1.67e-4;  K=1e-3;  K1=0.25;  
    dy(8)=X * ( lambda *( secretion/(secretion+K1))*(1-X/K)+eta_11/10 - mu);   


    temp=Y(j-1,:)'+dy*dt;
    Y(j,:)=(abs(temp)+temp)/2; 
end
end
