# Copyright (c) 2008-2013, Andrew Walker
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
cimport cython

cdef extern from "dubins.h":
    ctypedef struct DubinsPath:
        pass
    ctypedef int (*DubinsPathSamplingCallback)(double q[3], double t, void* user_data)
    cdef int dubins_init( double q0[3], double q1[3], double rho, DubinsPath* path )
    int dubins_path_sample_many( DubinsPath* path, DubinsPathSamplingCallback cb, double stepSize, void* user_data )

cdef int callback(double q[3], double t, void* f):
    """This is the c- proxy callback that delegates back to Python
    """
    qn = (q[0], q[1], q[2])
    return (<object>f)(qn, t)

def sample_dubins_path( q0, q1, rho, step_size ):
    """Discrete sampling of a Dubin's path

    Parameters
    ----------
    q0 : array-like shape = (3,), dtype = float
        initial configuration (x0, y0, theta0)
    q1 : array-like shape = (3,), dtype = float
        final configuration (x1, y1, theta1)
    rho : float
        equivalent to turning radius (forward velocity / angular rate)
    step_size : float
        sampling interval along the path

    Notes
    -----
    theta = 0 is along the line x = 0
    """
    cdef double _q0[3]
    cdef double _q1[3]
    for i in [0, 1, 2]:
        _q0[i] = q0[i]
        _q1[i] = q1[i]
    cdef DubinsPath path
    dubins_init(_q0, _q1, rho, cython.address(path))
    qs = []
    ts = []
    def f(q, t):
        qs.append(q)
        ts.append(t)
        return 0
    dubins_path_sample_many(cython.address(path), callback, step_size, <void*>f)
    return qs, ts
