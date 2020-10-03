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
cimport core
from libc.stdlib cimport malloc, free


cdef inline int callback(double q[3], double t, void* f):
    '''Internal c-callback to convert values back to python
    '''
    qn = (q[0], q[1], q[2])
    return (<object>f)(qn, t)

LSL = 0
LSR = 1
RSL = 2
RSR = 3
RLR = 4
LRL = 5


# Extension point for pure python classes
cdef class _DubinsPath:
    cdef core.DubinsPath *ppth

    def __cinit__(self):
        self.ppth = <core.DubinsPath*>malloc(sizeof(core.DubinsPath))

    def __dealloc__(self):
        free(self.ppth)

    @staticmethod
    def shortest_path(q0, q1, rho):
        cdef double _q0[3]
        cdef double _q1[3]
        cdef double _rho = rho
        for i in [0, 1, 2]:
            _q0[i] = q0[i]
            _q1[i] = q1[i]

        path = _DubinsPath()
        code = core.dubins_shortest_path(path.ppth, _q0, _q1, _rho)
        if code != 0:
            raise RuntimeError('path did not initialise correctly')
        return path

    @staticmethod
    def path(q0, q1, rho, word):
        cdef double _q0[3]
        cdef double _q1[3]
        cdef double _rho = rho
        for i in [0, 1, 2]:
            _q0[i] = q0[i]
            _q1[i] = q1[i]
        path = _DubinsPath()
        code = core.dubins_path(path.ppth, _q0, _q1, _rho, word)
        if code != 0:
            return None
        return path

    def path_endpoint(self):
        cdef double _q0[3]
        code = core.dubins_path_endpoint(self.ppth, _q0)
        if code != 0:
            raise RuntimeError('endpoint not found')
        return (_q0[0], _q0[1], _q0[2])

    def path_length(self):
        '''Identify the total length of the path
        '''
        return core.dubins_path_length(self.ppth)

    def segment_length(self, i): 
        '''Identify the length of the i-th segment within the path
        '''
        return core.dubins_segment_length(self.ppth, i)

    def segment_length_normalized(self, i): 
        '''Identify the normalized length of the i-th segment within the path
        '''
        return core.dubins_segment_length_normalized(self.ppth, i)

    def path_type(self):
        '''Identify the type of path which applies 
        '''
        return core.dubins_path_type(self.ppth)

    def sample(self, t):
        '''Sample the path
        '''
        cdef double _q0[3]
        code = core.dubins_path_sample(self.ppth, t, _q0)
        if code != 0:
            raise RuntimeError('sample not found')
        return (_q0[0], _q0[1], _q0[2])

    def sample_many(self, step_size):
        '''Sample the entire path
        '''
        qs = []
        ts = []
        def f(q, t):
            qs.append(q)
            ts.append(t)
            return 0
        core.dubins_path_sample_many(self.ppth, step_size, callback, <void*>f)
        return qs, ts

    def extract_subpath(self, t):
        '''Extract a subpath
        '''
        newpath = _DubinsPath()
        code = core.dubins_extract_subpath(self.ppth, t, newpath.ppth)
        if code != 0:
            raise RuntimeError('invalid subpath')
        return newpath


def path_sample(q0, q1, rho, step_size):
    '''Generate points along a Dubin's path sampled at a regular interval 

    Parameters
    ----------
    q0 : array-like
        the initial configuration
    q1 : array-like
        the final configuration
    rho : float
        the turning radius of the vehicle
    step_size : float
        the distance along the path to sample 

    Raises
    ------
    RuntimeError
        If the construction of the path fails

    Returns
    -------
    result : tuple of two lists
        The first element are sampled configurations, the second are distances
    '''
    path = _DubinsPath.shortest_path(q0, q1, rho) 
    return path.sample_many(step_size)


def shortest_path(q0, q1, rho):
    '''Shortest path between dubins configurations

    Parameters
    ----------
    q0 : array-like
        the initial configuration
    q1 : array-like
        the final configuration
    rho : float
        the turning radius of the vehicle

    Raises
    ------
    RuntimeError
        If the construction of the path fails

    Returns
    -------
    path : DubinsPath 
        The shortest path
    '''
    return _DubinsPath.shortest_path(q0, q1, rho) 
 

def path(q0, q1, rho, word):
    '''Find the Dubin's path for one specific word

    Parameters
    ----------
    q0 : array-like
        the initial configuration
    q1 : array-like
        the final configuration
    rho : float
        the turning radius of the vehicle
    word : int
        the control word (LSL, LSR, ...)

    Raises
    ------
    RuntimeError
        If the construction of the path fails

    Returns
    -------
    path : _DubinsPath 
        The path with the specified word (if one exists) or None
    '''
    return _DubinsPath.path(q0, q1, rho, word) 

def norm_path(alpha, beta, delta, word):
    '''Find the Dubin's path for one specific word assuming a normalized (alpha, beta, delta) frame

    Parameters
    ----------
    alpha : float
        the initial orientation 
    beta : flaot
        the final orientation
    delta : float
        the distance between configurations
    word : int
        the control word (LSL, LSR, ...)

    Raises
    ------
    RuntimeError
        If the construction of the path fails

    Returns
    -------
    path : DubinsPath 
        The path with the specified word (if one exists) or None
    '''
    q0 = [ 0.0, 0.0, alpha ]
    q1 = [ delta, 0.0, beta ]
    return path(q0, q1, 1.0, word)


