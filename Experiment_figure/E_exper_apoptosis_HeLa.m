set(0,'DefaultLineLineWidth',3);
set(0,'DefaultAxesFontSize',20,'DefaultAxesFontWeight','bold');
set(0,'DefaultTextFontSize',20,'DefaultTextFontWeight','bold');

[num,txt,raw] = xlsread('../Source Data/apoptosis hela.xlsx');
num=num(:,~isnan(num(1,:)));

le={'Apoptotic cells %','Apoptotic cells %','Apoptotic cells %','Apoptotic cells %'};

ylim_max=[15 40 50 40];

figure;hold on; set(gcf,'unit','centimeters','position',[2,2,50,18]);  
for j=1:4
    subplot(2,3,j);hold on;

    wt  = num(1:2:end,(j-1)*3+(1:3));
    bar(0.5:2:8.5,mean(wt,2),0.4,'b');     errorbar(0.5:2:8.5,mean(wt,2),std(wt,[],2)/sqrt(3),'color','k','linewidth',1.5,'capsize',10,'linestyle','none');
    
    giv = num(2:2:end,(j-1)*3+(1:3));
    bar(1.5:2:9.5,mean(giv,2),0.4,'r');    errorbar(1.5:2:9.5,mean(giv,2),std(giv,[],2)/sqrt(3),'color','k','linewidth',1.5,'capsize',10,'linestyle','none');
    xlim([0 10]);
    ylim([0 ylim_max(j)])
    set(gca,'xtick',[0.5:1:9.5]);
    set(gca,'xticklabel',{'Parental (FBS 0%)'   ,'GIV KO (FBS 0%)',...
                          'Parental (FBS 0.2%)' ,'GIV KO (FBS 0.2%)',...
                          'Parental (FBS 2%)'   ,'GIV KO (FBS 2%)',...
                          'Parental (FBS 5%)'   ,'GIV KO (FBS 5%)',...
                          'Parental (FBS 10%)'  ,'GIV KO (FBS 10%)'});
    ylabel(le(j));

    [h1,p1]=ttest2(wt(1,:)',giv(1,:)');
    [h2,p2]=ttest2(wt(2,:)',giv(2,:)');
    [h3,p3]=ttest2(wt(3,:)',giv(3,:)');
    [h4,p4]=ttest2(wt(4,:)',giv(4,:)');
    [h5,p5]=ttest2(wt(5,:)',giv(5,:)');
    

    [h1 h2 h3 h4 h5;p1 p2 p3 p4 p5]
    
    
%     [h6,p6]=ttest2(wt(1,:)',giv(1,:)');
%     [h7,p7]=ttest2(wt(2,:)',giv(2,:)'); 
%     [h8,p8]=ttest2(wt(3,:)',giv(3,:)'); 
%     [h9,p9]=ttest2(wt(4,:)',giv(4,:)'); 
%     [h10,p10]=ttest2(wt(5,:)',giv(5,:)'); 
%      [h1 h2 h3 h4 h5;p1 p2 p3 p4 p5]
    
end