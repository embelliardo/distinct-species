function D_sjack = sjack(sample,N)
%Smoothed Jacknife estimator

d = length(unique(sample));
n = length(sample);
f = frequency(sample);

%D0 hat:

D0= (d-(f(1)/n))*(1-((N-n+1)*f(1))/(n*N))^-1;

%N tilda:
N_tilda = N/D0;

% g_(n-1):

g = 0;
for k = 1:n
    g = g + (N - N_tilda -(n-1) + k)^-1;
end

% gamma:

s= 0;
for i = 1:n
    s = s + i*(i-1)*f(i);
end
gamma = (N-1)*D0*s/(N*n*(n-1))+D0/N -1;

% h_n :

h = (1-(N_tilda/(N-n+1)))^n;

% sjack estimator:
D_sjack = ((1-(N-N_tilda-n+1)*f(1)/(n*N))^-1)*(d+N*h*g*gamma);

end