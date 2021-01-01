function L = Likelihood(n,s,u,alpha,theta)

L=0;
for i=1:u-1
    L=L+log(theta+i*alpha);
end
for i=0:n-2
    L=L-log(theta+1+i);
end
for i = 1:u
    for j=0:s(i)-2
        L=L+log(1-alpha+j);
    end
end
end
    