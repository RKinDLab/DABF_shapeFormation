clear; clc; close all

alpha = ones(3,5);
% initial_state = reshape(1:15,5,3)'/10;
initial_state = rand(3,5);
state = initial_state;
states = cell(5,1);
waypoint = [[0,1,0];[0,0,0];[0,0,1];[1,0,0];[0.5,0.5,1]]';

dt = 0.05;

for i=1:1000
    input = get_control_input(alpha,state, waypoint);
    state = state + input*dt;
    for j=1:5
        states{j}(:,i) = state(:,j);
    end
end
disp(input)


for i=1:5
    X(i,:) = states{i}(1,:);
    Y(i,:) = states{i}(2,:);
    Z(i,:) = states{i}(3,:);
end
X = X';
Y = Y';
Z = Z';
plot3(X,Y,Z)
hold on
scatter3(X(end,:), Y(end,:), Z(end, :))

% disp(X(end,:))
% disp(Y(end,:))
% disp(Z(end,:))
% disp(input)

function u = get_control_input(alpha, state, waypoint)
    n = length(alpha(1,:));
    input = zeros(3,n);
    
    q1 = state(:,1);
    q2 = state(:,2);
    q3 = state(:,3);

    d1 = waypoint(:,1);
    d2 = waypoint(:,2);
    d3 = waypoint(:,3);

    sigma21 = norm(q2-q1) - norm(d2-d1);
    sigma31 = norm(q3-q1) - norm(d3-d1);
    sigma32 = norm(q3-q2) - norm(d3-d2);

    input(:,2) = (-alpha(:,2).*((q2-q1)*sigma21));
    input(:,3) = (-alpha(:,3).*((q3-q1)*sigma31 + cross(q3-q1,q3-q2)*sigma32));
    
    for l = 4:5
        i = l-3;
        j = l-2;
        k = l-1;

        qi = state(:,i);
        qj = state(:,j);
        qk = state(:,k);
        ql = state(:,l);

        di = waypoint(:,i);
        dj = waypoint(:,j);
        dk = waypoint(:,k);
        dl = waypoint(:,l);

        
        sigmali = norm(ql-qi) - norm(dl-di);
        sigmalj = norm(ql-qj) - norm(dl-dj);
        sigmalk = norm(ql-qk) - norm(dl-dk);

        input(:,l) = (-alpha(:,l).*((ql-qi)*sigmali + (ql-qj).*sigmalj + cross(ql-qi,ql-qj).*sigmalk));
        u = input;
    end
end