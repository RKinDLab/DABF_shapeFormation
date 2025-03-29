function plot_distance_error(t, x, xd, titlex)
    % xtickformat('%.0f');
    % ytickformat('%.0f');
    num_agents = length(x(1,:))/2;
    data_points = length(t);
    %figure
    hold on
    couple_list = [];
    error12 = vecnorm(x(:,1:2)-x(:,3:4),2,2) - norm(xd(1:2)-xd(3:4))*ones(data_points,1);
    hold on;
    plot(t, error12,'LineWidth',2)
    couple_list = [couple_list, "e_1_2"];
    for i = 1:num_agents-2
        j = i+1;
        k = i+2;
        vi = 2*i-1:2*i;
        vj = 2*j-1:2*j;
        vk = 2*k-1:2*k;
        errorij = vecnorm(x(:,vi)-x(:,vj),2,2) - norm(xd(vi)-xd(vj))*ones(data_points,1);
        % couple_list = [couple_list,"e_" + i + "_" + j];
        plot(t,errorij,'LineWidth',2,'Color',"#0072BD")
        errorik = vecnorm(x(:,vi)-x(:,vk),2,2) - norm(xd(vi)-xd(vk))*ones(data_points,1);
        plot(t,errorik,'LineWidth',2,'Color',"#0072BD")
        couple_list = [couple_list,"e_" + i + "_" + k];
        errorjk = vecnorm(x(:,vj)-x(:,vk),2,2) - norm(xd(vj)-xd(vk))*ones(data_points,1);
        plot(t,errorjk,'LineWidth',2,'Color',"#0072BD")
        couple_list = [couple_list,"e_" + j + "_" + k];
    end
    %legend(couple_list,"Location","Northeast Outside")
    %legend("\mathbf{z}_{ij}","Location","Northeast Outside")

    % Set font size and bold for all text objects
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    grid on
    %ylabel('Distance Error [m]')
    %xlabel('Time [sec]')
    axis square
    xlim([0 t(end)])
    box on
    title({titlex,''},"FontSize",32,"Interpreter","latex")
end
    %hold off;