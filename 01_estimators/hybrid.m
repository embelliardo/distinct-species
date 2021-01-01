function D_hybrid = hybrid(sample,N)

d = length(unique(sample));
n = length(sample);
n_bar = n/d;

uc = unique(sample);
n_j = zeros(length(unique(sample)),1);
for i = 1:length(uc)
    n_j(i) = sum(sample == uc(i));
end

u = 0;
for i = 1:d
    u = u + ((n_j(i)-n_bar)^2)/n_bar;
end

alpha = 0.975;
x_alpha = chi2inv(alpha,n-1);

% Hybrid estimator
if u < x_alpha
    D_hybrid = sjack(sample,N);
else
    D_hybrid = Shlosser(sample,N);
end


