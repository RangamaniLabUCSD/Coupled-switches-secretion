function dy=f_endo(t,y,tau,stimulus,str,flag)
% dy is the reaction rate when species stay at state y for given stimulus. 
% tau: a vector consisting time scales of species
% str: indicator for using the model for shGIV cells if str is equal to 'shGIV'.
% flag: indicator for the existence of arrows 2 or 3; if flag=123, arrows
%       1,2, and 3 all exsits; if it is 12 (or 13), arrow 3 (or 2) does not exist. 
mGEF=y(1);
mGAP=y(2);
mG  =y(3);

tGEF=y(4);
tG  =y(5);
tGAP=y(6);

secretion=y(7);

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


if strcmp(str,'shGIV') 
    %dy(4)=(0.1*f_act(para,mG)-tGEF)/tau(4); 
    dy(4)=(0.1*f_act([0.5 5],mG)-tGEF)/tau(4);   %tGEF for shGIV cells
end
    
end


