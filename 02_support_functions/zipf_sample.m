function [Z, mass] = zipf_sample(D,theta,n)

p=zeros(D,1);
for i = 1:D
    p(i) = 1/(i^theta);
end
N = sum(p); 
mass = p/N;
Z = randsample(D,n,true,p);



    