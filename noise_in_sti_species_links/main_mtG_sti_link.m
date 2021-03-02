% this file is the similar to the main_mtG_sti_con.m in this folder 
% the only difference is that noise is in stimulus and links

tau(1)=0.25;tau(2)=15;tau(3)=0.35;tau(4)=0.01;tau(5)=15; tau(6)=1; tau(7)=1000;
[TT,Y]=ode15s(@(t,y)f_endo(t,y,tau,0,'shControl',123),0:0.1:7000,0.5*ones(7,1));
ini=Y(end,:);


name='mtG_sti_link';
eval(['f_sol=@sol_SDE_',name,';']);
name_mat=['noise_',name,'.mat']; 
parpool(24);

T=24*60;
dt=0.001; 
TT=0:dt:(T+dt);
repeat=1000;

eps_val_all=[0.01 0;0.01 0.005]; % the first column indicates the amplitude of input noise, and the second column the amplitude of noise in links
for ind=2
    tic
    I_all=10.^(-2:0.1:0);
    Y_end=zeros(length(I_all),8,repeat);
    sen=zeros(length(I_all),7);
    parfor ii=1:length(I_all)
        for j=1:repeat
            [TT,y_sde]=f_sol(tau,[ini,0],I_all(ii),eps_val_all(ind,:),T,dt);
            Y_end(ii,:,j)=y_sde(end,:);            
        end
    end
    toc;
    eval(['Y',num2str(ind),'=Y_end;']);
    eval(['sen',num2str(ind),'=sen;']);
end


delete(gcp);
save (name_mat);