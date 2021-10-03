set(0,'DefaultLineLineWidth',3);
set(0,'DefaultAxesFontSize',28,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',28,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');



%copuled switches  
load('noise_mtG_sti_1000');    
y=Y2;  std_sti_mtG=std(y,0,3); me_sti_mtG=mean(y,3); 


load('noise_mtG_sti_spec_1000');    
y=Y2;  std_sti_spec_mtG=std(y,0,3); me_sti_spec_mtG=mean(y,3);

load('noise_mtG_sti_link_1000');    
y=Y2;  std_sti_link_mtG=std(y,0,3); me_sti_link_mtG=mean(y,3); 

%single switch 
load('noise_mG_sti_1000');    
y=Y2;  std_sti_mG=std(y,0,3); me_sti_mG=mean(y,3); 


load('noise_mG_sti_spec_1000');    
y=Y2;  std_sti_spec_mG=std(y,0,3); me_sti_spec_mG=mean(y,3); 

load('noise_mG_sti_link_1000');    
y=Y2;  std_sti_link_mG=std(y,0,3); me_sti_link_mG=mean(y,3); 

le='legend([h1,h2,h3,h4],'' sti'',''sti and link'',''sti and species'',''fitting curve'');';
options = optimoptions('lsqcurvefit','display','off');
%% dose alignment
figure;  set(gcf,'unit','centimeters','position',[1,1,35,25]);

% mG versus mGEF (single switch)
subplot(2,2,1);hold on; 
  y1=me_sti_mG;  y2=me_sti_link_mG;  y3= me_sti_spec_mG;     
 z1=std_sti_mG; z2=std_sti_link_mG;  z3=std_sti_spec_mG;   
x_temp=y3(:,1)'; y_temp=y3(:,3)'; z_temp=z3(:,3)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'b','EdgeColor','none','facealpha',0.5); 
x_temp=y2(:,1)'; y_temp=y2(:,3)'; z_temp=z2(:,3)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'g','EdgeColor','none','facealpha',0.5); 
x_temp=y1(:,1)'; y_temp=y1(:,3)'; z_temp=z1(:,3)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'r','EdgeColor','none','facealpha',0.5); 

h1=plot(y1(:,1),y1(:,3),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(y2(:,1),y2(:,3),'linestyle',':' ,'color','g','Linewidth',1.5);
h3=plot(y3(:,1),y3(:,3),'linestyle','-.','color','b','Linewidth',1.5);

fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2)); 
x_t=x_temp; y_t=y_temp; 
x=lsqcurvefit(fun,[0.5 1.4 0.5 0.4],x_t,y_t,[],[],options);    
h4=plot(x_t,fun(x,x_t),'k');  
R7=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2);[ x R7]
eval(le);
ylim([0.2 1.05])

% mG versus mGEF  (coupled switches)
subplot(2,2,2);hold on;
 y1=me_sti_mtG;  y2=me_sti_link_mtG;  y3= me_sti_spec_mtG;     
z1=std_sti_mtG; z2=std_sti_link_mtG;  z3=std_sti_spec_mtG;    
x_temp=y3(:,1)'; y_temp=y3(:,3)'; z_temp=z3(:,3)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'b','EdgeColor','none','facealpha',0.5); 
x_temp=y2(:,1)'; y_temp=y2(:,3)'; z_temp=z2(:,3)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'g','EdgeColor','none','facealpha',0.5); 
x_temp=y1(:,1)'; y_temp=y1(:,3)'; z_temp=z1(:,3)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'r','EdgeColor','none','facealpha',0.5); 

h1=plot(y1(:,1),y1(:,3),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(y2(:,1),y2(:,3),'linestyle',':','color','g','Linewidth',1.5);
h3=plot(y3(:,1),y3(:,3),'linestyle','-.','color','b','Linewidth',1.5);

fun =@(x,xdata)x(1)*xdata+x(2); 
x_t=x_temp; y_t=y_temp; 
x=lsqcurvefit(fun,[1 1.4 ],x_t,y_t,[],[],options);    
h4=plot(x_t,fun(x,x_t),'k');  
R7=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R7] 
eval(le);
ylim([0.2 1.05]) 

% tG versus EGF (coupled switches) 
subplot(2,2,3);hold on;  
 y1=me_sti_mtG;  y2=me_sti_link_mtG;  y3= me_sti_spec_mtG;     
z1=std_sti_mtG; z2=std_sti_link_mtG;  z3=std_sti_spec_mtG;    
x_temp=I_all+1e-4; y_temp=y3(:,5)'; z_temp=z3(:,5)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'b','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y2(:,5)'; z_temp=z2(:,5)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'g','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y1(:,5)'; z_temp=z1(:,5)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'r','EdgeColor','none','facealpha',0.5); 

h1=plot(I_all+1e-4,y1(:,5),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(I_all+1e-4,y2(:,5),'linestyle',':','color','g','Linewidth',1.5);
h3=plot(I_all+1e-4,y3(:,5),'linestyle','-.','color','b','Linewidth',1.5);

fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2))+x(4);
x_t=x_temp; y_t=y_temp;
x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);   
h4=plot(x_t,fun(x,x_t),'color','k');
R2=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R2] 
eval(le);
set(gca,'xscale','log');xlabel('EGF');ylabel('tG*');
ylim([0 1])


% tG versus tGEF  (coupled switches) 
subplot(2,2,4);hold on;  
 y1=me_sti_mtG;  y2=me_sti_link_mtG;  y3= me_sti_spec_mtG;     
z1=std_sti_mtG; z2=std_sti_link_mtG;  z3=std_sti_spec_mtG;    
x_temp=y3(:,4)'; y_temp=y3(:,5)'; z_temp=z3(:,5)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'b','EdgeColor','none','facealpha',0.5); 
x_temp=y2(:,4)'; y_temp=y2(:,5)'; z_temp=z2(:,5)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'g','EdgeColor','none','facealpha',0.5); 
x_temp=y1(:,4)'; y_temp=y1(:,5)'; z_temp=z1(:,5)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'r','EdgeColor','none','facealpha',0.5); 

h1=plot(y1(:,4),y1(:,5),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(y2(:,4),y2(:,5),'linestyle',':','color','g','Linewidth',1.5);
h3=plot(y3(:,4),y3(:,5),'linestyle','-.','color','b','Linewidth',1.5);

fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2))+x(4);
x_t=x_temp; y_t=y_temp;
x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);   
h4=plot(x_t,fun(x,x_t),'color','k');
R2=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R2] 
eval(le);
xlabel('tEGF');ylabel('tG*');
ylim([0 1])


%new figure for secretion and cell numbers at 24h

figure;  set(gcf,'unit','centimeters','position',[1,1,35,25]);

% secretion versus EGF (uncoupled and coupled switches)
subplot(2,2,1);hold on; 
 y1=me_sti_mG;   y2=me_sti_link_mG;  y3= me_sti_spec_mG;     
 z1=std_sti_mG; z2=std_sti_link_mG;  z3=std_sti_spec_mG;   
x_temp=I_all+1e-4; y_temp=y3(:,4)'; z_temp=z3(:,4)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'b','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y2(:,4)'; z_temp=z2(:,4)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'g','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y1(:,4)'; z_temp=z1(:,4)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'r','EdgeColor','none','facealpha',0.5); 

h1=plot(I_all+1e-4,y1(:,4),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(I_all+1e-4,y2(:,4),'linestyle',':' ,'color','g','Linewidth',1.5);
h3=plot(I_all+1e-4,y3(:,4),'linestyle','-.','color','b','Linewidth',1.5);



  y1=me_sti_mtG;  y2=me_sti_link_mtG;  y3= me_sti_spec_mtG;     
 z1=std_sti_mtG; z2=std_sti_link_mtG;  z3=std_sti_spec_mtG;   
x_temp=I_all+1e-4; y_temp=y3(:,7)'; z_temp=z3(:,7)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'b','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y2(:,7)'; z_temp=z2(:,7)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'g','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y1(:,7)'; z_temp=z1(:,7)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'r','EdgeColor','none','facealpha',0.5); 

fun =@(x,xdata)x(1)*real(xdata.^x(2))./(real(x(3)^x(2))+real(xdata.^x(2))); 
x_t=linspace(x_temp(1),x_temp(end),100); y_t=interp1(x_temp,y_temp,x_t); 
x=lsqcurvefit(fun,[1 1.4 0.5 ],x_t,y_t,[],[],options);    
h4=plot(x_t,fun(x,x_t),'k');  
R7=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R7] 

h1=plot(I_all+1e-4,y1(:,7),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(I_all+1e-4,y2(:,7),'linestyle',':' ,'color','g','Linewidth',1.5);
h3=plot(I_all+1e-4,y3(:,7),'linestyle','-.','color','b','Linewidth',1.5);
set(gca,'xscale','log');   xlabel('EGF');ylabel('Secretion');


% secretion versus tG  (coupled switches)
subplot(2,2,2);hold on; 
  y1=me_sti_mtG;  y2=me_sti_link_mtG;  y3= me_sti_spec_mtG;     
 z1=std_sti_mtG; z2=std_sti_link_mtG;  z3=std_sti_spec_mtG;   
x_temp=y3(:,5)'; y_temp=y3(:,7)'; z_temp=z3(:,7)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'b','EdgeColor','none','facealpha',0.5); 
x_temp=y2(:,5)'; y_temp=y2(:,7)'; z_temp=z2(:,7)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'g','EdgeColor','none','facealpha',0.5); 
x_temp=y1(:,5)'; y_temp=y1(:,7)'; z_temp=z1(:,7)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'r','EdgeColor','none','facealpha',0.5); 

h1=plot(y1(:,5)',y1(:,7),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(y2(:,5)',y2(:,7),'linestyle',':' ,'color','g','Linewidth',1.5);
h3=plot(y3(:,5)',y3(:,7),'linestyle','-.','color','b','Linewidth',1.5);
xlabel('tG*');ylabel('Secretion');

fun =@(x,xdata)x(1)*real(xdata.^x(2))./(real(x(3)^x(2))+real(xdata.^x(2))+x(4)); 
x_t=linspace(x_temp(1),x_temp(end),100); y_t=interp1(x_temp,y_temp,x_t); 
x=lsqcurvefit(fun,[1e-3 1.4 0.1 0.01],x_t,y_t,[],[],options);    
h4=plot(x_t,fun(x,x_t),'k');  
R7=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R7] 
  

% cell number versus EGF  (uncoupled and coupled switches)
subplot(2,2,3);hold on;
 y1=me_sti_mG;  y2=me_sti_link_mG;  y3= me_sti_spec_mG;     
 z1=std_sti_mG; z2=std_sti_link_mG;  z3=std_sti_spec_mG;   
x_temp=I_all+1e-4; y_temp=y3(:,5)'; z_temp=z3(:,5)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'b','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y2(:,5)'; z_temp=z2(:,5)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'g','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y1(:,5)'; z_temp=z1(:,5)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'r','EdgeColor','none','facealpha',0.5); 

h1=plot(I_all+1e-4,y1(:,5),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(I_all+1e-4,y2(:,5),'linestyle',':' ,'color','g','Linewidth',1.5);
h3=plot(I_all+1e-4,y3(:,5),'linestyle','-.','color','b','Linewidth',1.5);


  y1=me_sti_mtG;  y2=me_sti_link_mtG;  y3= me_sti_spec_mtG;     
 z1=std_sti_mtG; z2=std_sti_link_mtG;  z3=std_sti_spec_mtG;   
x_temp=I_all+1e-4; y_temp=y3(:,8)'; z_temp=z3(:,8)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'b','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y2(:,8)'; z_temp=z2(:,8)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'g','EdgeColor','none','facealpha',0.5); 
x_temp=I_all+1e-4; y_temp=y1(:,8)'; z_temp=z1(:,8)'; fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'r','EdgeColor','none','facealpha',0.5); 

h1=plot(I_all+1e-4,y1(:,8),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(I_all+1e-4,y2(:,8),'linestyle',':' ,'color','g','Linewidth',1.5);
h3=plot(I_all+1e-4,y3(:,8),'linestyle','-.','color','b','Linewidth',1.5);

fun =@(x,xdata)x(1)*real(xdata.^x(2))./(real(x(3)^x(2))+real(xdata.^x(2))+x(4)); 
x_t=linspace(x_temp(1),x_temp(end),100); y_t=interp1(x_temp,y_temp,x_t); 
x=lsqcurvefit(fun,[1e-3 1.4 0.04 1e-4],x_t,y_t,[],[],options);    
h4=plot(x_t,fun(x,x_t),'k');  
R7=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R7] 


set(gca,'xscale','log');   xlabel('EGF');ylabel('Cell number');



