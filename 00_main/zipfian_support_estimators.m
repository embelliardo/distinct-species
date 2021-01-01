% This script runs the `exact_count_algorithm`, zipf_algorithm and the 
% adaptive_algoritm and returns their estimators of the support of the 
% Zipfian distribution from which the data come from 

%% source support functions and estimators

addpath('../01_estimators')
addpath('../02_support_functions') 

%% exact_count_algorithm results
% this algorithm provides the exact estimation of D. It returns the sample
% size from a Zipfian distribution needed for the algorithm to converge to 
% the exact estimation of D.

thetas = [0 0.5 1 1.2 1.4] % skew param of the Zipfian
D = 50000                  % support of the Zipfian

for i = 1:length(thetas)    
    sol(i,:) = [thetas(i) exact_count(D, thetas(i))];
end

save('data\exact_count_size.mat','sol')

%% plot exact_count results (pdf export)
load data\exact_count_size.mat sol;
figure
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [7.5 12]);
set(gcf,'PaperOrientation','landscape');
semilogy(sol(:,1), sol(:,3), '-s', 'LineWidth', 1.5,'MarkerSize',10,...
'MarkerFaceColor','w')
xlabel('\theta'); ylabel('Sample Size');
title('Exact Algorithm with D = 50000')

print("-fillpage","plots\exact_count","-dpdf")

%% zipf_algoritm results (ZE)
% returns the estimation of D from a sample of size n. Theta is known
D = 50000;
thetas = [0 0.5 1 1.2 1.4];
n = [1E+4 2E+4 5E+4 10E+4];

% for each theta, sample 100000 elements
for i = 1:length(thetas)
    sample(i,:) = zipf_sample(D, thetas(i), n(end));
end

% split the sample in increasing sub_sample of size 10000, 20000, ...
% compute distinct for each theta and each sample size

for i = 1:length(thetas)
    for j = 1:length(n)
        distinct(i,j)= length(unique(sample(i,1:n(j))));
    end
end
%%    
% apply ZE algorithm to the samples

for i = 1:length(thetas)
    for j = 1: length(n)
        tic
        sol2(i,j) = zipf_algorithm(thetas(i), n(j), distinct(i,j))
        toc
    end
        
end

save('data/zipf_solution.mat','sol2');

%% zipf_algorithm with estimated parameter theta (ZE2)
% returns the estimation of D from a sample of size n. 
% Theta is unknown and estimated.

%estimate parameter theta
for i = 1:length(thetas)
    for j = 1: length(n)
        theta_hat(i,j) = par_estimator(sample(i,1:n(j)))
    end
end

%% apply ZE2 algorithm to the samples

for i = 1:length(thetas)
    for j = 1: length(n)
        tic
        sol2_theta_hat(i,j) = zipf_algorithm(theta_hat(i,j), n(j), distinct(i,j))
        toc
    end
        
end

save('data\zipf_solution_theta_hat.mat','sol2_theta_hat');

%% Adaptive algorithm (AE)
% return the estimation of D

for i = 1:length(thetas)
    for j = 1: length(n)
        sol3(i,j) = adaptive_algorithm(sample(i,1:n(j)))
    end
end

save ('data\AE_solution.mat', 'sol3');

%% ratio error of ZE and AE algorithms
D = 50000;
thetas = [0 0.5 1 1.2 1.4];
n = [1E+4 2E+4 5E+4 10E+4];

load data\zipf_solution.mat sol2;
load data\AE_solution.mat sol3;
load data\zipf_solution_theta_hat.mat sol2_theta_hat;

for i = 1:length(thetas)
    for j = 1:length(n)
        ZE_error(i,j) = max(sol2(i,j)/D, D/sol2(i,j));
        AE_error(i,j) = max(sol3(i,j)/D, D/sol3(i,j));
        ZE2_error(i,j)= max(sol2_theta_hat(i,j)/D, D/sol2_theta_hat(i,j));
    end
end

%% plot AE and ZE results (pdf export)

figure
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [20 20]);
set(gcf,'PaperOrientation','portrait');
for i = 1: length(thetas)
    subplot(3,2,i); plot(n,ZE_error(i,:), '-s', 'LineWidth', 1.2,'MarkerSize',5,...
        'MarkerFaceColor','w')
    
    ylim([0,10])
    xlim([1E4, 1E5])
    str = sprintf('Theta = %g, D = 50000', thetas(i));
    title(str)
    if i==1
        xlabel('Sample size')
        ylabel('Ratio error')
    end
    hold on
    plot(n,AE_error(i,:), ':s','LineWidth', 1.2,'MarkerSize',5,...
        'MarkerFaceColor','w')
    plot(n,ZE2_error(i,:), '--s','LineWidth', 1.2,'MarkerSize',5,...
        'MarkerFaceColor','w')
    if i == 1
        legend('ZE','AE',"ZE2")
    end
    
    hold off
end

print("-fillpage","plots\ZAvsZE","-dpdf")
    