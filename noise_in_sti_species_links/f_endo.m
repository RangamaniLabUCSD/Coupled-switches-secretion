function dy=f_endo(t,y,tau,stimulus,sh,flag)
% same as the f_endo.m in the folder "without_noise"
mGEF=y(1);
mGAP=y(2);
mG  =y(3);

tGEF=y(4);
tG  =y(5);
tGAP=y(6);

secretion=y(7);
basal=0;

EC=0.5;n=1.4;para=[EC,n];
B=(EC^n-1)/(2*EC^n-1);K=(B-1)^(1/n);

dy=zeros(7,1);
dy(1)=(f_act(para,stimulus)+0.008-mGEF)/tau(1);
dy(2)=0;   %mGAP
dy(3)=((f_act(para,mGEF))*(1-mG)-f_act(para,mGAP)*mG)/tau(3);

dy(4)=0;   %tGEF
dy(5)=((f_act([0.3 5],tGEF)+0.01)*(1-tG)-f_act(para,tGAP)*tG)/tau(5);
dy(6)=0;


dy(7)=(f_act([0.2 1.4],mGAP)+basal-secretion)/tau(7);


dy(2)=(f_act(para,tGEF)*f_act(para,tG)+0.014-mGAP)/tau(2);
dy(4)=(f_act([0.5 5],mG)+basal-tGEF)/tau(4);    


    
end


