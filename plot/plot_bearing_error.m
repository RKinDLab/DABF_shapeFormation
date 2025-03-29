function plot_bearing_error(t, x, xd)
    num_agents = length(x(1,:))/2;
    data_points = length(t);
    %figure
    J = [0 1;-1 0];
    %figure
    hold on;
    couple_list_S = [];
    for i = 1:num_agents-2
        errorSijk = [];
        for w = 1:data_points
            j = i+1;
            k = i+2;
            vi = 2*i-1:2*i;
            vj = 2*j-1:2*j;
            vk = 2*k-1:2*k;
            errorSijk(w) = (x(w,vi)-x(w,vk))*J*(x(w,vi)-x(w,vj))' - (xd(vi)-xd(vk))*J*(xd(vi)-xd(vj))';
        end
        couple_list_S = [couple_list_S,"S_{"+i+j+k+"}"];
        plot(t,errorSijk,'LineWidth',2,'Color',"#D95319")
    end
    %legend(couple_list_S,"Location","Northeast Outside")
    %legend("S_{ijk}","Location","Northeast Outside")
    %axis square
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    grid on
    xlim([0 t(end)])
    %xlabel('Time [sec]')
    %ylabel('Bearing Error [rad]')
    axis square
    box on
    
    % Set font size and bold for all text objects
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    % xtickformat('%.0f');
    ytickformat('%.2f');
    %hold off
end
    
    