function y=f_act(para,x)
EC=para(1);n=para(2);
b=(EC^n-1)/(2*EC^n-1);%K=(b-1)^(1/n);
y=b*real(x.^n)./(b-1+real(x.^n));
%y(x>1)=1;y(x<0)=0;
end