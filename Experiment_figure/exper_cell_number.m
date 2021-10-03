Hela_24h=[36.99823	39.99353	40.65744	94.74032	96.00449	95.6036
         22.84665	43.69204	44.88538	75.91329	76.65388	75.80162
         0.7075793	24.19668	14.47881	65.0088  	62.79592	62.55791
         9.525105	19.44145	24.96756	30.74384	32.66586	48.95086
          0	          0	              0	      0	        0	         0];
Hela_48h=[  68.87323944	69.80301275	75.06648936	90.42182663	89.00892438	87.38143631
            67.01877934	69.2815759	69.44148936	87.32585139	90.87208392	89.61720867
            51.59624413	39.39745075	47.44680851	80.01160991	86.20635666	79.55623306
            16.91314554	27.21900348	5.864361702	54.31501548	53.01393455	62.09349593
            0	0	0	0	0	0];


I=[0 0.25 2 5 10];
wd=Hela_24h((1:3),1:3);  giv=Hela_24h((1:3),4:6);
figure;errorbar((1:3),100-mean(wd,2),std(wd,0,2)/sqrt(3),'ob-','linewidth',1.5);
hold on;errorbar((1:3),100-mean(giv,2),std(giv,0,2)/sqrt(3),'or-','linewidth',1.5);
ylim([0 100]);%xlim([0.20 12])
ylabel('1-cell death (%)');xlabel('Serum concentration (%)');set(gca,'xtick',1:3,'xticklabel',I(1:3));
legend('Parental','GIV KO');%set(gca,'xscale','log')

wd=Hela_48h((1:3),1:3);  giv=Hela_48h((1:3),4:6);
figure;errorbar((1:3),100-mean(wd,2),std(wd,0,2)/sqrt(3),'ob-','linewidth',1.5);
hold on;errorbar((1:3),100-mean(giv,2),std(giv,0,2)/sqrt(3),'or-','linewidth',1.5);
ylim([0 100]);%xlim([0.20 12])
ylabel('1-cell death (%)');xlabel('Serum concentration (%)');set(gca,'xtick',1:3,'xticklabel',I(1:3));
legend('Parental','GIV KO');%set(gca,'xscale','log')