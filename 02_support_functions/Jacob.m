function J = Jacob(theta,alpha,u,n,f)

dtheta=0;
for i = 1:u-1
    dtheta = dtheta - 1/(theta+i*alpha)^2;
end
for i = 1:n-1
    dtheta = dtheta + 1/(theta + i)^2;
end
dalpha = 0;
for i = 1:u-1
    dalpha = dalpha - (i/(theta+i*alpha))^2;
end

for i= 2:n
    if f(i)~=0
        sumj=0;
        for j=1:i-1
            sumj= sumj + (1/(j -alpha))^2;
        end
        dalpha = dalpha - f(i)*sumj;
    end
end

dalphatheta = 0;

for i=1:u-1
    dalphatheta = dalphatheta - i/(i*alpha +theta)^2;
end

J = [dtheta dalphatheta; dalphatheta dalpha];
