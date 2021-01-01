function D_MM1 = MM1(sample, N)
% Method of Moments estimator with finite database (size= N)

d = length(unique(sample));
n = length(sample);
   
    function h = h(D,N,n)
        h = (1-((N/D)/(N-n+1)))^n;
    end
% solve numerically:
D = 1;
error_old = abs(d-D*(1-h(D,N,n)));
loop = true;
step = 10;

while loop
    error_new = abs(d-(D+step)*(1-h(D+step,N,n)));
    if error_new < error_old
       D = D + step;
       error_old = error_new;
    else
        loop = false;
    end
end

% MM1 estimator
D_MM1 = D;
end
   
