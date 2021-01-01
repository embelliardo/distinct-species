function D_hat = exact_count(D, theta)

% initial size of sample
dim = ceil(stop(3,theta)); 
[S, mass] = zipf_sample(D,theta,dim);

% compute distinct value of an array
    function d = distinct(x)
        d = length(unique(x));         
    end

% loop and increase sample size until condition is met
while stop(distinct(S),theta)> length(S)
    
    delta_dim = ceil(dim * (log(4)/log(3)-1));
    delta_S = randsample(D,delta_dim,true,mass);
    
    dim = dim + delta_dim;
    S = [S ; delta_S];
end

% return estimator (and the size if the sample used to compute it)
D_hat = [distinct(S) dim];

end
