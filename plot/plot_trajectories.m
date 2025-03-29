function plot_trajectories(data)
    num_agents = length(data(1,:))/2;
    %figure
    hold on
    
    legend_list = [];
    for i = 1:num_agents
        x = data(:,i*2-1);
        y = data(:,i*2);
        legend_list = [legend_list, "Agent: " + i];
        plot(x,y,LineWidth=3)
    end
    colors = get(gca,"ColorOrder");
    line12 = [data(end,1:2); data(end,3:4)];
    plot(line12(:,1),line12(:,2),"k",LineWidth=4)
    
    for i = 1:num_agents-2
        j = i+1;
        k = i+2;
        vi = 2*i-1:2*i;
        vj = 2*j-1:2*j;
        vk = 2*k-1:2*k;
        lineik = [data(end,vi);data(end,vk)];
        linejk = [data(end,vj);data(end,vk)];
        plot(lineik(:,1),lineik(:,2),"k",LineWidth=4)
        plot(linejk(:,1),linejk(:,2),"k",LineWidth=4)
    end
    for i = 1:num_agents
        x0 = data(1,i*2-1);
        y0 = data(1,i*2);
        x_end = data(end,i*2-1);
        y_end = data(end,i*2);
        plot(x0,y0,"x",Color=colors(i,:),LineWidth=3,MarkerSize=16)
        plot(x_end,y_end,"o",Color=colors(i,:),LineWidth=3,MarkerSize=18)
    end
    
    legend(legend_list,"Location","Northeast Outside")
    xlabel('X [m]')
    ylabel('Y [m]')
    % Set font size and bold for all text objects
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    axis equal
    grid on
    box on
    xlim([-0.1 0.4])
    ylim([-0.15 0.35])
    % xtickformat('%.0f');
    % ytickformat('%.0f');
    
end