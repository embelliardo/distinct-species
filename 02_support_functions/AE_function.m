function phi = AE_function(m,f, r, g1, g2)
% This function outputs the objective function and its derivative, that are
% going to be used for the NEWTON RAPHSON method.
% (g1 and g2 are quantities explained in the function adaptive_algorithm)

% numerator
num = g2 + m*exp((-f(1)-f(2))/m);
d_num = (1+(f(1)+2*f(2))/m)*exp((-f(1)-2*f(2))/m);

% denominator
den = g1+(f(1)+f(2))*exp((-f(1)-2*f(2))/m);
d_den = ((f(1)+2*f(2))/m)^2*exp((-f(1)-f(2))/m);

% function and derivative

phi_0 = f(1)*num/den -m +f(1)+f(2);
phi_1 = (d_num*den - d_den*num)/(den^2) -1;

phi = [phi_0 phi_1];

end


