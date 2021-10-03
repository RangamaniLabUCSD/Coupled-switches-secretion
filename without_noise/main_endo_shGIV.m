% simulation for shGIV cells
% run main_endo_shControl.m first to obtain the tg.fig, which plots the tG*
% dynamics for control cells, and then run this file to add tG* dynamics
% for shGIV cells in tg.fig.  (Figure 3E)
set(0,'DefaultLineLineWidth',2);
set(0,'DefaultAxesFontSize',28,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',28,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');

%% experimental afr1 data
t_arf1=[0 1 2.5 5 15 30]';
Y_arf1=[100 100 100;
        185.05 120.9222 190.5557;
        288.92 161.0746 200.71;	
        317.96 237.0369 288.4268;
        182.1 189.0586 222.099
        109.5 144.7975 184.71];
Y_arf1=Y_arf1/100;   % the same way as in main_endo_shControl.m to obtain fold change

%% experimental tG* data   ---------------------------
t_tG=[1 3 5 7.5 15 25 30]';
Y_tG=[0.0122  0.0220    0.0170    0.0118    0.0120    0.0051    0.0021    0.0013
    0.0650    0.1300    0.0430    0.1510    0.1130    0.0760    0.0579    0.0671
    0.1380    0.3230    0.0910    0.2100    0.3240    0.2270    0.2910    0.1350
    0.2110    0.1980    0.1940    0.2100    0.1210    0.1250    0.1030    0.2230
    0.3290    0.2130    0.1280    0.2920    0.1330    0.2220    0.3350    0.3150
    0.2990    0.2180    0.2550    0.2950    0.3170    0.2360    0.3910    0.2490
    0.1990    0.1880   0.3260    0.3790    0.3770    0.2960    0.2990    0.2670];
ini_tg_wild=mean(Y_tG(1,:));     % the baseline
Y_tG=Y_tG/mean(Y_tG(1,:));     % the same way as in main_endo_shControl.m to obtain fold change

t_tG_shGIV=[1 3 5  15 30]';    % time point of obsevations of tG* in shGIV cells
% Y_tG_shGIV: elements in i-th row are eight samples at when time is i-th element in t_tG_shGIV.
Y_tG_shGIV=[0.0101    0.0134    0.0137    0.0027    0.0032    0.0015    0.0121    0.0113
            0.0211    0.0084    0.0177    0.0120    0.0213    0.0102    0.0312    0.0133
            0.0371    0.0192    0.0073    0.0312    0.0097    0.0302    0.0312    0.0239
            0.0026    0.0099    0.0131    0.0302    0.0031    0.0282    0.0329    0.0139
            0.0017    0.0229    0.0113    0.0294    0.0177    0.0202    0.0142    0.0269];
Y_tG_shGIV=Y_tG_shGIV/ini_tg_wild;   %divided by the baseline 

% test whether there is significant difference between tG* data for control cells and shGIV cells 
for i=1:size(t_tG_shGIV,1)
    ind1=find(t_tG==t_tG_shGIV(i));
    [h,p]=ttest2(Y_tG(ind1,:),Y_tG_shGIV(i,:));  [h p]
end

%% simulation --------------------------------
Input_all=[0 0.23]; % stimulus =0 for simulating the serum-starved condition, and 0.23 for EGF=50nM.

% calculate the steady state whe stimulus=0 as the state of species under serum-starved condition
tau(1)=0.25;tau(2)=15;tau(3)=0.35;tau(4)=0.01;tau(5)=15; 
[TT,Y]=ode15s(@(t,y)f_endo(t,y,tau,Input_all(1),'shGIV',123),0:0.1:7000,0.5*ones(7,1));
ini=Y(end,:);

% take the steady state for control cells under serum-starved condition as the baseline for simulation results
[TT,Y]=ode15s(@(t,y)f_endo(t,y,tau,Input_all(1),'shControl',123),0:0.1:7000,0.5*ones(7,1));
tg_wild=Y(end,5);mg_wild=Y(end,3);

% simulate the dynamics for shGIV cells when EGF=50nM 
T=40;
[TT,Y]=ode15s(@(t,y)f_endo(t,y,tau,Input_all(2),'shGIV',123),0:0.1:T,ini);

% plot simulated and measured fold change for tG*, and calculate R2 and normalized RMSE 
open('tg.fig');hold on;
plot(TT,Y(:,5)/tg_wild,'r');

[~,y_pred]=ode45(@(t,y)f_endo(t,y,tau,Input_all(2),'shGIV',123),t_tG_shGIV,ini);
[rmse,r2]=my_rmse(Y_tG_shGIV,y_pred(:,5)/tg_wild);
disp(['(NRMSE, R2) for tG*=(',num2str(rmse/mean(reshape(Y_tG_shGIV,1,[]))),',',num2str(r2),')']);


save matlab_GIV.mat