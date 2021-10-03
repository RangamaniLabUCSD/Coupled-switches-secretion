% Figure 3J-K
set(0,'DefaultLineLineWidth',2);
set(0,'DefaultAxesFontSize',28,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',28,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');

%% mG* dynamic for control cells, shGIV cells, coupled switches but without arrow 2 or arrow 3
figure;hold on;set(gcf,'unit','centimeters','position',[1,1,22,18])

load matlab_GIV.mat
h3=plot(TT,Y(:,3)/mg_wild,'r');

load matlab_shC.mat
h4=plot(TT,Y(:,3)/mg_wild,'b');
errorbar(t_arf1,mean(Y_arf1,2),std(Y_arf1,0,2)/sqrt(3),'o','linewidth',1,'color','k','CapSize',20,'markersize',8,'markerfacecolor','k');

T=40;
[TT,Y]=ode45(@(t,y)f_endo(t,y,tau,Input_all(2),'shControl',12),0:0.1:T,ini);
h1=plot(TT(1:5:end),Y(1:5:end,3)/mg_wild,'--','color',[255 222 23]/265);

[TT,Y]=ode45(@(t,y)f_endo(t,y,tau,Input_all(2),'shControl',13),0:0.1:T,ini);
h2=plot(TT(3:5:end),Y(3:5:end,3)/mg_wild,'g--');

xlabel('Time [min]');ylabel(['Arf1','$\cdot$','GTP','[fold change]'],'Interpreter','latex');box off;
xlim([0 35]);set(gca,'Xtick',0:5:35);ylim([1 3.5])


%% mG* dynamic for control cells, shGIV cells, coupled switches but without arrow 2 or arrow 3
figure;hold on;set(gcf,'unit','centimeters','position',[1,1,22,18]);

load matlab_GIV.mat
h3=plot(TT,Y(:,5)/tg_wild,'r');% 0.0161 is the initial condition of tG* for shControl
errorbar(t_tG_shGIV,mean(Y_tG_shGIV,2),std(Y_tG_shGIV,0,2)/sqrt(8),'o','linewidth',1,'color','r','CapSize',20,'markersize',8,'markerfacecolor','r');

load matlab_shC.mat
h4=plot(TT,1/tg_wild*Y(:,5),'b');
errorbar(t_tG,mean(Y_tG,2),std(Y_tG,0,2)/sqrt(8), 'o','linewidth',1,'color','k','CapSize',20,'markersize',8,'markerfacecolor','k');

T=40;
[TT,Y]=ode45(@(t,y)f_endo(t,y,tau,Input_all(2),'shControl',12),0:0.1:T,ini);
h1=plot(TT(1:5:end),1/tg_wild*Y(1:5:end,5),'--','color',[255 222 23]/265);

[TT,Y]=ode45(@(t,y)f_endo(t,y,tau,Input_all(2),'shControl',13),0:0.1:T,ini);
h2=plot(TT(3:5:end),1/tg_wild*Y(3:5:end,5),'g--');

set(gca,'Xtick',0:5:35);ylim([0 35])
xlabel('Time [min]');ylabel('tG*');box off;
xlim([0 35]);set(gca,'Xtick',0:5:35);