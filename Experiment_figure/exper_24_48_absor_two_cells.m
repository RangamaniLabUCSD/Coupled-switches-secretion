a_hela_24=...
[0.463	0.5565	0.5488	0.0478	0.0427	0.0484
0.567	0.5222	0.5097	0.2189	0.2495	0.2664
0.7297	0.703	0.7909	0.318	0.3976	0.4122
0.6649	0.7471	0.6939	0.6294	0.7196	0.562
0.7349	0.9274	0.9248	0.9088	1.0687	1.1009];

a_hela_48=...
[0.2652	0.2606	0.1875	0.0495	0.0702	0.0745
0.281	0.2651	0.2298	0.0655	0.0583	0.0613
0.4124	0.523	0.3952	0.1033	0.0881	0.1207
0.7079	0.6281	0.7079	0.2361	0.3001	0.2238
0.852	0.863	0.752	0.5168	0.6387	0.5904];


a_MDA_24=...
[0.5509	0.4769	0.3598	0.0487	0.081	0.0559
0.5692	0.5814	0.7143	0.1821	0.0512	0.0633
0.6372	0.6372	0.7744	0.3308	0.3656	0.3133
0.7297	0.6649	0.674	0.5594	0.5594	0.7991
0.8719	0.892	0.959	0.6896	0.614	0.9291];

a_MDA_48=...
[0.429	0.352	0.341	0.0512	0.0959	0.0485
0.4333	0.4994	0.4399	0.047	0.0851	0.0845
0.681	0.5868	0.6102	0.251	0.2076	0.2307
0.7231	0.6318	0.6407	0.3578	0.3123	0.22
0.7732	0.8071	0.6745	0.5688	0.5964	0.5747];

serum=[0
0.25
2
5
10];

set(0,'DefaultLineLineWidth',2);
set(0,'DefaultAxesFontSize',28,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',28,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');

% plot
var_name={'a_hela_24','a_hela_48','a_MDA_24','a_MDA_48'};
for i=1:4
    eval(['wd=', var_name{i},'(:,1:3);']);  
    eval(['giv=',var_name{i},'(:,4:6);']);
    figure;hold on;set(gcf,'unit','centimeters','position',[1,1,18,15]);
    bar(1:length(serum),mean(wd,2),0.4,'b');
    bar(1.4:(0.4+length(serum)),mean(giv,2),0.4,'r');
    errorbar(1:length(serum),mean(wd,2),  std(wd,0,2)/sqrt(3),'b','linestyle','none','linewidth',1.5,'capsize',12);
    errorbar(1.4:(0.4+length(serum)),mean(giv,2),std(giv,0,2)/sqrt(3),'r','linestyle','none','linewidth',1.5,'capsize',12);
    xlim([0.6 5.8]);ylim([0 1.2])
    ylabel('Absorbance (50 nM)');
    xlabel('Serum concentration (%)');
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