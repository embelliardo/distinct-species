function D_HT = HT(sample, size)

d = length(unique(sample));
n = length(sample);
uc = unique(sample);

N = zeros(length(unique(sample)),1);
for i = 1:length(uc)
    N(i) = sum(sample == uc(i));
end

N_hat = (N/n)*size;

h = (1-(N/(size-n+1))).^n;

%Horovitz- Thompson estimator
D_HT = sum ((1-h).^-1);