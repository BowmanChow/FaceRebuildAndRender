import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

param = np.load('./dataset_offline/P3/z.npy')
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
x = np.kron(np.arange(168), np.ones(168))
# print(x)
y = np.kron(np.ones(168), np.arange(168))
ax.scatter(x, y, param)
plt.show()
