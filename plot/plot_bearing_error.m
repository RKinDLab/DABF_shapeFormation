function h = plot_bearing_error(t, x, xd)
    num_agents = length(x(1,:))/2;
    data_points = length(t);
    J = [0 1;-1 0];  % Skew-symmetric matrix for cross-product calculation
    
    

    % Initialize the handle array for plotting
    h = [];
    hold on;
    % Loop over agent pairs
    for i = 1:num_agents-2
        errorSijk = [];
        for w = 1:data_points
            j = i+1;
            k = i+2;
            vi = 2*i-1:2*i;
            vj = 2*j-1:2*j;
            vk = 2*k-1:2*k;
            
            % Compute the error for each agent pair (i, j, k)
            errorSijk(w) = (x(w, vi) - x(w, vk)) * J * (x(w, vi) - x(w, vj))' - ...
                           (xd(vi) - xd(vk)) * J * (xd(vi) - xd(vj))';
        end
        
        % Plot the error for the (i, j, k) pair
        h = [h, plot(t, errorSijk, 'LineWidth', 2, 'Color', "#A2142F")];
    end
    
    % Customize the appearance of the plot
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    grid on;
    xlim([0 t(end)/2]);
    axis square;
    box on;

    % Label formatting
    ytickformat('%.2f');
    
    % Return the plot handles for use in the legend
end
