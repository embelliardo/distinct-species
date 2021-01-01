function D = PY_estimator(sample,size)
% estimator based on Pitman-Yor process

u=length(unique(sample));
n=length(sample);
m=size-n;

DE=differential_evolution(sample);  %estimate parameters of the process
alpha=DE(1); theta=DE(2);
p=zeros(m,1);
for i=0:m-1
    p(i+1) = (theta+n+alpha+i)/(theta+n+i);
end
pr = prod(p);

% PY estimator
D = u + (u+(theta/alpha))*(pr-1);
end