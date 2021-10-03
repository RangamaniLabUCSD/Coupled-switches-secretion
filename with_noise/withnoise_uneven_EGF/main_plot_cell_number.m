%% load data for coupled switches
%load('noise_mtG_sti_1000');    
%load('noise_mtG_sti_spec_1000');  
load('noise_mtG_sti_link_1000');  
y_mtG=Y2;  std_mtG=std(y_mtG,0,3); me_mtG=mean(y_mtG,3);


  


%load data for the single switch 
%load('noise_mG_sti_1000');    
%load('noise_mG_sti_spec_1000'); 
load('noise_mG_sti_link_1000');    
y_mG=Y2;  std_mG=std(y_mG,0,3); me_mG=mean(y_mG,3); 




le='legend([h1,h2,h3,h4],'' sti'',''sti and link'',''sti and species'',''fitting curve'');';

%% line plot for secretion
set(0,'DefaultLineLineWidth',0.5);
set(0,'DefaultAxesFontSize',28,'DefaultAxesFontWeight','bold','DefaultAxesFontName','Arial');
set(0,'DefaultTextFontSize',28,'DefaultTextFontWeight','bold','DefaultTextFontName','Arial');

figure;hold on; set(gcf,'unit','centimeters','position',[1,1,35,25]);

subplot(2,2,1);hold on; % secretion versus EGF (coupled and uncoupled switches)
x=0:(length(I_all)-1);  y=me_mtG(:,end-1); z=std_mtG(:,end-1); 
errorbar(x,y,z,'o-b','linewidth',0.5,'markersize',5,'markerfacecolor','b','capsize',10);  
y=me_mG(:,end-1);  z=std_mG(:,end-1); 
errorbar(x,y,z,'o-r','linewidth',0.5,'markersize',5,'markerfacecolor','r','capsize',10);   

set(gca,'ytick',0:0.2:1,'yticklabel',0:0.2:1)
xlabel('Stimulus (fraction of max)'); ylabel(['Secretion']);
legend('Coupled','Uncoupled');


subplot(2,2,2);hold on; % cell number versus EGF (coupled and uncoupled switches)
x=0:(length(I_all)-1);  y=me_mtG(:,end); z=std_mtG(:,end); 
errorbar(x,y,z,'o-b','linewidth',0.5,'markersize',5,'markerfacecolor','b','capsize',10);  
y=me_mG(:,end);  z=std_mG(:,end); 
errorbar(x,y,z,'o-r','linewidth',0.5,'markersize',5,'markerfacecolor','r','capsize',10);   

set(gca,'ytick',(0:0.2:1)*1e-3);ylim([0 1e-3])
xlabel('Stimulus (fraction of max)'); ylabel(['Cell number']);
legend('Coupled','Uncoupled');

%% bar plot for cell number
subplot(2,2,3);hold on;

ind1=4;
ind2=1;

y1=me_mtG;   z1=std_mtG; 
h0=bar(1,y1(ind1,8),0.8,'b');     errorbar(1,y1(ind1,8),z1(ind1,8),'k','capSize',10,'linewidth',0.5);
h1=bar(4,y1(ind2,8),0.8,'b');     errorbar(4,y1(ind2,8),z1(ind2,8),'k','capSize',10,'linewidth',0.5);


y1=me_mG;    z1=std_mG; 
h0=bar(2,y1(ind1,5),0.8,'r');     errorbar(2,y1(ind1,5),z1(ind1,5),'k','capSize',10,'linewidth',0.5);
h2=bar(5,y1(ind2,5),0.8,'r');     errorbar(5,y1(ind2,5),z1(ind2,5),'k','capSize',10,'linewidth',0.5);



[h,p]=ttest2(y_mtG(ind1,8,:),y_mG(ind1,5,:));[h p]
[h,p]=ttest2(y_mtG(ind2,8,:),y_mG(ind2,5,:));[h p]

set(gca,'ytick',(0:0.2:1)*1e-3)
ylabel(['Cell number']);xlabel('Stimulus')
legend([h1,h2],'Coupled','Uncoupled');
ylim([0 1e-3])

[I_all(ind1),  I_all(ind2)]