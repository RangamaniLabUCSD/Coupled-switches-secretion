% this file is used to calculate the steay-state value for the coupled switches when noise is only in the stimulus


tau(1)=0.25;tau(2)=15;tau(3)=0.35;tau(4)=0.01;tau(5)=15; tau(6)=1; tau(7)=1000;
%calculate the steady state whe stimulus=0 as the state of species for control cells under serum-starved condition
[TT,Y]=ode15s(@(t,y)f_endo(t,y,tau,0,'shControl',123),0:0.1:7000,0.5*ones(7,1));
ini=Y(end,:);

%  calculate the steay-state value for the coupled switches when noise is only in the stimulus
name='mtG_sti_con';
eval(['f_sol=@sol_SDE_',name,';']);
name_mat=['noise_mtG_sti.mat']; 
parpool(24);    % 24 works are used in the simulation 

T=24*60; %simulation time
dt=0.01; % time step size
TT=0:dt:(T+dt);
size_rescur=1000;

eps_val_all=[0 0;0.1 0;];  % the first column indicates the amplitude of input noise, and the second column the amplitude of noise in species
for ind=2
    tic
    I_all=10.^(-2:0.1:0);
    Y_end=zeros(length(I_all),8,size_rescur);
    sen=zeros(length(I_all),7);
    parfor ii=1:length(I_all)
        for j=1:size_rescur
            [TT,y_sde]=f_sol(tau,[ini,0],I_all(ii),[eps_val_all(ind,1)*I_all(ii),0],T,dt);
            Y_end(ii,:,j)=y_sde(end,:);            
        end
    end
    
    toc;
    eval(['Y',num2str(ind),'=Y_end;']);
    eval(['sen',num2str(ind),'=sen;']);
end


delete(gcp);
save ('noise_mtG_sti_1000.mat');