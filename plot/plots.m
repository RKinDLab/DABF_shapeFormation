figure;
%% Traditional Distace Based Formation Controller
% First row: plot_output function
% subplot(3,2,1);
tiledlayout(2,3);
nexttile
plot_trajectories(sol_trad);
nexttile
% Create dummy handles for the legend (invisible)
h1 = plot(NaN, NaN, 'Color', '#0072BD','LineWidth',2);  % Dummy line for Group 1
hold on;
h2 = plot(NaN, NaN, 'Color', '#D95319','LineWidth',2);  % Dummy line for Group 2

plot_distance_error(t_trad,sol_trad,desired_pos,'\textbf{a) DBF Controller}');
plot_bearing_error(t_trad,sol_trad,desired_pos);
hold off

% Add legend with group names
legend(["Distance Error $\mathbf{z}_{ij}$ (m)","Bearing Error $S_{ijk}$ (rad)"],"Location","southeast","Interpreter","latex","FontSize",14)
ylabel('Error')  
xlabel('Time [sec]')


nexttile
plot_Lyapunov_derv()


%% Distance Aware Bearing Controller
% subplot(3,2,2);
nexttile
plot_trajectories(sol);

% Second row: Dist Err
% subplot(3,2,3);


% subplot(3,2,4);
nexttile
% Create dummy handles for the legend (invisible)
h3 = plot(NaN, NaN, 'Color', '#0072BD','LineWidth',2);  % Dummy line for Group 1
hold on;
h4 = plot(NaN, NaN, 'Color', '#D95319','LineWidth',2);  % Dummy line for Group 2
plot_distance_error(t,sol,desired_pos,'\textbf{b) DABF Controller}');
plot_bearing_error(t,sol,desired_pos);
hold off;
% Add legend with group names
legend(["Distance Error $\mathbf{z}_{ij}$ (m)","Bearing Error $S_{ijk}$ (rad)"],"Location","southeast","Interpreter","latex","FontSize",14)% Set font size and bold for all text objects
ylabel('Error')  
xlabel('Time [sec]')
% Third row: Area Err
% subplot(3,2,5);

% 
% % subplot(3,2,6);
nexttile
plot_Lyapunov_derv()
%% add lyapunov time derivative 




