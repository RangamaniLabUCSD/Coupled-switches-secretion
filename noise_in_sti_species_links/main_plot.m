set(0,'DefaultLineLineWidth',3);
set(0,'DefaultAxesFontSize',28,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',28,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');


load_name={'dte_2_1000/noise_mtG_sti_species.mat','dte_2_1000/noise_mG_sti_species.mat'}; 

%copuled switches  
load('dte_2_1000/noise_mtG_sti_con.mat');    
y=Y1;  std_sti_mtG=std(y,0,3); me_sti_mtG=mean(y,3);
y=Y2;  std_sti_species_mtG=std(y,0,3); me_sti_species_mtG=mean(y,3); 

load('dte_2_1000/noise_mtG_sti_link.mat');  
y=Y2;  std_sti_link_mtG=std(y,0,3); me_sti_link_mtG=mean(y,3); 

%single switch 
load('dte_2_1000/noise_mG_sti_con.mat');    
y=Y1;  std_sti_mG=std(y,0,3); me_sti_mG=mean(y,3);
y=Y2;  std_sti_species_mG=std(y,0,3); me_sti_species_mG=mean(y,3);  

load('dte_2_1000/noise_mG_sti_link.mat');  
y=Y2;  std_sti_link_mG=std(y,0,3); me_sti_link_mG=mean(y,3); 

fill_mGEF_3='fill([x_temp'',fliplr(x_temp'')],[(y3(:,x_1)-z3(:,x_1))'',fliplr((y3(:,x_1)+z3(:,x_1))'')],''m'',''EdgeColor'',''none'',''facealpha'',0.5);';
fill_mGEF_2='fill([x_temp'',fliplr(x_temp'')],[(y2(:,x_1)-z2(:,x_1))'',fliplr((y2(:,x_1)+z2(:,x_1))'')],''c'',''EdgeColor'',''none'',''facealpha'',0.5);';
fill_mGEF_1='fill([x_temp'',fliplr(x_temp'')],[(y1(:,x_1)-z1(:,x_1))'',fliplr((y1(:,x_1)+z1(:,x_1))'')],''k'',''EdgeColor'',''none'',''facealpha'',0.5);';

fill_mG_3='fill([x_temp'',fliplr(x_temp'')],[(y3(:,x_1)-z3(:,x_1))'',fliplr((y3(:,x_1)+z3(:,x_1))'')],''b'',''EdgeColor'',''none'',''facealpha'',0.5);';
fill_mG_2='fill([x_temp'',fliplr(x_temp'')],[(y2(:,x_1)-z2(:,x_1))'',fliplr((y2(:,x_1)+z2(:,x_1))'')],''g'',''EdgeColor'',''none'',''facealpha'',0.5);';
fill_mG_1='fill([x_temp'',fliplr(x_temp'')],[(y1(:,x_1)-z1(:,x_1))'',fliplr((y1(:,x_1)+z1(:,x_1))'')],''r'',''EdgeColor'',''none'',''facealpha'',0.5);';

le='legend([h1,h2,h3,h4],'' sti'',''sti and link'',''sti and species'',''fitting curve'');';
options = optimoptions('lsqcurvefit','display','off');
%% dose alignment
figure;  set(gcf,'unit','centimeters','position',[1,1,35,25]);
for kk=1:2
    subplot(2,2,(2*(kk-1))+1);hold on; 
    if kk==1
          y1=me_sti_mtG;  y2=me_sti_link_mtG;  y3= me_sti_species_mtG;     
         z1=std_sti_mtG; z2=std_sti_link_mtG;  z3=std_sti_species_mtG;    
    end
    if kk==2
          y1=me_sti_mG;  y2=me_sti_link_mG;  y3= me_sti_species_mG;     
         z1=std_sti_mG; z2=std_sti_link_mG;  z3=std_sti_species_mG;   
    end
    x_1=1; %mGEF versue EGF 
    x_temp=I_all'; eval(fill_mGEF_3);  eval(fill_mGEF_2);  eval(fill_mGEF_1);  
    h1=plot(I_all,y1(:,x_1),'linestyle','--','color','k','Linewidth',1.5);
    h2=plot(I_all,y2(:,x_1),'linestyle',':','color','c','Linewidth',1.5);
    h3=plot(I_all,y3(:,x_1),'linestyle','-.','color','m','Linewidth',1.5);
    fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2))+x(4); 
    x_t=I_all'; y_t=mean([y1(:,x_1)';y2(:,x_1)';y3(:,x_1)'])'; 
    x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);    h7=plot(x_t,fun(x,x_t),'k');  
    R7=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R7] 
    x_1=3;   % mG* versue EGF 
    x_temp=I_all'; eval(fill_mG_3);  eval(fill_mG_2);  eval(fill_mG_1);  
    h4=plot(I_all,y1(:,x_1),'linestyle','--','color','r','Linewidth',1.5);
    h5=plot(I_all,y2(:,x_1),'linestyle',':','color','g','Linewidth',1.5);
    h6=plot(I_all,y3(:,x_1),'linestyle','-.','color','b','Linewidth',1.5); 
    fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2))+x(4);
    options = optimoptions('lsqcurvefit','display','off');
    x_t=I_all'; y_t=mean([y1(:,x_1)';y2(:,x_1)';y3(:,x_1)'])'; 
    x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);    h8=plot(x_t,fun(x,x_t),'color',[.7 .7 .7]);
    R8=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R8] 
    set(gca,'xscale','log');
    legend([h1,h2,h3,h4,h5,h6,h7,h8],'mGEF sti','mGEF sti and link','mGEF sti and species','mG* sti','mG* sti and link','mG* sti and species'...
        ,'fitting curve','fitting curve');
        
    subplot(2,2,2*kk);hold on; x_1=3; %mGEF versue mG*
    x_temp=y3(:,1);  eval(fill_mG_3);     x_temp=y2(:,1);  eval(fill_mG_2);     x_temp=y1(:,1);  eval(fill_mG_1);
    h1=plot(y1(:,1),y1(:,x_1),'linestyle','--','color','r','Linewidth',1.5);
    h2=plot(y2(:,1),y2(:,x_1),'linestyle',':','color','g','Linewidth',1.5);
    h3=plot(y3(:,1),y3(:,x_1),'linestyle','-.','color','b','Linewidth',1.5);
    if kk==2
        fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2));
    end
    if kk==1
        fun =@(x,xdata)(x(1)*xdata+x(2));
    end
    x_t=mean([y1(:,1)';y2(:,1)';y3(:,1)'])';   y_t=mean([y1(:,x_1)';y2(:,x_1)';y3(:,x_1)'])';  
    x=lsqcurvefit(fun,[1 1.4 0.5],x_t,y_t,[],[],options);    h4=plot(x_t,fun(x,x_t),'color','k');
    R2=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R2] 
    %legend([h1,h2,h3,h4],' sti','sti and link','sti and species',['fitting,R^2=',num2str(roundn(R2,-2))]);ylim([0 1])
    eval(le);ylim([0 1])
    
end
subplot(2,2,1);title('Coupled switches');xlabel('EGF');ylabel('fractional activation');
subplot(2,2,2);title('Coupled switches');xlabel(['$\overline{mGEF}$'],'Interpreter','latex');ylabel('mG*');ylim([0.3 1])
subplot(2,2,3);title('Single switch');xlabel('EGF');ylabel('fractional activation');
subplot(2,2,4);title('Single switch');xlabel(['$\overline{mGEF}$'],'Interpreter','latex');ylabel('mG*');ylim([0.3 1])


%% tGEF versus input, tG* versus input, secretion versus input, tG* versus tGEF
figure;  set(gcf,'unit','centimeters','position',[1,1,35,25]);
 y1=me_sti_mtG;  y2=me_sti_link_mtG;  y3= me_sti_species_mtG;     
z1=std_sti_mtG; z2=std_sti_link_mtG;  z3=std_sti_species_mtG;  

subplot(2,2,1);hold on; 
x_1=4; x_temp=I_all'; %tGEF versus input
eval(fill_mG_3);   eval(fill_mG_2);    eval(fill_mG_1);
h1=plot(x_temp,y1(:,x_1),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(x_temp,y2(:,x_1),'linestyle',':','color','g','Linewidth',1.5);
h3=plot(x_temp,y3(:,x_1),'linestyle','-.','color','b','Linewidth',1.5);
fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2))+x(4);
options = optimoptions('lsqcurvefit','display','off');
x_t=x_temp; y_t=mean([y1(:,x_1)';y2(:,x_1)';y3(:,x_1)'])';  
x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);    h4=plot(x_t,fun(x,x_t),'color','k');
R2=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R2] 
set(gca,'xscale','log');xlabel('EGF');ylabel('tGEF');
ylim([0 1])

subplot(2,2,2);hold on; 
x_1=5;  x_temp=I_all'; % tG* versus input
eval(fill_mG_3);   eval(fill_mG_2);    eval(fill_mG_1);
h1=plot(x_temp,y1(:,x_1),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(x_temp,y2(:,x_1),'linestyle', ':','color','g','Linewidth',1.5);
h3=plot(x_temp,y3(:,x_1),'linestyle','-.','color','b','Linewidth',1.5);
fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2))+x(4);
x_t=x_temp; y_t=mean([y1(:,x_1)';y2(:,x_1)';y3(:,x_1)'])';  
x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);    h4=plot(x_t,fun(x,x_t),'color','k');
R2=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R2] 
set(gca,'xscale','log');xlabel('EGF');ylabel('tG*');
ylim([0 1])

subplot(2,2,3);hold on; 
x_1=7; x_temp=I_all';% secretion versus input
eval(fill_mG_3);   eval(fill_mG_2);    eval(fill_mG_1);
h1=plot(x_temp,y1(:,x_1),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(x_temp,y2(:,x_1),'linestyle', ':','color','g','Linewidth',1.5);
h3=plot(x_temp,y3(:,x_1),'linestyle','-.','color','b','Linewidth',1.5);
fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2))+x(4);
x_t=x_temp; y_t=mean([y1(:,x_1)';y2(:,x_1)';y3(:,x_1)'])';  
x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);    h4=plot(x_t,fun(x,x_t),'color','k');
R2=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R2] 
set(gca,'xscale','log');xlabel('EGF');ylabel('secretion');
ylim([0 1])


subplot(2,2,4);hold on; 
x_1=5; % tG* versus tGEF
x_temp=y3(:,4);  eval(fill_mG_3);     x_temp=y2(:,4);  eval(fill_mG_2);     x_temp=y1(:,4);  eval(fill_mG_1);
h1=plot(y1(:,4),y1(:,x_1),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(y2(:,4),y2(:,x_1),'linestyle', ':','color','g','Linewidth',1.5);
h3=plot(y3(:,4),y3(:,x_1),'linestyle','-.','color','b','Linewidth',1.5);
fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2))+x(4);
x_t=mean([y1(:,4)';y2(:,4)';y3(:,4)'])';  y_t=mean([y1(:,x_1)';y2(:,x_1)';y3(:,x_1)'])';  
x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);    h4=plot(x_t,fun(x,x_t),'color','k');
R2=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R2] 
xlabel(['$\overline{tGEF}$'],'Interpreter','latex');ylabel('tG*');
eval(le);axis([0  1 0 1])

%% secretion versus mG*,secretion versus tG*,secretion versus tG*
figure;  set(gcf,'unit','centimeters','position',[1,1,35,25]);
 y1=me_sti_mtG;  y2=me_sti_link_mtG;  y3= me_sti_species_mtG;     
z1=std_sti_mtG; z2=std_sti_link_mtG;  z3=std_sti_species_mtG;  

subplot(2,2,1);hold on; 
x_1=7; %secretion versus mG*
x_temp=y3(:,3);  eval(fill_mG_3);     x_temp=y2(:,3);  eval(fill_mG_2);     x_temp=y1(:,3);  eval(fill_mG_1);
h1=plot(y1(:,3),y1(:,x_1),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(y2(:,3),y2(:,x_1),'linestyle',':','color','g','Linewidth',1.5);
h3=plot(y3(:,3),y3(:,x_1),'linestyle','-.','color','b','Linewidth',1.5);
fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2))+x(4);
x_t=mean([y1(:,3)';y2(:,3)';y3(:,3)'])';  y_t=mean([y1(:,x_1)';y2(:,x_1)';y3(:,x_1)'])';  
x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);    h4=plot(x_t,fun(x,x_t),'color','k');
R2=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R2] 
xlabel(['$\overline{mG^*}$'],'Interpreter','latex');ylabel('secretion');
ylim([0 1])

subplot(2,2,2);hold on; 
x_1=7; %secretion versus tG*
x_temp=y3(:,5);  eval(fill_mG_3);     x_temp=y2(:,5);  eval(fill_mG_2);     x_temp=y1(:,5);  eval(fill_mG_1);
h1=plot(y1(:,5),y1(:,x_1),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(y2(:,5),y2(:,x_1),'linestyle',':','color','g','Linewidth',1.5);
h3=plot(y3(:,5),y3(:,x_1),'linestyle','-.','color','b','Linewidth',1.5);
fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2));
x_t=mean([y1(:,5)';y2(:,5)';y3(:,5)'])';  y_t=mean([y1(:,x_1)';y2(:,x_1)';y3(:,x_1)'])';  
x=lsqcurvefit(fun,[1 1.4 0.5 0],x_t,y_t,[],[],options);    h4=plot(x_t,fun(x,x_t),'color','k');
R2=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R2] 
xlabel(['$\overline{tG^*}$'],'Interpreter','latex');ylabel('secretion');
eval(le);ylim([0 1])

subplot(2,2,3);hold on; 
x_1=7; %secretion versus tG*
h1=plot(I_all,me_sti_mtG(:,7),'linestyle','--','color','r','Linewidth',1.5);
h2=plot(I_all,me_sti_mG(:,3),'linestyle',':','color','g','Linewidth',1.5);
xlabel('EGF');ylabel('fractional activation');
legend( 'secretion for coupled switches','mG* for the single switch');ylim([0 1])
