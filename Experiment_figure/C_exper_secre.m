set(0,'DefaultLineLineWidth',0.5);
set(0,'DefaultAxesFontSize',15);
set(0,'DefaultTextFontSize',15);

secre_wt=[75.887	87.197	88.034
        76.494	91.587	89.268
        64.29	69.162	78.117
        48.919	39.875	37.283
        20.66	19.177	19.924
        11.267	13.992	12.169
        0.718	0.548	0.393];
secre_wt=secre_wt(end:-1:1,:);
secre_ko=[25.339	23.599	19.183
        28.928	18.281	21.986
        17.378	12.812	19.118
        14.107	10.722	18.281
        13.286	11.442	12.756
        0.162	0.481	0.519
        0.21	0.331	0.044];
secre_ko=secre_ko(end:-1:1,:);
EGF=[100
    50
    25
    10
    1
    0.1
    0];
EGF=EGF(end:-1:1,:);
wd=secre_wt;  giv=secre_ko;

figure;hold on; set(gcf,'unit','centimeters','position',[2,2,12,8]);
errorbar(1:7,mean(wd,2),std(wd,0,2)/sqrt(3),'ob-','linewidth',0.5,'capsize',8,'markersize',3);

x_t=EGF; y_t=mean(wd,2);  options = optimoptions('lsqcurvefit','display','off');
fun =@(x,xdata)x(1)*xdata.^x(2)./(x(3)^x(2)+xdata.^x(2)); 
x=lsqcurvefit(fun,[50 2 40],x_t,y_t,[],[],options);   
h7=plot(1:7,fun(x,x_t),'b+','markersize',10);  
R7=1-mean((fun(x,x_t)-y_t).^2)/mean((mean(y_t)-y_t).^2); [x,R7] 

hold on;errorbar(1:7,mean(giv,2),std(giv,0,2)/sqrt(3),'or-','linewidth',0.5,'capsize',8,'markersize',3);
ylim([0 100]);xlim([1 7])
ylabel('Secretion (% max)');xlabel('EGF (nM)');set(gca,'xtick',1:7,'xticklabel', EGF);
set(gca,'ytick',0:20:100);

legend('Parental',['fitting data (n_{Hill}=',num2str(round(x(2),2)),')'],'GIV KO');

H=[];P=[];
for i=1:length(EGF)
    [h,p]=ttest2(wd(i,:),giv(i,:));  
    H=[H,h]; P=[P,p];
end
[H;P]

