function D_hat = zipf_algorithm (theta, r, K_sample)
% given a sample of size r which has K_sample distincts, compute D_hat
% knowing that data come from a Zipf distribution of skew parameter theta

D_hat = 0;
step = 100;         % increase of D_hat at each iteration
abs_old = inf;
p = [];
loop = true;
N = 0;
while loop 
    for s = 1:step
        p = [p 1/(D_hat + s)^theta];   % weigths 
    end
    
    N = N + sum(p(end-step+1: end));   % update normalizing constant                                   
    f = [];
    
    for i = 1:D_hat + step
        f(i) = 1-(1-1/((i^theta)*N))^r;
    end
    K = sum(f);                        % expected value of distinct
    abs_new = abs( K - K_sample);      % absolute deviation 
    
    
    if abs_new < abs_old
        abs_old = abs_new;
        D_hat = D_hat + step;          % update D_hat
    else 
        loop = false;
    end
end
    

