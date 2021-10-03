function dy=f_endo(t,y,tau,stimulus,str,flag)
% dy is the reaction rate when species stay at state y for given stimulus. 
% tau: a vector consisting time scales of species
% str and flag are not used in this m file
mGEF=y(1);
mGAP=y(2);
mG  =y(3);

tGEF=y(4);
tG  =y(5);
tGAP=y(6);

secretion=y(7);
X=y(8);

EC=0.5;n=1.4;para=[EC,n];

dy=zeros(7,1);
dy(1)=(f_act(para,stimulus)+0.008-mGEF)/tau(1);                  %mGEF
if flag==123 
    dy(2)=(f_act(para,tGEF)*f_act(para,tG)+0.014-mGAP)/tau(2);   %mGAP
end 
if flag==12||flag==13
    dy(2)=(0.014-mGAP)/tau(2);                                   %mGAP
end
dy(3)=((f_act(para,mGEF))*(1-mG)-f_act(para,mGAP)*mG)/tau(3);    %mG*


dy(4)=(f_act([0.5 5],mG)-tGEF)/tau(4);                                 %tGEF
dy(5)=((f_act([0.3 5],tGEF)+0.01)*(1-tG)-f_act(para,tGAP)*tG)/tau(5);  %tG*
dy(6)=0;                                                               %tGAP


% fine-tuned value
beta=100 ; alpha=100; r=1.67e-2;  K2=0.3;
dy(7)= (  beta*(f_act([0.15 1.4],mGAP)+0.105)  -  alpha*secretion/(secretion+K2)  ) *X- r*secretion;     %secretion 
lambda=1.67e-3;  mu=1.67e-4;  K=1e-3;  K1=0.25;  
dy(8)=X * ( lambda *( secretion/(secretion+K1))*(1-X/K) - mu);   

    
end


