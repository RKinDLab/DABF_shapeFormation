% To be completed...
function plot_Lyapunov_derv(t, x, xd)
    num_agents = length(x(1,:))/2;
    data_points = length(t);
 
    % W_2 
    z21 = vecnorm(x(:,1:2)-x(:,3:4),2,2) - norm(xd(1:2)-xd(3:4))*ones(data_points,1);
    z21_dot = gradient(z21,t);    
    W2 = 0.5*z21.*z21_dot;
    plot(t, W2, 'linewidth',2)  
    hold on

    for i = 1:num_agents-2
        j = i+1;
        k = i+2;
        vi = 2*i-1:2*i;
        vj = 2*j-1:2*j;
        vk = 2*k-1:2*k;
        zki = vecnorm(x(:,vi)-x(:,vk),2,2) - norm(xd(vi)-xd(vk))*ones(data_points,1);
        zkj = vecnorm(x(:,vj)-x(:,vk),2,2) - norm(xd(vj)-xd(vk))*ones(data_points,1);
        zki_dot = gradient(zki, t);
        zkj_dot = gradient(zkj, t);
        Wk = 0.5*zki.*zki_dot + 0.5*zkj.*zkj_dot;      
        plot(t, Wk, 'linewidth',2)
    end
 
    % t = 60;
    % Set font size and bold for all text objects
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    grid on
    ylabel({'Time Derivative of','Lyapunov Function'})
    xlabel('Time [sec]')
    axis square
    xlim([0 t(end)])
    box on
    %title({titlex,''},"FontSize",32,"Interpreter","latex")
end
