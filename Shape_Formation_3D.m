clear; clc; close all
beep off


random_range = [-1,1];
kv = 1;

p1 = [0;0;0];
p2 = [2;0;-1];
p3 = [1;-1.5;0];
p4 = [1;1;1];
initial_p = [p1, p2, p3, p4];

p1d = [0;0;0];
p2d = [1;0;0];
p3d = [1/2;sqrt(3)/2;0];
p4d = [1/2;sqrt(3)/6;sqrt(2/3)];
pd = [p1d; p2d; p3d; p4d];

% Desired Shape
p1_des = [0;0;0];
p2_des = [0;2;0];
p3_des = [2;0;0];
p4_des = [2;2;0];
p5_des = [1;1;2];
p6_des = [4;4;4];


desired_pos = [p1_des; p2_des; p3_des; p4_des;p5_des];
initial_pos = sum(abs(random_range))*rand(size(desired_pos)) + random_range(1)*ones(size(desired_pos));

num_agents = length(desired_pos)/3;

alpha = ones(num_agents,1);
beta = ones(num_agents,1);
gamma = ones(num_agents,1);

[t, sol] = ode45(@(t,p) get_dp(t, p, desired_pos, alpha, beta, gamma), [0,15], initial_pos);
plot_figures(sol)
plot_error(t,sol,desired_pos)

% [t, sol] = ode45(@(t,p) get_dp(t, p, pd, alpha, beta, gamma),[0,15], initial_p);
% plot_figures(sol)
% plot_error(t,sol,pd)



function dp = get_dp(~, p, d, alpha, beta, gamma)

num_agents = length(p)/3;

dp = zeros(3,1);
p1 = p(1:3);
p2 = p(4:6);
p3 = p(7:9);

d1 = d(1:3);
d2 = d(4:6);
d3 = d(7:9);

sigma21 = norm(p2-p1)^2 - norm(d2-d1)^2;
dp2 = -alpha(2)*(p2-p1)*sigma21;
dp = [dp; dp2];

sigma32 = norm(p3-p2)^2 - norm(d3-d2)^2;

lamba3 = (p3-p2)'*(p2-p1)/norm(p2-p1);
psi3 = (p3-p2)'/norm(p2-p1)*((p3-p2)-(p3-p2)'*(p2-p1)/norm(p2-p1)*(p2-p1)/norm(p2-p1));

lambd3d = (d3-d2)'*(d2-d1)/norm(d2-d1);
psi3d = (d3-d2)'/norm(d2-d1)*((d3-d2)-(d3-d2)'*(d2-d1)/norm(d2-d1)*(d2-d1)/norm(d2-d1));

dp3 = - alpha(3)*(p3-p2)*sigma32 ...
      - beta(3)*(lamba3-lambd3d)*(p2-p1)/norm(p2-p1) ...
      - gamma(3)*(psi3-psi3d)*((p3-p2)-(p3-p2)'*(p2-p1)/norm(p2-p1)*(p2-p1)/norm(p2-p1))/norm(p2-p1);


dp = [dp; dp3];

for l = 4:num_agents
    k = l - 1;
    j = l - 2;
    i = l - 3;
    p_i = p(3*i-2:3*i);
    p_j = p(3*j-2:3*j);
    p_k = p(3*k-2:3*k);
    p_l = p(3*l-2:3*l);
    p_g = (p_i+p_j+p_k)/3;
    
    d_i = d(3*i-2:3*i);
    d_j = d(3*j-2:3*j);
    d_k = d(3*k-2:3*k);
    d_l = d(3*l-2:3*l);
    d_g = (d_i+d_j+d_k)/3;
    
    lambda_l = (p_l-p_k)'*cross(p_k-p_i,p_k-p_j)/norm(cross(p_k-p_i,p_k-p_j));
    psi_l = (p_l-p_i)'*(p_k-p_g)/norm(p_k-p_g);

    lambda_ld = (d_l-d_k)'*cross(d_k-d_i,d_k-d_j)/norm(cross(d_k-d_i,d_k-d_j));
    psi_ld = (d_l-d_i)'*(d_k-d_g)/norm(d_k-d_g);

    sigma_lj = norm(p_l-p_j)^2 - norm(d_l-d_j)^2;
    sigma_lk = norm(p_l-p_k)^2 - norm(d_l-d_k)^2;

    dp_l = -alpha(l)*((p_l-p_j)*sigma_lj + (p_l-p_k)*sigma_lk) ...
        - beta(l)*(lambda_l-lambda_ld)*cross(p_k-p_i,p_k-p_j)/norm(cross(p_k-p_i,p_k-p_j)) ...
        - gamma(l)*(psi_l-psi_ld)*(p_k-p_g)/norm(p_k-p_g);

    dp = [dp; dp_l];
end
end

function plot_figures(data)
    num_agents = length(data(1,:))/3;
    figure 
    hold on
    legend_list = [];
    for i = 1:num_agents
        x = data(:,i*3-2);
        y = data(:,i*3-1);
        z = data(:,i*3);
        legend_list = [legend_list, "Agent: " + i];
        plot3(x,y,z)
    end

    colors = get(gca,"ColorOrder");
    for i = 1:num_agents
        x = data(end,i*3-2);
        y = data(end,i*3-1);
        z = data(end,i*3);
        plot3(x,y,z,"*",Color=colors(i,:))
    end
    
    legend(legend_list)
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    view(3)
    axis equal
    grid on    
end

function plot_error(t, x, xd)
    num_agents = length(x(1,:))/3;
    data_points = length(t);
    figure
    hold on
    couple_list = [];
    error12 = vecnorm(x(:,1:3)-x(:,4:6),2,2) - norm(xd(1:3)-xd(4:6))*ones(data_points,1);
    plot(t, error12)
    couple_list = [couple_list, "e_1_2"];
    for i = 1:num_agents-2
        j = i+1;
        k = i+2;
        vi = 3*i-2:3*i;
        vj = 3*j-2:3*j;
        vk = 3*k-2:3*k;
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
