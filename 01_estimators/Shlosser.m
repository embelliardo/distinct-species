function D_shloss = Shlosser(sample, N)
%Shlosser estimator

f=frequency(sample);
d = length(unique(sample));
n = length(sample);
q = n/N;

sum_num = 0; sum_den = 0;
for i = 1:n
    sum_num = sum_num + f(i)*(1-q)^i;
    sum_den = sum_den + i*q*f(i)*(1-q)^(i-1);
end

%Shlosser estimator
 D_shloss = d + f(1)*sum_num/sum_den;
end
