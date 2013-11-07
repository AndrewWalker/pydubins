from distutils.core import setup
from distutils.extension import Extension
try:
    from Cython.Build import cythonize
except:
    print 'Could not find cython, install it first'
    raise

extensions = [
    Extension("dubins", ["dubins/src/dubins.c", "dubins/dubins.pyx"],
        include_dirs = ["dubins/include"]
    )
]

setup(
    name         = "dubins",
    version      = "0.8",
    description  = "Code to generate and manipulate dubins curves",
    author       = "Andrew Walker",
    author_email = "walker.ab@gmail.com",
    url          = "http://github.com/AndrewWalker/pydubins",
    classifiers  = [
        'Development Status :: 4 - Beta',
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: MIT License',
        'Natural Language :: English',
        # TODO - further testing required to show which platforms
        #        will work correctly, but any changes should be
        #        fairly minor
        'Operating System :: POSIX :: Linux',
        'Topic :: Scientific/Engineering :: Mathematics',
    ],
    ext_modules  = cythonize(extensions),
)

