function f = frequency (sample)
% compute the number of types with a certain frequency i in the sample

d = unique(sample);

for j = 1:length(d)
    c(j) = sum( sample == d(j));
end

uc = unique(c);
f = zeros(size(sample));
for i = 1: length(uc)
    f(uc(i)) = sum( c == uc(i));
end

end



