% To be completed...
function plot_Lyapunov_derv
    t = 60;
    % Set font size and bold for all text objects
    allChildren = findall(gcf, 'Type', 'text');  % Find all text objects
    set(allChildren, 'FontSize', 14, 'FontWeight', 'bold');  % Set font size and weight
    set(gca, 'FontSize', 14, 'FontWeight', 'bold');  % Set axes font size and weight
    grid on
    ylabel('Time Derivative of Lyapunov Function')
    xlabel('Time [sec]')
    axis square
    xlim([0 t(end)])
    box on
    %title({titlex,''},"FontSize",32,"Interpreter","latex")
end