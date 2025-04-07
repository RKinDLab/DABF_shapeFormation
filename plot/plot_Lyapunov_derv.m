function [h,legend_list] = plot_Lyapunov_derv(t, x, xd)
    num_agents = length(x(1,:))/2;
    data_points = length(t);
    legend_list = {};

    % Initialize the handle array for plotting
    h = [];
    hold on

    % W_1 (First agent, initialize the first plot)
    W1 = zeros(data_points, 1);  % Ensure W1 has the correct dimensions
    h = [h, plot(t, W1, 'LineWidth', 2)];  
    legend_list = [legend_list, "Agent: " + 1];

    % W_2 (Second agent, error between agents 1 and 2)
    z21 = vecnorm(x(:,1:2)-x(:,3:4),2,2) - norm(xd(1:2)-xd(3:4))*ones(data_points,1);
    z21_dot = gradient(z21,t);    
    W2 = 0.5*z21 .* z21_dot;
    h = [h, plot(t, W2, 'LineWidth', 2)];  
    legend_list = [legend_list, "Agent: " + 2];

    % Loop over remaining agents and compute Lyapunov terms
    for i = 1:num_agents-2
        j = i+1;
        k = i+2;
        vi = 2*i-1:2*i;
        vj = 2*j-1:2*j;
        vk = 2*k-1:2*k;
        
        % Calculate errors for agent pairs (i,k) and (j,k)
        zki = vecnorm(x(:,vi)-x(:,vk),2,2) - norm(xd(vi)-xd(vk))*ones(data_points,1);
        zkj = vecnorm(x(:,vj)-x(:,vk),2,2) - norm(xd(vj)-xd(vk))*ones(data_points,1);
        
        % Calculate derivatives of these errors
        zki_dot = gradient(zki,t);
        zkj_dot = gradient(zkj,t);
        
        % Calculate Lyapunov function derivative for each agent
        Wk = 0.5 * zki.* zki_dot + 0.5 * zkj .* zkj_dot;
        h = [h, plot(t, Wk, 'LineWidth', 2)];
        
        % Update legend list for each agent
        legend_list = [legend_list, "Agent: " + k];
    end

    % Customize plot appearance
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    grid on;
    ylabel({'Time Derivative of','Lyapunov Function'});
    xlabel('Time [sec]');
    axis square;
    xlim([0 t(end)/2]);
    box on;

    

    % Return the plot handles for future use (if needed)
end
