import dubins
import math

q0 = (0.0, 0.0, math.pi/4)
q1 = (-4.0, 4.0, -math.pi)
turning_radius = 1.0
step_size = 0.5

qs, _ = dubins.path_sample(q0, q1, turning_radius, step_size)
print qs
