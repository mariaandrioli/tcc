import numpy as np
default  = np.array([1631.50, 1550.23, 1992.96, 1606.27, 1606.69, 1548.24, 1545.68, 1522.88, 1538.37, 1515.46])
tuned = np.array([807.67 ,812.86 ,814.19 ,807.50 ,813.09 ,806.06 ,806.60 ,812.37 ,813.50 ,809.55])

default_mean = np.sum(default)/10

print(default.min(), default_mean, default.max())

tuned_mean = np.sum(tuned)/10

print(tuned.min(), tuned_mean, tuned.max())