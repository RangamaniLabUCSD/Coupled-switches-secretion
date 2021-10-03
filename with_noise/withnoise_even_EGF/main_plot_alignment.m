set(0,'DefaultLineLineWidth',3);
set(0,'DefaultAxesFontSize',28,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',28,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');


%copuled switches  
load('noise_mtG_sti_1000.mat');    
y=Y2;  sem_sti_mtG=std(y,0,3); me_sti_mtG=mean(y,3);

%single switch 
load('noise_mG_sti_1000.mat');  
y=Y2;  sem_sti_mG=std(y,0,3); me_sti_mG=mean(y,3); 

figure;  set(gcf,'unit','centimeters','position',[1,1,35,25]);

for kk=1:2
    subplot(2,2,(2*(kk-1))+1);hold on; 
    if kk==1  y=me_sti_mG;     z=sem_sti_mG;    end
    if kk==2  y=me_sti_mtG;    z=sem_sti_mtG;   end
    ind=1; % mGEF versus EGF 
    x_temp=I_all;  y_temp=y(:,ind)'; z_temp=z(:,ind)';
    h1=plot(x_temp,y_temp,'-','linewidth',1,'color','m');
    fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'m','EdgeColor','none','facealpha',0.2); 
    ind=3; % mG* versus EGF
    x_temp=I_all;  y_temp=y(:,ind)'; z_temp=z(:,ind)';
    h2=plot(x_temp,y_temp,'-','linewidth',1,'color','c');
    fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],'c','EdgeColor','none','facealpha',0.2);
    set(gca,'xscale','log');legend([h1,h2],'mGEF','mG*');
    
    subplot(2,2,2*kk);hold on; % mGEF versus mG*
    if kk==1 col='r'; y=me_sti_mG;      z=sem_sti_mG;   end  
    if kk==2 col='b'; y=me_sti_mtG;     z=sem_sti_mtG;  end 
     
    x_temp=y(:,1)'; y_temp=y(:,3)'; z_temp=z(:,3)';
    h=plot(x_temp,y_temp,'-','linewidth',1,'color',col);
    fill([x_temp,fliplr(x_temp)],[(y_temp-z_temp),fliplr((y_temp+z_temp))],col,'EdgeColor','none','facealpha',0.2);
    legend(h,'mG*');
    ylim([0 1])   
end
subplot(2,2,1);title('Single switch');xlabel('EGF');ylabel('fractional activation');
subplot(2,2,2);title('Single switch');xlabel(['$\overline{mGEF}$'],'Interpreter','latex');ylabel('fractional activation');ylim([0.2 1])
subplot(2,2,3);title('Coupled switches');xlabel('EGF');ylabel('fractional activation');
subplot(2,2,4);title('Coupled switches');xlabel(['$\overline{mGEF}$'],'Interpreter','latex');ylabel('fractional activation');ylim([0.2 1])
