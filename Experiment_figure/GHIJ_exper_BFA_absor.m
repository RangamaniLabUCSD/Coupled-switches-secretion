function exper_BFA_absor
set(0,'DefaultLineLineWidth',0.5);
set(0,'DefaultAxesFontSize',10);
set(0,'DefaultTextFontSize',10);


num = xlsread('../Source Data/BFA absorbance.xlsx','HeLa','B2:AX63');
% E: the first three columns are WT, and the last three columns are GIV depleted.
% The third index is for serum concentration
E=zeros(8,6,5);
BFA=zeros(8,1);
s=5;
for j=1:size(num,2)
    for i=1:size(num,1)
        if ~isnan(num(i,j))
            c=diff(find(~isnan(num(i:end,j))));
            indx=find(cumsum(c) - (1:length(c))'==0) ;   
            c=diff(find(~isnan(num(i,j:end))));
            indy=find(cumsum(c) - (1:length(c))==0) ;   
            E(:,:,s)=num(i:(i+indx(end)),(j+1):(j+indy(end)));
            BFA=num(i:(i+indx(end)),j);
            num(i:(i+indx(end)),j:(j+indy(end)))=nan;   
            s=s-1;
        end
    end
end
serum=[0 0.25 2 5 10]; 
barplot(E,BFA,serum,4);ylim([0 0.8])
BFA(1)=10^-3;
plot3D(E,BFA,serum);


num = xlsread('../Source Data/BFA absorbance.xlsx','MDA MB 231','B2:AX63');
E=zeros(8,6,5);
BFA=zeros(8,1);
s=5;
for j=1:size(num,2)
    for i=1:size(num,1)
        if ~isnan(num(i,j))
            c=diff(find(~isnan(num(i:end,j))));
            indx=find(cumsum(c) - (1:length(c))'==0) ;   
            c=diff(find(~isnan(num(i,j:end))));
            indy=find(cumsum(c) - (1:length(c))==0) ;   
            E(:,:,s)=num(i:(i+indx(end)),(j+1):(j+indy(end)));
            BFA=num(i:(i+indx(end)),j);
            num(i:(i+indx(end)),j:(j+indy(end)))=nan;   
            s=s-1;
        end
    end
end
serum=[0 0.25 2 5 10]; 

BFA(1)=10^-3; 
barplot(E,BFA,serum,2);ylim([0 0.8])
plot3D(E,BFA,serum);

end



function barplot(E,BFA,serum,ind_BFA)
% bar plot
figure;hold on; set(gcf,'unit','centimeters','position',[2,2,18,12]);
ind=1;  %BFA=0, 
wt=E(ind,1:3,1);     % Wildtype   , serum=0
bar(ind,mean(wt,2),1,'b');     errorbar(1,mean(wt,2),std(wt,[],2)/sqrt(3),'color','k','linewidth',0.5,'capsize',10);
giv=E(ind,4:6,1);    % GIV-depleted, serum=0
bar(2,mean(giv,2),1,'r');    errorbar(2,mean(giv,2),std(giv,[],2)/sqrt(3),'color','k','linewidth',0.5,'capsize',10);
[h,p]=ttest2(wt,giv);  [h,p]

ind=ind_BFA; % BFA(ind_BFA)
wt=E(ind,1:3,1);   %Wildtype,      serum=0
bar(3.5,mean(wt,2),1,'b');    errorbar(3.5,mean(wt,2),std(wt,[],2)/sqrt(3),'color','k','linewidth',0.5,'capsize',10);
giv=E(ind,4:6,1);  %GIV-depleted,  serum=0
bar(4.5,mean(giv,2),1,'r');    errorbar(4.5,mean(giv,2),std(giv,[],2)/sqrt(3),'color','k','linewidth',0.5,'capsize',10);
[h,p]=ttest2(wt,giv); [h,p]

xlim([0.2 5.3]);%ylim([0 0.8])
set(gca,'xtick',[1.5 4]);
set(gca,'xticklabel',{'BFA=0',['BFA=',num2str(BFA(ind))]});
title('0 serum condition');ylabel('Absorbance');

end

function plot3D(E,BFA,serum)
% 3D plot

%lines
y=1:5; 
figure;hold on; set(gcf,'unit','centimeters','position',[2,2,15,12]);
for j=1:length(serum)
    [X,Y]=meshgrid(BFA,[y(j)-0.1,y(j)+0.1]); 

    wt=mean(E(:,1:3,j),2);  sem_wt=std(E(:,1:3,j),[],2)/sqrt(3);
   % surf(X,Y,[wt';wt'],C,'EdgeColor','b','linewidth',2);
    plot3(BFA,y(j)*ones(size(BFA)),wt,'bo-','linewidth',0.5,'markerfacecolor','b','markersize',3);
    for i=1:length(BFA)
        plot3([BFA(i)/10^(0.15),BFA(i)*10^(0.15)],[y(j) y(j)],[wt(i)+sem_wt(i),wt(i)+sem_wt(i)],'b-','linewidth',0.5);
        plot3([BFA(i)/10^(0.15),BFA(i)*10^(0.15)],[y(j) y(j)],[wt(i)-sem_wt(i),wt(i)-sem_wt(i)],'b-','linewidth',0.5);
        plot3([BFA(i),BFA(i)],[y(j) y(j)],[wt(i)-sem_wt(i),wt(i)+sem_wt(i)],'b-','linewidth',0.75);
    end

    giv=mean(E(:,4:6,j),2);  sem_giv=std(E(:,4:6,j),[],2)/sqrt(3);
   % surf(X,Y,[GIV';GIV'],C,'EdgeColor','r','linewidth',2);
    plot3(BFA,y(j)*ones(size(BFA)),giv,'ro-','linewidth',0.5,'markerfacecolor','r','markersize',3);
    for i=1:length(BFA)
        plot3([BFA(i)/10^(0.15),BFA(i)*10^(0.15)],[y(j) y(j)],[giv(i)+sem_giv(i),giv(i)+sem_giv(i)],'r-','linewidth',0.5);
        plot3([BFA(i)/10^(0.15),BFA(i)*10^(0.15)],[y(j) y(j)],[giv(i)-sem_giv(i),giv(i)-sem_giv(i)],'r-','linewidth',0.5);
        plot3([BFA(i),BFA(i)],[y(j) y(j)],[giv(i)-sem_giv(i),giv(i)+sem_giv(i)],'r-','linewidth',0.5);
    end
    
        
    [X,Y]=meshgrid([BFA(1),BFA(end)],y(j)); 
    C=zeros(2,2,3); C(:,:,1)=0.5;  C(:,:,2)=0.5;   C(:,:,3)=0.5; 
    surf([X;X],[Y;Y],[0 0 ;1.2 1.2],C,'EdgeColor','none','Facealpha',0.2);
  
end
xlabel('BFA'); ylabel('Serum'); zlabel('Absorbance');
 set(gca,'xscale','log');%set(gca,'yscale','log');
grid on;
set(gca,'xtick',10.^[(-3):2]); xlim(10.^[(-3.3) 2.3])
set(gca,'yticklabel',serum)
set(gca,'ytick',1:5);  ylim([0.5 5.5]); zlim([0 1.2])
set(gca,'xticklabel',{'0','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'})

end

