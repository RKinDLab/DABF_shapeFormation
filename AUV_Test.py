# %%
import numpy as np
import matplotlib.pyplot as plt

from AUV_Shape_Formation import ShapeFormationController

dt = 0.05
num_agents = 5
alpha = np.ones((3,num_agents))
shape_formation = ShapeFormationController(np.ones((3,num_agents)))
current_state = np.random.rand(3,num_agents)
# current_state = (np.array(range(1,16))/10).reshape((5,3)).T
state = [current_state]
waypoint = np.array([[0,1,0],[0,0,0],[0,0,1],[1,0,0],[0.5,0.5,1]]).T

for i in range(1000):
    input = shape_formation.get_control_input(current_state, waypoint)
    current_state = input*dt + current_state 
    state.append(current_state)
state = np.array(state)

fig = plt.figure()
ax = plt.axes(projection="3d")
for i in range(5):
    ax.plot3D(state[:,0,i],state[:,1,i],state[:,2,i])
    ax.scatter(state[0,0,i],state[0,1,i],state[0,2,i], c="green")
    ax.scatter(state[-1,0,i],state[-1,1,i],state[-1,2,i], c="red")
    ax.legend(["Path","Start","End"])
plt.show()
