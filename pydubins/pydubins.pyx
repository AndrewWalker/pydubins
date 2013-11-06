cimport cython

cdef extern from "dubins.h":
    ctypedef struct DubinsPath:
        pass
    ctypedef int (*DubinsPathSamplingCallback)(double q[3], double t, void* user_data)
    cdef int dubins_init( double q0[3], double q1[3], double rho, DubinsPath* path )
    int dubins_path_sample_many( DubinsPath* path, DubinsPathSamplingCallback cb, double stepSize, void* user_data )

cdef int callback(double q[3], double t, void* f):
    qn = (q[0], q[1], q[2])
    return (<object>f)(qn, t)

def sample_dubins_path( q0, q1, rho, step_size ):
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
