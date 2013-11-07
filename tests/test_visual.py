import pydubins
import matplotlib.pyplot as plt
import numpy

qs = [
    (0.0, 0.0, 0.0),
    (4.0, 0.0, 0.0),
    (-4.0, 0.0, 0.0),
    (4.0, 4.0, 0.0),
    (4.0, -4.0, 0.0),
    (4.0, 4.0, numpy.pi),
    (4.0, -4.0, numpy.pi),
    (0.5, 0.0, numpy.pi),
]

def expand_axis(ax, scale, name):
    getter = getattr(ax, 'get_' + name)
    setter = getattr(ax, 'set_' + name)
    a, b = getter()
    mid = (a+b)/2.0
    diff = (b - mid)
    setter(mid - scale*diff, mid + scale*diff)

def expand_plot(ax, scale = 1.1):
    expand_axis(ax, scale, 'xlim')
    expand_axis(ax, scale, 'ylim')

def plot_dubins_path(q0, q1, r=1.0, step_size=0.1):
    qs, _ = pydubins.sample_dubins_path(q0, q1, r, step_size)
    qs = numpy.array(qs)
    xs = qs[:, 0]
    ys = qs[:, 1]
    plt.plot(xs, ys, 'b-')
    plt.plot(xs, ys, 'r.')
    ax = plt.gca()
    expand_plot(ax)
    ax.set_aspect('equal')

def plot_dubins_table(cols, rho=1.0):
    rows = ((len(qs)-1) / cols)+1
    for i in xrange(1, len(qs)):
        plt.subplot(rows, cols, i)
        plot_dubins_path(qs[0], qs[i], r = rho)
    plt.show()

def test_visual():
    plot_dubins_table(3, 1.0)





