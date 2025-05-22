
[t, sol] = ode45(@(t,q) ode_solver_DABF(t, q, desired_pos, alpha), [0,60], initial_pos);

[t_trad, sol_trad] = ode45(@(t,q) ode_solver_DBF(t, q, desired_pos, alpha), [0,60], initial_pos);


function dq = ode_solver_DBF(~,q,d,alpha)%Distance-Based Formation
    num_agents = length(q)/2;
    q = reshape(q,2,num_agents);
    u = get_u_DBF(q,d,alpha);
    dq = reshape(u,num_agents*2,1);
end

function dq = ode_solver_DABF(~,q,d,alpha)%Distance-Aware Bearing Formation
    num_agents = length(q)/2;
    q = reshape(q,2,num_agents);
    u = get_u_DABF(q,d,alpha);
    dq = reshape(u,num_agents*2,1);
end
