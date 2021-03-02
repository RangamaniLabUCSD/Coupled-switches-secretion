% this file is the similar to the main_mG_sti_con.m in the folder "noise_in_stimulus"
% the amplitude of noise in species is not zero
tau(1)=0.25;tau(2)=15;tau(3)=0.35;
[TT,Y]=ode15s(@(t,y)f_mG(t,y,tau(1:3),0),0:0.1:7000,0.5*ones(3,1));
ini=Y(end,:);

name='mG_sti_con';
eval(['f_sol=@sol_SDE_',name,';']);
name_mat=['noise_',name,'.mat']; 
parpool(24);

T=24*60; dt=0.001;  TT=0:dt:(T+dt);
repeat=1000;

eps_val_all=[0.01 0;0.01 0.005];% the first column indicates the amplitude of input noise, and the second column the amplitude of noise in species    
for ind=[1  2]
    tic
    I_all=10.^(-2:0.1:0);
    Y_end=zeros(length(I_all),4,repeat);
    sen=zeros(length(I_all),3);
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