function dy=f_mG(t,y,tau,stimulus)
% dy is the reaction rate when species stay at state y for given stimulus. The model is built based on the single switch
% tau: a vector consisting time scales of species


mGEF=y(1);
mGAP=y(2);
mG  =y(3);

EC=0.5;n=1.4;para=[EC,n];
B=(EC^n-1)/(2*EC^n-1);K=(B-1)^(1/n);

dy=zeros(3,1);
dy(1)=(f_act(para,stimulus)+0.008-mGEF)/tau(1);  % mGEF
dy(2)=(0.014-mGAP)/tau(2);   %mGAP
dy(3)=((f_act(para,mGEF))*(1-mG)-f_act(para,mGAP)*mG)/tau(3);   % mG*
    
end


