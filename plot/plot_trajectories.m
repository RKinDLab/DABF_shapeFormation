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
    num_colors = 7; % Number of default MATLAB colors

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

        current_color = colors(mod(i-1,num_colors) + 1,:);
        plot(x0,y0,"x",Color=current_color,LineWidth=3,MarkerSize=16)
        plot(x_end,y_end,"o",Color=current_color,LineWidth=3,MarkerSize=18)
    end
    
    legend(legend_list,"Location","Northeastoutside","Interpreter","latex")
    xlabel('X [m]')
    ylabel('Y [m]')
    % Set font size and bold for all text objects
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    axis equal
    grid on
    box on

    % Extract x and y values
    x_values = data(:, 1:2:end); % Extract columns for x (odd columns)
    y_values = data(:, 2:2:end); % Extract columns for y (even columns)

    % Find the min and max values of x and y
    x_min = min(x_values(:));
    x_max = max(x_values(:));
    y_min = min(y_values(:));
    y_max = max(y_values(:));

    % Find the range for both x and y
    range_x = x_max - x_min;
    range_y = y_max - y_min;

    % Determine the maximum range to ensure square plot
    max_range = max(range_x, range_y);

    % Calculate the center of the x and y values
    center_x = (x_min + x_max) / 2;
    center_y = (y_min + y_max) / 2;

    % Set the axis limits to ensure square aspect ratio
    xlim([center_x - max_range / 2-0.05, center_x + max_range / 2+0.05]);
    ylim([center_y - max_range / 2-0.05, center_y + max_range / 2+0.05]);% Define the step for ticks as a multiple of 0.1
    
    % Define the step for ticks as a multiple of 0.1
    tick_step = 0.1;

    % Adjust xticks and yticks based on the square plot range, ensuring ticks are a multiple of 0.1
    xticks_value = center_x - max_range / 2:tick_step:center_x + max_range / 2;
    yticks_value = center_y - max_range / 2:tick_step:center_y + max_range / 2;

    % Ensure that the tick values are multiples of 0.1
    xticks_value = round(xticks_value / tick_step) * tick_step;
    yticks_value = round(yticks_value / tick_step) * tick_step;

    % Apply the ticks to the plot
    xticks(xticks_value);
    yticks(yticks_value);
    % xtickformat('%.0f');
    % ytickformat('%.0f');
        
end
