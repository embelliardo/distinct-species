%% source support functions and estimators

addpath('../01_estimators')
addpath('../02_support_functions') 

%% create databases for different thetas:

thetas = [0 0.5 1 1.2 1.4];     %skew parameters
D = 50000;      %number of distinct values in the support of the distribution
size = 500000;  %size of the database to be generated

database = zeros(size, length(thetas));
for i = 1:length(thetas)
    database(:,i) =zipf_sample(D,thetas(i),size);
end

save('data/database.mat','database');

%% Sample from database
% draw n_samples from each database generated with different thetas
%Example: samples are 5%, 10% and 20% of the databases
  
load data/database.mat

sample_sizes = [25000 50000 100000 ]; % 5%, 10% and 20% of the db size

n_samples = 100;

for j = 1:length(thetas)
    for i = 1:n_samples
        sample(:,i,j) = randsample(database(:,j), max(sample_sizes));
    end 
end
        
%% apply estimators 
% Example: use data generated with theta = 0.5 
t=find(thetas == 0.5);

fprintf('Start computation of estimators \n')
counter = 0;
for i = 1:length(sample_sizes)
    for j = 1:n_samples
        estimators_05(i,j,1)= Shlosser(sample(1:sample_sizes(i),j,t), size);
        estimators_05(i,j,2)= MM1(sample(1:sample_sizes(i),j,t), size);
        estimators_05(i,j,3)= MM2(sample(1:sample_sizes(i),j,t), size);
        estimators_05(i,j,4)= HT(sample(1:sample_sizes(i),j,t), size);
        estimators_05(i,j,5)= Bootstrap(sample(1:sample_sizes(i),j,t));
        estimators_05(i,j,6)= CL(sample(1:sample_sizes(i),j,t));
        estimators_05(i,j,7)= sjack(sample(1:sample_sizes(i),j,t), size);
        estimators_05(i,j,8)= hybrid(sample(1:sample_sizes(i),j,t), size);
        estimators_05(i,j,9)= length(unique(sample(1:sample_sizes(i),j,t))) + ...
                        GoodToulmin(sample(1:sample_sizes(i),j,t), size);
        
        counter = counter+1;
        fprintf('progress: %.1f%% \n', counter/(length(sample_sizes)*n_samples)*100)
    end
    
end

save('data/estimators_05.mat','estimators_05')  % suffix _05 indicates data
                                                % generated from Power Law
                                                % with theta = 0.5
                                               
                                               

%% compute absolute deviation

load data/estimators_05.mat
load data/database.mat

D_true_05 = length(unique(database(:,1))); %true number of distinct values in the db

means_05 = squeeze(mean(estimators_05,2));
std_05 = squeeze(std(estimators_05,0,2));

upper_05 = means_05 +std_05;
lower_05 = means_05 -std_05;

absolute_dev_05 = 100*abs(means_05-D_true_05)/D_true_05;
table_05 = array2table(absolute_dev_05,...
    'VariableNames',{'D_Shloss','D_MM1','D_MM2','D_HT',...
    'D_Bootstrap','D_CL','D_sjack','D_hybrid','GT'},'RowNames',{'5%','10%','20%'});  


%% plots (pdf export)
string = ["Shlosser","MM1","MM2","H-T","Bootstrap","C-L","SJack","Hybrid","G-T"]

figure
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [7.5 12]);
set(gcf,'PaperOrientation','landscape');
sgtitle(" Theta = 0.5")
for i = 1:9
    subplot(3,3,i); plot([0.05 0.1 0.2],means_05(:,i), '-s', 'LineWidth', 1.2,'MarkerSize',5,...
        'MarkerFaceColor','w')
    ylim([0.5*min(min(lower_05(:,i)),D_true_05) 1.1*max(max(upper_05(:,i)),D_true_05)])
    title(string(i))
    hold on
    yline(D_true_05, 'LineWidth', 1.2,'Color','r')
    plot([0.05 0.1 0.2],lower_05(:,i),':','LineWidth', 1,'Color','k')
    plot([0.05 0.1 0.2],upper_05(:,i),':','LineWidth', 1,'Color','k')
    xlim([0.05 0.2])
    hold off
    if i ==1
        legend('Estimator','True Value','Location','best','Orientation',...
            'horizontal','Box','off')
        
       xlabel('Sample fraction')
       ylabel('Number of distincts')
    end
end

print("-fillpage","plots\estimators_05","-dpdf")
    

