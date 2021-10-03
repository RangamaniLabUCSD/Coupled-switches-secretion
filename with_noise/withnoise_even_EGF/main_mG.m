% this file is used to calculate the steay-state value for the single switch at 24h when noise is only in the stimulus

tau(1)=0.25;tau(2)=15;tau(3)=0.35; tau(4)=1; tau(5)=1;

name='mG_sti';
eval(['f_sol=@sol_SDE_',name,';']);
name_mat=['noise_mG_sti.mat']; 
parpool(24);    % 24 works are used in the simulation 

T=24*60;  %simulation time
dt=0.01;  % time step size
TT=0:dt:(T+dt);
size_recur=1000;

% each row of eps_val_all is (amplitude of input noise, amplitude of noise from other source)
eps_val_all=[0 0;0.02 0.02]; 
for ind=2
    tic
    I_all=10.^(-2:0.1:0); 
    Y_end=zeros(length(I_all),length(tau),size_recur);
    sen=zeros(length(I_all),3);   
    parfor ii=1:length(I_all)
        [TT,Y]=ode15s(@(t,y)f_mG(t,y,tau,I_all(ii)),0:0.1:60*24*70,[0.5*ones(3,1);0.5;1e-3]);
        ini=Y(end,:);
        for j=1:size_recur
            [TT,y_sde]=f_sol(tau,ini,I_all(ii),[eps_val_all(ind,:)],T,dt);
            Y_end(ii,:,j)=y_sde(end,:);            
        end
    end
    toc;
    eval(['Y',num2str(ind),'=Y_end;']);
    eval(['sen',num2str(ind),'=sen;']);
end

delete(gcp);
save ('noise_mG_sti_1000.mat');


% figure;
% subplot(2,4,1);plot(I_all, Y2(:,[1 3])); set(gca,'xscale','log')
% subplot(2,4,2);plot(Y2(:,1), Y2(:,3));
% subplot(2,4,3);
% subplot(2,4,4);
% subplot(2,4,5);plot(I_all, Y2(:,4));
% subplot(2,4,6);
% subplot(2,4,7);plot(I_all, Y2(:,5));