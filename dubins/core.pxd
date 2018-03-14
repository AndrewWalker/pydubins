# Copyright (c) 2008-2018, Andrew Walker
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
    cdef int dubins_shortest_path(DubinsPath* path, double q0[3], double q1[3], double rho);
    cdef int dubins_path(DubinsPath* path, double q0[3], double q1[3], double rho, int pathType);
    
    # Enough "glue code to make sure that the path can be sampled
    ctypedef int (*DubinsPathSamplingCallback)(double q[3], double t, void* user_data)
    cdef int dubins_path_sample_many(DubinsPath* path, double stepSize, DubinsPathSamplingCallback cb, void* user_data)
    cdef int dubins_path_sample(DubinsPath* path, double t, double q[3])

    # Extra queries of the struct
    cdef int dubins_path_type(DubinsPath* path)
    cdef double dubins_path_length(DubinsPath* path)
    cdef double dubins_segment_length(DubinsPath* path, int i)
    cdef double dubins_segment_length_normalized(DubinsPath* path, int i)
    cdef int dubins_path_endpoint(DubinsPath* path, double q[3])
    cdef int dubins_extract_subpath(DubinsPath* path, double t, DubinsPath* newpath);

