function Stop = stop(t,theta)

p=zeros(t+1,1);
for i = 1:t+1
    p(i) = 1/(i^theta);
end
N = sum(p); p_last = p(end)/N;

Stop = 6*log(t+1)/p_last;