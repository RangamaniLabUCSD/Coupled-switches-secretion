% this file is used to calculate the steay-state value for the coupled switches at 24h when noise is only in the stimulus

tau(1)=0.25;tau(2)=15;tau(3)=0.35;tau(4)=0.01;tau(5)=15; tau(6)=1;  tau(7)=1; tau(8)=1;

name='mtG_sti';
eval(['f_sol=@sol_SDE_',name,';']);
name_mat=['noise_mtG_sti.mat']; 
parpool(24);    % 24 works are used in the simulation 

T=60*24; %simulation time
dt=0.01; % time step size
TT=0:dt:(T+dt);
size_rescur=1000;

% each row of eps_val_all is (amplitude of input noise, amplitude of noise from other source)
eps_val_all=[0 0;0.02 0.02]; 
for ind=2
    tic
    I_all=10.^(-2:0.1:0); 
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
save ('noise_mtG_sti_1000.mat');



% figure;
% subplot(2,4,1);plot(I_all, Y2(:,[1 3]));set(gca,'xscale','log')
% subplot(2,4,2);plot(Y2(:,1), Y2(:,3));
% subplot(2,4,3);plot(I_all, Y2(:,5));set(gca,'xscale','log')
% subplot(2,4,4);plot(Y2(:,4), Y2(:,5));
% subplot(2,4,5);plot(I_all, Y2(:,7));set(gca,'xscale','log')
% subplot(2,4,6);plot(Y2(:,5), Y2(:,7));
% subplot(2,4,7);plot(I_all, Y2(:,8));set(gca,'xscale','log')