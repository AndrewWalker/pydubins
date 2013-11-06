from distutils.core import setup
from distutils.extension import Extension
try:
    from Cython.Build import cythonize
except:
    print 'Could not find cython, install it first'
    raise

extensions = [
    Extension("pydubins", ["pydubins/src/dubins.c", "pydubins/pydubins.pyx"],
        include_dirs = ["pydubins/include"]
    )
]

setup(
    author       = "Andrew Walker",
    author_email = "walker.ab@gmail.com",
    url          = "http://github.com/AndrewWalker/pydubins",
    classifiers  = [
        'Development Status :: 5 - Production/Stable',
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

