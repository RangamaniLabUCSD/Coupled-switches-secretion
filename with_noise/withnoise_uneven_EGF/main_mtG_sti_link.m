% this file is used to calculate the steay-state value for the coupled switches when noise is only in the stimulus


tau(1)=0.25;tau(2)=15;tau(3)=0.35;tau(4)=0.01;tau(5)=15; tau(6)=1; tau(7)=10; tau(8)=1;

name='mtG_sti_link';
eval(['f_sol=@sol_SDE_',name,';']);
name_mat=['noise_mtG_sti.mat']; 
parpool(24);    % 24 works are used in the simulation 

T=24*60; %simulation time
dt=0.01; % time step size
TT=0:dt:(T+dt);
size_rescur=1000;

eps_val_all=[0 0;0.02 0.02;];  % the first column indicates the amplitude of input noise, and the second column the amplitude of noise in species
for ind=2
    tic
    I_all=[0 0.1 1 10 25 50 100]/50*0.23;  tau(7)=5000;tau(8)=200; 
    Y_end=zeros(length(I_all),length(tau),size_rescur);
    sen=zeros(length(I_all),7);
    parfor ii=1:length(I_all)
        [TT,Y]=ode15s(@(t,y)f_endo(t,y,tau,I_all(ii),'shControl',123),0:0.1:60*24*70,[0.5*ones(6,1);0.5;1e-3]);
        ini=Y(end,:);
        for j=1:size_rescur
            [TT,y_sde]=f_sol(tau,ini,I_all(ii),[eps_val_all(ind,:)],T,dt);
            Y_end(ii,:,j)=y_sde(end,:);            
        end
    end
    
    toc;
    eval(['Y',num2str(ind),'=Y_end;']);
    eval(['sen',num2str(ind),'=sen;']);
end


delete(gcp);
save ('noise_mtG_sti_link_1000.mat');