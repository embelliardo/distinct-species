 function [theta_hat , model] = par_estimator(sample)

F=zeros(max(sample),1);
for i = 1:max(sample)
    F(i)=sum(sample==i);
end
F = sort(F,'descend');   % I do not observe ordered data!

i = (1:max(sample))'; 

data =[i F];

% Remove less frequent data (improve fitting).
% I decided to remove data that are less frequent that 1% the maximum
% frequency.

data(data(:,2)<0.01*max(data(:,2)),:)=[];
data(data(:,2)==0,:) =[];
% estimate theta regressing log F(i) on log i:

X= log(data(:,1)); Y=log(data(:,2));
model = fitlm(X,Y);
theta_hat= - table2array(model.Coefficients(2,1));
