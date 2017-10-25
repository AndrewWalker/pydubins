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
cdef class DubinsPath:
    cdef core.DubinsPath *ppth

    def __cinit__(self):
        self.ppth = <core.DubinsPath*>malloc(sizeof(core.DubinsPath))

    def __dealloc__(self):
        free(self.ppth)

    def __init__(self, q0, q1, rho):
        '''Identify which type of path is produced between configurations

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
        int
            The path type
        '''
        cdef double _q0[3]
        cdef double _q1[3]
        cdef double _rho = rho
        for i in [0, 1, 2]:
            _q0[i] = q0[i]
            _q1[i] = q1[i]
        code = core.dubins_init(_q0, _q1, _rho, self.ppth)
        if code != 0:
            raise RuntimeError('path did not initialise correctly')

    def path_length(self):
        return core.dubins_path_length(self.ppth)

    def segment_length(self, i):
        return core.dubins_segment_length(self.ppth, i)

    def segment_length_normalized(self, i):
        return core.dubins_segment_length_normalized(self.ppth, i)

    def path_type(self):
        return core.dubins_path_type(self.ppth)

    def sample(self, step_size):
        qs = []
        ts = []
        def f(q, t):
            qs.append(q)
            ts.append(t)
            return 0
        core.dubins_path_sample_many(self.ppth, callback, step_size, <void*>f)
        return qs, ts


def path_type(q0, q1, rho):
    '''Identify which type of path is produced between configurations

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
    int
        The path type
    '''
    return DubinsPath(q0, q1, rho).path_type()

def path_length(q0, q1, rho):
    '''Return the total length of a Dubins path

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
    float 
        The length of the path 
    '''
    return DubinsPath(q0, q1, rho).path_length()

def path_sample(q0, q1, rho, step_size):
    '''Sample a Dubins' path at a fixed step interval

    Parameters
    ----------
    q0 : array-like
        the initial configuration
    q1 : array-like
        the final configuration
    rho : float
        the turning radius of the vehicle
    step_size : float
        the parameter used to select sampling interval

    Raises
    ------
    RuntimeError
        If the construction of the path fails

    Returns
    -------
    tuple
        configurations and sampling parameter
    '''
    return DubinsPath(q0, q1, rho).sample(step_size)

