%% source support functions and estimators

addpath('../01_estimators')
addpath('../02_support_functions') 

%% define variables and load data
thetas = [0 0.5 1 1.2 1.4];
D = 50000;
size = 500000;

load data/database.mat

sample_sizes = [25000 50000 100000 ]; % 5%, 10% and 20% of db size

%% Sample from database
% draw n_samples from each database generated with different thetas

n_samples = 100;
for j = 1:length(thetas)
    for i = 1:n_samples
        sample(:,i,j) = randsample(database(:,j), max(sample_sizes));
    end 
end

%% compute PY estimators

PY = zeros(length(sample_sizes), n_samples, 5);

fprintf('Start computation of PY estimator \n')
counter = 0;
for k = 1:length(thetas)
    for i = 1:length(sample_sizes)
        for j = 1:n_samples
            PY(i,j,k)= PY_estimator(sample(1:sample_sizes(i),j,k), size);
            
            counter = counter +1; 
            fprintf('progress: %.1f%% \n', counter/(length(sample_sizes)*n_samples*length(thetas))*100)
        end
    end
end

save('data\PY_solution.mat', 'PY')

%% PY mean and std
PY_mean = squeeze(mean(PY,2));
PY_std = squeeze(std(PY,0,2));
PY_upper = PY_mean + PY_std;
PY_lower = PY_mean -PY_std;

%% load GT estimators
% create and save GT estimators running `distinct_species_estimators`, one 
% for each value of theta

load 'data\estimators_0.mat'        %theta = 0
load 'data\estimators_05.mat'       %theta = 0.5
load 'data\estimators_1.mat'        %theta = 1
load 'data\estimators_12.mat'       %theta = 1.2
load 'data\estimators_14.mat'       %theta = 1.4

%% GT mean and std
for j=1:3
    GT_mean(j,1)= mean(estimators_0(j,:,9));
    GT_mean(j,2)= mean(estimators_05(j,:,9));
    GT_mean(j,3)= mean(estimators_1(j,:,9));
    GT_mean(j,4)= mean(estimators_12(j,:,9));
    GT_mean(j,5)= mean(estimators_14(j,:,9));
end

for j=1:3
    GT_std(j,1)= std(estimators_0(j,:,9),0);
    GT_std(j,2)= std(estimators_05(j,:,9),0);
    GT_std(j,3)= std(estimators_1(j,:,9),0);
    GT_std(j,4)= std(estimators_12(j,:,9),0);
    GT_std(j,5)= std(estimators_14(j,:,9),0);
end

GT_upper = GT_mean + GT_std;
GT_lower = GT_mean -GT_std;

%% plots PY vs GT estimators (pdf export)
figure
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperType', 'A4');
set(gcf,'PaperOrientation','portrait');
for i=1:5
    D_true(i) = length(unique(database(:,i)));
end
y_limits ={[40E3 130E3], [40E3 110E3],[30E3 80E3],[15E3 35E3], [6E3 14E3]}
figure
sgtitle('Good-Toulmin vs Pitman-Yor estimates')

for i=[1 3 5 7 9]
    subplot(5,2,i); plot([0.05 0.1 0.2], GT_mean(:,(i+1)/2),'-s','LineWidth',1.2,'MarkerSize',5,...
        'MarkerFaceColor','w')
    xlim([0.05 0.2])
    ylim(y_limits{(i+1)/2})
    title(sprintf('GT, theta = %0.1f', thetas((i+1)/2)))
    hold on
    yline(D_true((i+1)/2), 'LineWidth', 1.2,'Color','r')
    plot([0.05 0.1 0.2],GT_lower(:,(i+1)/2),':','LineWidth', 1,'Color','k')
    plot([0.05 0.1 0.2],GT_upper(:,(i+1)/2),':','LineWidth', 1,'Color','k')
    
    if i == 1
        legend('Estimator','True Value')
        xlabel('Fraction of database sampled')
        ylabel('Distinct observations')
    end
    hold off
    
    subplot(5,2,i+1); plot([0.05 0.1 0.2], PY_mean(:,(i+1)/2),'-s','LineWidth',1.2,'MarkerSize',5,...
        'MarkerFaceColor','w')
    xlim([0.05 0.2])
    ylim(y_limits{(i+1)/2})

    title(sprintf('PY, theta = %0.1f', thetas((i+1)/2)))
    hold on
    plot([0.05 0.1 0.2],PY_lower(:,(i+1)/2),':','LineWidth', 1,'Color','k')
    plot([0.05 0.1 0.2],PY_upper(:,(i+1)/2),':','LineWidth', 1,'Color','k')
    yline(D_true((i+1)/2), 'LineWidth', 1.2,'Color','r')
    hold off
    
end

print("-fillpage","plots\GTvsPY","-dpdf")

    