# Copyright (c) 2008-2014, Andrew Walker
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

    # The handle for the c- version of the path structure
    # The variables in the struct will all be accessed through the API
    # and don't need to be exposed here
    ctypedef struct DubinsPath:
        pass

    # The c-version of the initialisation function 
    cdef int dubins_init( double q0[3], double q1[3], double rho, DubinsPath* path )
    
    # Enough "glue code to make sure that the path can be sampled
    ctypedef int (*DubinsPathSamplingCallback)(double q[3], double t, void* user_data)
    int dubins_path_sample_many( DubinsPath* path, DubinsPathSamplingCallback cb, double stepSize, void* user_data )

    # Extra queries of the struct
    int dubins_path_type( DubinsPath* path )
    double dubins_path_length( DubinsPath* path )

cdef int callback(double q[3], double t, void* f):
    """This is the c- proxy callback that delegates back to Python
    """
    qn = (q[0], q[1], q[2])
    return (<object>f)(qn, t)

cdef int _dubins_init(DubinsPath* pth, object q0, object q1, object rho):
    cdef double _q0[3]
    cdef double _q1[3]
    for i in [0, 1, 2]:
        _q0[i] = q0[i]
        _q1[i] = q1[i]
    return dubins_init(_q0, _q1, rho, pth)

LSL = 0
LSR = 1
RSL = 2
RSR = 3
RLR = 4
LRL = 5

def _check_init(code):
    if code != 0:
        raise RuntimeError('path did not initialise correctly')

def path_type(q0, q1, rho):
    cdef DubinsPath pth
    code = _dubins_init(cython.address(pth), q0, q1, rho)
    _check_init(code)
    return dubins_path_type(cython.address(pth))

def path_length(q0, q1, rho):
    cdef DubinsPath pth
    code = _dubins_init(cython.address(pth), q0, q1, rho)
    _check_init(code)
    return dubins_path_length(cython.address(pth))

def path_sample(q0, q1, rho, step_size):
    cdef DubinsPath pth
    code = _dubins_init(cython.address(pth), q0, q1, rho)
    _check_init(code)
    qs = []
    ts = []
    def f(q, t):
        qs.append(q)
        ts.append(t)
        return 0
    dubins_path_sample_many(cython.address(pth), callback, step_size, <void*>f)
    return qs, ts


