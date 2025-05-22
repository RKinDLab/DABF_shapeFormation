% include directories
addpath(fullfile(pwd, 'util'));
addpath(fullfile(pwd, 'plot'));

% setup desired framework
radius = 0.3/2;
num_agents = 5;
desired_pos = desiredShapeCoordinate(num_agents,radius);

% initial condition of agents
% For results used in paper:
initial_pos = [0.078506534833198,0.010161761543734,0.144455924557333,-0.042617455513893,0.096503177381683;-0.162471989290054,0.012137687357145,-0.006058666579159,0.068572455869610,0.008020986956155];

% For randomly selected initial conditions within a square centered at the origin
% initial_radius = 0.1;
%initial_pos = (rand(num_agents,2) - ones(num_agents,2)*0.5)*initial_radius;

% define control gains
alpha = 10*ones(num_agents,1);
