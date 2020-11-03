import numpy as np
import matplotlib as mpl

Set_num = 1

file = open(f'./dataset_offline/P{Set_num}/train.txt', 'r')

string = file.readlines()

s = {int(s[0]): np.array([int(s[2:6]), int(s[7:10])]) for s in string}
s = {i: d[i] / 180 * np.pi for i in d}
s = {i: [np.cos(d[i][1])*np.sin(d[i][0]), np.sin(d[i][1]),
         np.cos(d[i][1])*np.cos(d[i][0])] for i in d}
print(s)
