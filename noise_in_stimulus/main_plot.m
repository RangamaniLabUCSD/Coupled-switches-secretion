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
    if kk==1  y1=me_sti_mG;     z1=sem_sti_mG;    end
    if kk==2  y1=me_sti_mtG;    z1=sem_sti_mtG;   end
    x_1=1; % mGEF versus EGF 
    h1=errorbar(I_all,y1(:,x_1),z1(:,x_1), 'vertical','-o','linewidth',1,'color','m','CapSize',10,'markersize',3,'markerfacecolor','m');
    x_1=3; % mG* versus EGF
    h2=errorbar(I_all,y1(:,x_1),z1(:,x_1), 'vertical','-o','linewidth',1,'color','c','CapSize',10,'markersize',3,'markerfacecolor','c');
    set(gca,'xscale','log');legend([h1,h2],'mGEF','mG*');
    
    subplot(2,2,2*kk);hold on; % mGEF versus mG*
    if kk==1 col='r';  end  
    if kk==2 col='b';  end  
    h=errorbar(y1(:,1),y1(:,3),z1(:,3), 'vertical','-o','linewidth',1,'color',col,'CapSize',10,'markersize',3,'markerfacecolor',col');
    legend(h,'mG*');
    ylim([0 1])   
end
subplot(2,2,1);title('Single switch');xlabel('EGF');ylabel('fractional activation');
subplot(2,2,2);title('Single switch');xlabel(['$\overline{mGEF}$'],'Interpreter','latex');ylabel('fractional activation');ylim([0.3 1])
subplot(2,2,3);title('Coupled switches');xlabel('EGF');ylabel('fractional activation');
subplot(2,2,4);title('Coupled switches');xlabel(['$\overline{mGEF}$'],'Interpreter','latex');ylabel('fractional activation');ylim([0.3 1])


figure;  set(gcf,'unit','centimeters','position',[1,1,35,25]);
subplot(2,2,1);hold on; % EGF versus tG*
y1=me_sti_mtG;     z1=sem_sti_mtG;  
x_1=5; %tG* 
errorbar(I_all,y1(:,x_1),z1(:,x_1), 'vertical','-o','linewidth',1,'color','b','CapSize',10,'markersize',3,'markerfacecolor','b');
set(gca,'xscale','log');legend('tG*');ylim([ 0 1]);title('Coupled switches');xlabel('EGF');ylabel('fractional activation');

subplot(2,2,3);hold on; % EGF versus secretion
x_1=7;   % secretoin 
errorbar(I_all,y1(:,x_1),z1(:,x_1),'vertical','-o','linewidth',1,'color','b','CapSize',10,'markersize',3,'markerfacecolor','b');
set(gca,'xscale','log');legend('Secretion');ylim([ 0 1]);title('Coupled switches');xlabel('EGF');ylabel('fractional activation');

