function [D_CL] = CL(sample)
%Chao-Lee estimator

f = frequency(sample);
d = length(unique(sample));
n = length(sample);

%coverage
C_hat = 1-f(1)/n;

%skew parameter (gamma)
uc = unique(sample);
N = zeros(length(unique(sample)),1);

for i = 1:length(uc)
    N(i) = sum(sample == uc(i));
end

gamma = ((1/length(uc))*sum((N-mean(N)).^2))/(mean(N)^2);

%Chao Lee estimator

D_CL = d/C_hat + gamma*n*(1-C_hat)/C_hat;   %trivial bound: 
                                                     % num distinct cannot exceed  
                                                     % the dimension of database 

end



