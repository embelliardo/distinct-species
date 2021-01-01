function W = GEM(rho,theta)
truncation = 500000;
V0=1;
W = zeros(truncation,1);
for i=1:truncation -1
    V(i)=betarnd(1-rho,theta+i*rho);
    W(i)=V(i)*V0;
    V0= V0-W(i);
end 
W(truncation)= V0;  %last weight is the remaining part of the stick
                    % FIXED TRUNCATION