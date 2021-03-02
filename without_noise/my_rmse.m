function [rmse,r2]=my_rmse(Y_exp,y_simu)
% rmse and r2 for measured (Y_exp) and simulated (y_simu) data.
y_simu=reshape(y_simu*ones(1,size(Y_exp,2)),1,[]);
y_obse=reshape(Y_exp,1,[]);
rmse=sqrt(mean((y_obse-y_simu).^2));
r2=1-sum((y_obse-y_simu).^2)/sum((y_obse-mean(y_obse)).^2);
end