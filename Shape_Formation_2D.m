clear; clc; close all
beep off


random_range = [-.2,.2];
kv = 1;

% p1 = [0;0;0];
% p2 = [2;0;-1];
% p3 = [1;-1.5;0];
% p4 = [1;1;1];
% initial_p = [p1, p2, p3, p4];
% 
% p1d = [0;0;0];
% p2d = [1;0;0];
% p3d = [1/2;sqrt(3)/2;0];
% p4d = [1/2;sqrt(3)/6;sqrt(2/3)];
% pd = [p1d; p2d; p3d; p4d];

% Desired Shape
% Shape builds counter-clockwise
q1_des = [0;0];
q2_des = [2;0];
q3_des = [2;2];
q4_des = [0;2];
q5_des = [1;1];
q6_des = [1;3];

s = .30;
pent1 = [s/2; 0];
pent2 = [s/2*cos(2*pi/5); s/2*sin(2*pi/5)];
pent3 = [s/2*cos(4*pi/5); s/2*sin(4*pi/5)];
pent4 = [s/2*cos(6*pi/5); s/2*sin(6*pi/5)];
pent5 = [s/2*cos(8*pi/5); s/2*sin(8*pi/5)];

% desired_pos = [q1_des, q2_des, q3_des, q4_des, q5_des, q6_des];
% desired_pos = [q1_des, q2_des, q3_des, q4_des];
desired_pos = [pent1, pent2, pent3, pent4, pent5];
initial_pos = sum(abs(random_range))*rand(size(desired_pos)) + random_range(1)*ones(size(desired_pos));


num_agents = max(size(initial_pos));

alpha = 5*ones(num_agents,1);

% u = dp
[t, sol] = ode45(@(t,q) ode_solver(t, q, desired_pos, alpha), [0,30], initial_pos);
plot_output(sol)
plot_error(t,sol,desired_pos)

% [t, sol] = ode45(@(t,p) get_dp(t, p, pd, alpha, beta, gamma),[0,15], initial_p);
% plot_figures(sol)
% plot_error(t,sol,pd)

function dq = ode_solver(~,q,d,alpha)
num_agents = length(q)/2;
q = reshape(q,2,num_agents);
u = get_u(q,d,alpha);
dq = reshape(u,num_agents*2,1);
end

function u = get_u(q, d, alpha)
num_agents = length(q(1,:));
J = [0,1;-1,0];

u = zeros(2,1);
q1 = q(:,1);
q2 = q(:,2);

d1 = d(:,1);
d2 = d(:,2);

sigma21 = norm(q2-q1)^2 - norm(d2-d1)^2;
u2 = -alpha(2)*(q2-q1)*sigma21;
u = [u, u2];

for k = 3:num_agents
    j = k-1;
    i = k-2;
   
    qi = q(:,i);
    qj = q(:,j);
    qk = q(:,k);
    
    di = d(:,i);
    dj = d(:,j);
    dk = d(:,k);

    sigmaki = norm(qk-qi)^2 - norm(dk-di)^2;
    sigmakj = norm(qk-qj)^2 - norm(dk-dj)^2;
    
    uk = -alpha(k)*((qk-qi)*sigmaki+J*(qk-qi)*sigmakj);
    u = [u, uk];

end
end

function plot_output(data)
    num_agents = length(data(1,:))/2;
    figure 
    hold on
    legend_list = [];
    for i = 1:num_agents
        x = data(:,i*2-1);
        y = data(:,i*2);
        legend_list = [legend_list, "Agent: " + i];
        plot(x,y,LineWidth=2)
    end

    colors = get(gca,"ColorOrder");
    for i = 1:num_agents
        x0 = data(1,i*2-1);
        y0 = data(1,i*2);
        x_end = data(end,i*2-1);
        y_end = data(end,i*2);
        plot(x0,y0,"o",Color=colors(i,:),LineWidth=2)
        plot(x_end,y_end,"x",Color=colors(i,:),LineWidth=2)
    end
    
    line12 = [data(end,1:2); data(end,3:4)];
    plot(line12(:,1),line12(:,2),"k",LineWidth=1.5)

    for i = 1:num_agents-2
        j = i+1;
        k = i+2;
        vi = 2*i-1:2*i;
        vj = 2*j-1:2*j;
        vk = 2*k-1:2*k;
        lineik = [data(end,vi);data(end,vk)];
        linejk = [data(end,vj);data(end,vk)];
        plot(lineik(:,1),lineik(:,2),"k",LineWidth=1.5)
        plot(linejk(:,1),linejk(:,2),"k",LineWidth=1.5)
    end

    legend(legend_list,"Location", "best")
    xlabel('X')
    ylabel('Y')
    axis equal
    grid on    
end

function plot_error(t, x, xd)
    num_agents = length(x(1,:))/2;
    data_points = length(t);
    figure
    hold on
    couple_list = [];
    error12 = vecnorm(x(:,1:2)-x(:,3:4),2,2) - norm(xd(1:2)-xd(3:4))*ones(data_points,1);
    plot(t, error12)
    couple_list = [couple_list, "e_1_2"];
    for i = 1:num_agents-2
        j = i+1;
        k = i+2;
        vi = 2*i-1:2*i;
        vj = 2*j-1:2*j;
        vk = 2*k-1:2*k;
        % errorij = vecnorm(x(:,vi)-x(:,vj),2,2) - norm(xd(vi)-xd(vj))*ones(data_points,1);
        % couple_list = [couple_list,"e_" + i + "_" + j];
        % plot(t,errorij)
        errorik = vecnorm(x(:,vi)-x(:,vk),2,2) - norm(xd(vi)-xd(vk))*ones(data_points,1);
        plot(t,errorik)
        couple_list = [couple_list,"e_" + i + "_" + k];
        errorjk = vecnorm(x(:,vj)-x(:,vk),2,2) - norm(xd(vj)-xd(vk))*ones(data_points,1);
        plot(t,errorjk)
        couple_list = [couple_list,"e_" + j + "_" + k];
    end 
    legend(couple_list)
end
