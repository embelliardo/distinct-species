function D_Boot = Bootstrap(sample)

d = length(unique(sample));
n = length(sample);
uc = unique(sample);

N = zeros(length(unique(sample)),1);
for i = 1:length(uc)
    N(i) = sum(sample == uc(i));
end

s = 0;
for i = 1:d
    s = s + (1- N(i)/n)^n;
end

D_Boot = d + s;