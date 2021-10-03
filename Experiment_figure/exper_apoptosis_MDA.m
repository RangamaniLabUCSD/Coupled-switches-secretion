set(0,'DefaultLineLineWidth',3);
set(0,'DefaultAxesFontSize',20,'DefaultAxesFontWeight','bold');
set(0,'DefaultTextFontSize',20,'DefaultTextFontWeight','bold');

[num,txt,raw] = xlsread('../Source Data/apoptosis MDA MB 231 cells.xlsx');
num=num(:,~isnan(num(1,:)));

le={'G_2/M cells %','Apoptotic cells %','Apoptotic cells %',...
                    'Apoptotic cells %','Apoptotic cells %'};

ylim_max=[15 20 20 40 15];

figure;hold on; set(gcf,'unit','centimeters','position',[2,2,50,18]);  
for j=1:5
    subplot(2,3,j);hold on;

    wt  = num(1:2:end,(j-1)*3+(1:3));
    bar(0.5:2:4.5,mean(wt,2),0.4,'b');     errorbar(0.5:2:4.5,mean(wt,2),std(wt,[],2)/sqrt(3),'color','k','linewidth',1.5,'capsize',10,'linestyle','none');
    giv = num(2:2:end,(j-1)*3+(1:3));
    bar(1.5:2:5.5,mean(giv,2),0.4,'r');    errorbar(1.5:2:5.5,mean(giv,2),std(giv,[],2)/sqrt(3),'color','k','linewidth',1.5,'capsize',10,'linestyle','none');
    xlim([0 6]);
    ylim([0 ylim_max(j)])
    set(gca,'xtick',[0.5:1:5.5]);
    set(gca,'xticklabel',{'Parental (FBS 0%)' ,'GIV KO (FBS 0%)',...
                          'Parental (FBS 2%)' ,'GIV KO (FBS 2%)',...
                          'Parental (FBS 10%)','GIV KO (FBS 10%)'});
    ylabel(le(j));

    [h1,p1]=ttest2(wt(1,:)',giv(1,:)'); 
    [h2,p2]=ttest2(wt(2,:)',giv(2,:)'); 
    [h3,p3]=ttest2(wt(3,:)',giv(3,:)'); 

    [h1 h2 h3;p1 p2 p3]
        

end