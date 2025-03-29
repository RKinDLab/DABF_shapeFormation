figure;

% First row: plot_output function
% subplot(3,2,1);
tiledlayout(2,3);
nexttile
plot_trajectories(sol_trad);
nexttile
plot_distance_error(t_trad,sol_trad,desired_pos,'\textbf{a) DBF Controller}');
nexttile
plot_bearing_error(t_trad,sol_trad,desired_pos);
% xlabel("hi")

% subplot(3,2,2);
nexttile
plot_trajectories(sol);

% Second row: Dist Err
% subplot(3,2,3);


% subplot(3,2,4);
nexttile
plot_distance_error(t,sol,desired_pos,'\textbf{b) DABF Controller}');

% Third row: Area Err
% subplot(3,2,5);

% 
% % subplot(3,2,6);
nexttile
plot_bearing_error(t,sol,desired_pos);






