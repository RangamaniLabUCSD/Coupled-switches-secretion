set(0,'DefaultLineLineWidth',0.5);
set(0,'DefaultAxesFontSize',12,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',12,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');

[num,txt,raw] = xlsread('../Source Data/HeLa pakt quantification.xlsx');
num=num(:,~isnan(num(1,:)));

%p-Akt/Akt versus FBS
fbs=num(1:4,1);
wt=num(1:4,4); giv=num(5:8,4);
figure;hold on;set(gcf,'unit','centimeters','position',[1,1,12,9]);
plot(1:length(fbs),wt ,'bo-','markerfacecolor','b');
plot(1:length(fbs),giv,'rs-','markerfacecolor','r');
set(gca,'xtick',1:length(fbs),'xticklabel',fbs);
xlabel('FBS %');ylabel('p-Akt/Akt');
axis([ 0.5 4.5 0 0.15])
legend('HeLa Parental','HeLa GIV KO');

%p-Akt/GRAPDH versus FBS
wt=num(1:4,6); giv=num(5:8,6);
figure;hold on;set(gcf,'unit','centimeters','position',[1,1,12,9]);
plot(1:length(fbs),wt ,'bo-','markerfacecolor','b');
plot(1:length(fbs),giv,'rs-','markerfacecolor','r');
set(gca,'xtick',1:length(fbs),'xticklabel',fbs);
xlabel('FBS %');ylabel('p-Akt/GRAPDH');
axis([ 0.5 4.5 0 0.015])
legend('HeLa Parental','HeLa GIV KO');