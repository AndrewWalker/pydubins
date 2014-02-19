import os
from distutils.core import setup
from distutils.extension import Extension
try:
    from Cython.Distutils import build_ext
except:
    use_cython = False
else:
    use_cython = True

cmdclass = {}
ext_modules = []

if use_cython:
    ext_modules = [
        Extension("dubins",
            ["dubins/src/dubins.c", "dubins/dubins.pyx"],
            include_dirs = ["dubins/include"]
        )
    ]
    cmdclass.update({ 'build_ext' : build_ext })
else:
    ext_modules = [
        Extension("dubins",
            ["dubins/src/dubins.c", "dubins/dubins.c"],
            include_dirs = ["dubins/include"]
        )
    ]

def read(filename):
    path = os.path.join(os.path.dirname(__file__), filename)
    contents = open(path).read()
    return contents


setup(
    name         = "dubins",
    version      = "0.8.1",
    description  = "Code to generate and manipulate dubins curves",
    long_description = read('README.rst'),
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
    cmdclass = cmdclass,
    ext_modules  = ext_modules,
)

