% Figure 3F
set(0,'DefaultLineLineWidth',2);
set(0,'DefaultAxesFontSize',28,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',28,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');
t_tG=[1 3 5 7.5 15 25 30];
Y_tG=[0.0122  0.0220    0.0170    0.0118    0.0120    0.0051    0.0021    0.0013
    0.0650    0.1300    0.0430    0.1510    0.1130    0.0760    0.0579    0.0671
    0.1380    0.3230    0.0910    0.2100    0.3240    0.2270    0.2910    0.1350
    0.2110    0.1980    0.1940    0.2100    0.1210    0.1250    0.1030    0.2230
    0.3290    0.2130    0.1280    0.2920    0.1330    0.2220    0.3350    0.3150
    0.2990    0.2180    0.2550    0.2950    0.3170    0.2360    0.3910    0.2490
    0.1990    0.1880   0.3260    0.3790    0.3770    0.2960    0.2990    0.2670];

t_tG_shgiv=[1 3 5 15 30];
Y_tG_shgiv=[ 0.0101    0.0134    0.0137    0.0027    0.0032    0.0015    0.0121    0.0113
            0.0211    0.0084    0.0177    0.0120    0.0213    0.0102    0.0312    0.0133
            0.0371    0.0192    0.0073    0.0312    0.0097    0.0302    0.0312    0.0239
            0.0026    0.0099    0.0131    0.0302    0.0031    0.0282    0.0329    0.0139
            0.0017    0.0229    0.0113    0.0294    0.0177    0.0202    0.0142    0.0269];
     
figure;hold on; set(gcf,'unit','centimeters','position',[1,1,22,18]);
t=t_tG;y=mean(Y_tG,2); z=std(Y_tG,0,2);
errorbar( t , y , z/sqrt(8),'o','linewidth',1,'color','k','CapSize',20,'markersize',8,'markerfacecolor','k');
y=y'; y(3)=[];t(3)=[]; 
ymax=0.295;
p=polyfit(t,log(ymax-y),1);
hold on;x=0:0.1:(max(t)+1);h1=plot(x,ymax-exp(p(2))*exp(x*p(1)),'b--');

t=t_tG_shgiv;y=mean(Y_tG_shgiv,2); z=std(Y_tG_shgiv,0,2);
errorbar( t , y , z/sqrt(8),'o','linewidth',1,'color','r','CapSize',20,'markersize',8,'markerfacecolor','r');
y=y'; y(3)=[];t(3)=[]; 
ymax=0.0231;
p=polyfit(t,log(ymax-y),1);
hold on;x=0:0.1:(max(t)+1);h2=plot(x,ymax-exp(p(2))*exp(x*p(1)),'r--');

xlabel('Time [min]');ylabel('dFRET/CFP');legend([h1 h2],'shControl','shGIV');
xlim([0 32]);ylim([0 0.32]); set(gca,'Xtick',0:5:35);

H=[];P=[];t=[];
for i=1:length(t_tG_shgiv)
    ind=find(t_tG==t_tG_shgiv(i));
    t=[t,[t_tG(ind);t_tG_shgiv(i)]];
    [h,p]=ttest2(Y_tG(ind,:)',Y_tG_shgiv(i,:)');  
    H=[H,h]; P=[P,p];
end
[H;P]
