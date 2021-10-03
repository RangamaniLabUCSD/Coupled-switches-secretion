function dy=f_mG(t,y,tau,stimulus)
% dy is the reaction rate when species stay at state y for given stimulus. The model is built based on the single switch
% tau: a vector consisting time scales of species

mGEF=y(1);
mGAP=y(2);
mG  =y(3);

secretion=y(4);
X=y(5);

EC=0.5;n=1.4;para=[EC,n];

dy=zeros(5,1);
dy(1)=(f_act(para,stimulus)+0.008-mGEF)/tau(1);                  %mGEF
dy(2)=(0.014-mGAP)/tau(2);                                   %mGAP
dy(3)=((f_act(para,mGEF))*(1-mG)-f_act(para,mGAP)*mG)/tau(3);    %mG*


% fine-tuned value
beta=100 ; alpha=100; r=1.67e-2;  K2=0.3;
dy(4)= (  beta*(f_act([0.15 1.4],mGAP)+0.105)  -  alpha*secretion/(secretion+K2)  ) *X- r*secretion;     %secretion 
lambda=1.67e-3;  mu=1.67e-4;  K=1e-3;  K1=0.25;  
dy(5)=X * ( lambda *( secretion/(secretion+K1))*(1-X/K) - mu);   



    
end