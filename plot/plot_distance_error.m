function h = plot_distance_error(t, x, xd, titlex)
    % xtickformat('%.0f');
    % ytickformat('%.0f');
    num_agents = length(x(1,:))/2;
    data_points = length(t);
    hold on
    
    % Initialize the handle array for plotting
    h = [];
    
    % Plot for agent pair 1-2
    error12 = vecnorm(x(:,1:2)-x(:,3:4),2,2) - norm(xd(1:2)-xd(3:4))*ones(data_points,1);
    h = [h, plot(t, error12, 'Color', 	"#0072BD",'LineWidth',2)];
    %couple_list = ["e_1_2"];

    % Loop over other agent pairs
    for i = 1:num_agents-2
        j = i+1;
        k = i+2;
        vi = 2*i-1:2*i;
        vj = 2*j-1:2*j;
        vk = 2*k-1:2*k;
        
        % Calculate and plot error for pair (i,j)
        errorij = vecnorm(x(:,vi)-x(:,vj),2,2) - norm(xd(vi)-xd(vj))*ones(data_points,1);
        h = [h, plot(t, errorij, 'LineWidth',2, 'Color', 	"#0072BD")];
        
        % Calculate and plot error for pair (i,k)
        errorik = vecnorm(x(:,vi)-x(:,vk),2,2) - norm(xd(vi)-xd(vk))*ones(data_points,1);
        h = [h, plot(t, errorik, 'LineWidth',2, 'Color', 	"#0072BD")];
        
        % Calculate and plot error for pair (j,k)
        errorjk = vecnorm(x(:,vj)-x(:,vk),2,2) - norm(xd(vj)-xd(vk))*ones(data_points,1);
        h = [h, plot(t, errorjk, 'LineWidth',2, 'Color', 	"#0072BD")];
    end

    % Customize the appearance of the plot
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    grid on
    axis square
    xlim([0 t(end)/2])
    box on
    title({titlex, ''}, "FontSize", 32, "Interpreter", "latex");

    % Return the plot handles for use in the legend
end
