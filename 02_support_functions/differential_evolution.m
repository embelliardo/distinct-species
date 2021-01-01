function [DE, frame] = differential_evolution(sample)
n=length(sample);
u=length(unique(sample));
un=unique(sample);
for i=1:u
    s(i)=length(sample(sample==un(i)));
end

%parameters 
CR = 0.8;
F= 0.9;

%initialize 20 points
x = rand(20,2);
x(:,2)=500000*x(:,2);
frame= cell(100,1);
for k= 1:100
    for i= 1:20
        idx = [1:20];
        idx(i)=[];
        points = x(randsample(idx,3),:);
    
        for j=1:2
            r=rand(1);
            if r<CR
                y(j)=points(1,j)+F*(points(2,j)-points(3,j));
            else
                y(j)= x(i,j);
            end
        end
        if y(1)>0 && y(1)<1&& y(2)>0 &&... 
                Likelihood(n,s,u,y(1),y(2))> Likelihood(n,s,u,x(i,1),x(i,2))
            x(i,1)=y(1); x(i,2)=y(2);
        end
    end
    frame{k}= x;
end


%find best guess
for l=1:20
    L(l)=Likelihood(n,s,u,x(l,1),x(l,2));
end
[~,I]=max(L);
DE = x(I,:);
end
