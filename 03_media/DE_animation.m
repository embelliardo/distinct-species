%% differential evolution animation
loops = 100;
F(loops) = struct('cdata',[],'colormap',[]);
for j = 1:loops
    
    
    surf(alpha,theta,L,'EdgeColor','none')
    view(2)
    caxis([-0.82E5 -0.80E5])
    hold on
    plot(frame{j}(:,1),frame{j}(:,2),'.','MarkerSize',15,'Color','r')
    ylim([0 50])
    xlim([0 1])
    ylabel('theta')
    xlabel('alpha')
    title('Power Law with param = 1.4')

    F(j) = getframe(gcf);
    hold off

end

