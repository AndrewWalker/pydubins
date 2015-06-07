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



