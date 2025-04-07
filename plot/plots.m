figure;
%% Traditional Distace Based Formation Controller
% First row: plot_output function
% subplot(3,2,1);
tiledlayout(2,3);
nexttile
plot_trajectories(sol_trad);

nexttile
% Plot Distance Error curves (group 1)
h1_1 = plot(NaN,NaN,'Color',	"#0072BD", 'LineWidth',2);
hold on;
h2_1 = plot(NaN,NaN, 'Color', "#A2142F", 'LineWidth',2);
h1 = [h1_1, plot_distance_error(t_trad, sol_trad, desired_pos, '\textbf{a) DBF Controller}')];
% Plot Bearing Error curves (group 2)
h2 = [h2_1, plot_bearing_error(t_trad, sol_trad, desired_pos)];

% Create the legend directly with the handles from the actual plots
legend([h1_1, h2_1], ...
    {"Distance Error $\mathbf{z}_{ij}$ (m)", "Bearing Error $S_{ijk}$ (rad)"}, ...
    "Location", "southeast", "Interpreter", "latex", "FontSize", 14);

ylabel('Error')  
xlabel('Time [sec]')


nexttile
[h5,legend_list] = plot_Lyapunov_derv(t_trad, sol_trad, desired_pos);
% Add the legend using the captured handles
legend(h5, legend_list, "Location", "southeast", "Interpreter", "latex", "FontSize", 14);


%% Distance Aware Bearing Controller
% subplot(3,2,2);
nexttile
plot_trajectories(sol);

% Second row: Dist Err
% subplot(3,2,3);


% subplot(3,2,4);
nexttile
% Create dummy handles for the legend (invisible)
h3_1 = plot(NaN,NaN,'Color',	"#0072BD", 'LineWidth',2);
hold on;
h4_1 = plot(NaN,NaN, 'Color', "#A2142F", 'LineWidth',2);
h3 = [h3_1,plot_distance_error(t,sol,desired_pos,'\textbf{b) DABF Controller}')];
hold on;
h4 = [h4_1,plot_bearing_error(t,sol,desired_pos)];

% Create the legend directly with the handles from the actual plots
legend([h3_1, h4_1], ...
    {"Distance Error $\mathbf{z}_{ij}$ (m)", "Bearing Error $S_{ijk}$ (rad)"}, ...
    "Location", "southeast", "Interpreter", "latex", "FontSize", 14);
ylabel('Error')  
xlabel('Time [sec]')
% Third row: Area Err
% subplot(3,2,5);

% 
% % subplot(3,2,6);
nexttile
[h6,legend_list] = plot_Lyapunov_derv(t, sol, desired_pos);
legend(h6, legend_list, "Location", "southeast", "Interpreter", "latex", "FontSize", 14);
%% add lyapunov time derivative 




