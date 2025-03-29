function u = get_u_DABF(q, d, alpha)
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
    
        uk = -alpha(k)*(J'*(qk-qj)*sigmaki+J*(qk-qi)*sigmakj);%DABF
        %uk = -alpha(k)*((qk-qi)*sigmaki+(qk-qj)*sigmakj);%DBF
    
        u = [u, uk];
    
    end
end