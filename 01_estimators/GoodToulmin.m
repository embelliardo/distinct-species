function D_GT = GoodToulmin(sample, size)

n = length(sample);
lambda = (size - n)/n;


f = frequency(sample);

for j = 1:n
    if f(j) ~= 0
        P(j,:) = 1 - binocdf(j-1, round(0.5*log(n*lambda^2/(lambda-1))/log(3)),2/(lambda+2));
    else 
        P(j,:) = 0;    %no need to compute P(J) in this case, since it will be multiplyed by 0
    end
end

% compute the last P(j) different from zero
last = 0;
for j = 1:n
    if P(j,:) ~= 0
        last = last +1;
    else
        break
    end
end

%compute Good Toulmin estimator
D_GT = 0;
for j = 1:last
    D_GT = D_GT - (-lambda)^j*P(j)*f(j);
end