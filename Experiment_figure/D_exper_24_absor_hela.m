a_hela_24=...
[0.463	0.5565	0.5488	0.0478	0.0427	0.0484
0.567	0.5222	0.5097	0.2189	0.2495	0.2664
0.7297	0.703	0.7909	0.318	0.3976	0.4122
0.6649	0.7471	0.6939	0.6294	0.7196	0.562
0.7349	0.9274	0.9248	0.9088	1.0687	1.1009];

serum=[0
0.25
2
5
10];

set(0,'DefaultLineLineWidth',0.5);
set(0,'DefaultAxesFontSize',12,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',12,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');

% plot
var_name={'a_hela_24'};
for i=1
    eval(['wd=', var_name{i},'(:,1:3);']);  
    eval(['giv=',var_name{i},'(:,4:6);']);
    figure;hold on;set(gcf,'unit','centimeters','position',[1,1,12,9]);
    plot([1:length(serum)]', mean(wd,2),'b');
    plot([1:length(serum)]',mean(giv,2),'r');
    errorbar(1:length(serum),mean(wd,2),  std(wd,0,2)/sqrt(3),'bo','markerfacecolor','b','markersize',4,'linestyle','none','linewidth',1.5,'capsize',12);
    errorbar(1:length(serum),mean(giv,2),std(giv,0,2)/sqrt(3),'ro','markerfacecolor','r','markersize',4,'linestyle','none','linewidth',1.5,'capsize',12);
    xlim([0.6 5.8]);ylim([0 1.5])
    ylabel('Absorbance (590 nM)');
    xlabel('FBS concentration (%)');
    set(gca,'xtick',1:length(serum),'xticklabel',serum);
    legend('Parental','GIV KO');%set(gca,'xscale','log')
    temp=[];
    for j=1:length(serum)
        [h,p]=ttest2(wd(j,:),giv(j,:));
        temp=[temp,[h;p]];
    end
    %[temp(2,:)<1e-2;temp(2,:)<1e-3;temp(2,:)<1e-4]
    temp
end