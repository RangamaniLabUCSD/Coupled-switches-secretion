% simulation for control cells  (Figure 2F and Figure 3E)

set(0,'DefaultLineLineWidth',2);
set(0,'DefaultAxesFontSize',28,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',28,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');

%% experimental afr1 data ---------------------------
t_arf1=[0 1 2.5 5 15 30]';   % time point
% Y_arf1: elements in i-th row are three samples at when time is i-th element in t_arf1.
Y_arf1=[100 100 100;
        185.05 120.9222 190.5557;
        288.92 161.0746 200.71;	
        317.96 237.0369 288.4268;
        182.1 189.0586 222.099
        109.5 144.7975 184.71];  
% Y_arf1 is changed to the fold change with baseline 100 (the initial state)
Y_arf1=Y_arf1/100;

%% experimental tG* data ---------------------------
t_tG=[1 3 5 7.5 15 25 30]';    % time point
% Y_tG: elements in i-th row are eight samples at when time is i-th element in t_tG.
Y_tG=[0.0122  0.0220    0.0170    0.0118    0.0120    0.0051    0.0021    0.0013
    0.0650    0.1300    0.0430    0.1510    0.1130    0.0760    0.0579    0.0671
    0.1380    0.3230    0.0910    0.2100    0.3240    0.2270    0.2910    0.1350
    0.2110    0.1980    0.1940    0.2100    0.1210    0.1250    0.1030    0.2230
    0.3290    0.2130    0.1280    0.2920    0.1330    0.2220    0.3350    0.3150
    0.2990    0.2180    0.2550    0.2950    0.3170    0.2360    0.3910    0.2490
    0.1990    0.1880    0.3260    0.3790    0.3770    0.2960    0.2990    0.2670];
% Y_tG is changed to the fold change with baseline the mean value of samples when time=1min. 
Y_tG=Y_tG/mean(Y_tG(1,:));

%% model simulation --------------------------------
Input_all=[0 0.23]; % stimulus =0 for simulating the serum-starved condition, and 0.23 for EGF=50nM.
tau(1)=0.25;tau(2)=15;tau(3)=0.35;tau(4)=0.01; tau(5)=15;   %time scales for mGEF, mGAP, mG, tGEF,tG ,tGAP

% calculate the steady state whe stimulus=0 as the state of species under serum-starved condition
[TT,Y]=ode15s(@(t,y)f_endo(t,y,tau,Input_all(1),'shControl',123),0:0.1:7000,0.5*ones(7,1));
ini=Y(end,:);

% simulate the dynamics for control cells when EGF=50nM 
T=40;
[TT,Y]=ode15s(@(t,y)f_endo(t,y,tau,Input_all(2),'shControl',123),0:0.1:T,ini);
figure;hold on;plot(TT,Y);
xlabel('Time [min]');ylabel('fractional activation');legend('mGEF','mGAP','mG*','tGEF','tG*','tGAP','Secretion');

% plot simulated and measured fold change for mG*, and calculate R2 and normalized RMSE 
figure;hold on; set(gcf,'unit','centimeters','position',[1,1,22,18]);
plot(TT,1/Y(1,3)*Y(:,3),'b');
errorbar(t_arf1,mean(Y_arf1,2),std(Y_arf1,0,2)/sqrt(3), 'o','markerfacecolor','k','linewidth',1,'color','k','CapSize',20,'markersize',8,'markerfacecolor','k');
xlim([0 35]);ylim([1 3.5]);set(gca,'Xtick',0:5:35);
xlabel('Time [min]');ylabel(['Arf1','$\cdot$','GTP','[fold change]'],'Interpreter','latex');box off;


[~,y_pred]=ode15s(@(t,y)f_endo(t,y,tau,Input_all(2),'shControl',123),t_arf1,ini);
[rmse,r2]=my_rmse(Y_arf1,y_pred(:,3)/y_pred(1,3));
disp(['(NRMSE, R2) for mG*=(',num2str(rmse/mean(reshape(Y_arf1,1,[]))),',',num2str(r2),')']);

% plot simulated and measured fold change for tG*, and calculate R2 and normalized RMSE 
figure;hold on; set(gcf,'unit','centimeters','position',[1,1,22,18]);
plot(TT,1/Y(1,5)*Y(:,5),'b');
errorbar(t_tG,mean(Y_tG,2),std(Y_tG,0,2)/sqrt(8), 'o','markerfacecolor','k','linewidth',1,'color','k','CapSize',20,'markersize',8,'markerfacecolor','k');
xlim([0 35]);ylim([0 35]);set(gca,'Xtick',0:5:35);
xlabel('Time [min]');ylabel('tG* [fold change]');  
savefig('tg.fig');

[~,y_pred]=ode15s(@(t,y)f_endo(t,y,tau,Input_all(2),'shControl',123),t_tG,ini);
[rmse,r2]=my_rmse(Y_tG,y_pred(:,5)/y_pred(1,5));
disp(['(NRMSE, R2) for tG*=(',num2str(rmse/mean(reshape(Y_tG,1,[]))),',',num2str(r2),')']);


save matlab_shC.mat

