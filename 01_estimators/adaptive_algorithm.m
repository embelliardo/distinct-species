function D_hat = adaptive_algorithm(sample)

d = length(unique(sample));
r = length(sample);

%compute frequencies of distinct values
f = frequency(sample);

% solve the objective function ( AE_function) using NEWTON RAPHSON
m = f(1)+ f(2);     % initial guess

g1 = 0; g2 = 0;
for j = 3:r
    g1 = g1 + j*exp(-j)*f(j);
    g2 = g2 + exp(-j)*f(j);
end

delta = inf;
while delta > 10
    phi = AE_function(m, f, r, g1, g2);
    m_new = m - phi(1)/phi(2);
    
    delta = abs( m_new - m);
    m = m_new;
end

D_hat = d + m - f(1) - f(2);
    
end






        
        
        
        
  
        
        
