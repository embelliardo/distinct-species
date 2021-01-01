function D_MM2 = MM2(sample,N)
%Method of Moment estimator with skew in the data

d = length(unique(sample));
n = length(sample);
f = frequency(sample);


%call D_MM1
D_MM1 = MM1(sample,N);

% h(N/D_MM1)
h = (1-((N/D_MM1)/(N-n+1)))^n;

%g prime
g1= 0;
for k= 1:n
    g1 = g1 + (N - N/D_MM1 -n + k)^-2;
end

% g squared
g2 = 0;
for k = 1:n
    g2 = g2 + (N - N/D_MM1 -n + k)^-1;
end
g2 = g2^2;

%gamma(D_MM1)
s= 0;
for i = 1:n
    s = s + i*(i-1)*f(i);
end
gamma = (N-1)*D_MM1*s/(N*n*(n-1))+D_MM1/N -1;

%MM2 estimator
D_MM2 = d*(1-h + 0.5*(N/D_MM1)^2*gamma^2*h*(g1-g2))^-1;


