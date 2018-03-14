from setuptools import setup, Extension
import os
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
            include_dirs = ["dubins/include"],
        )
    ]
    cmdclass.update({ 'build_ext' : build_ext })
else:
    ext_modules = [
        Extension("dubins",
            ["dubins/src/dubins.c", "dubins/dubins.c"],
            include_dirs = ["dubins/include"],
        )
    ]

def read(filename):
    path = os.path.join(os.path.dirname(__file__), filename)
    contents = open(path).read()
    return contents


setup(
    name         = "dubins",
    version      = "1.0.1",
    description  = "Code to generate and manipulate dubins curves",
    long_description = read('README.rst'),
    author       = "Andrew Walker",
    author_email = "walker.ab@gmail.com",
    url          = "http://github.com/AndrewWalker/pydubins",
    license      = "MIT",
    classifiers  = [
        'Development Status :: 4 - Beta',
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: MIT License',
        'Natural Language :: English',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Operating System :: POSIX :: Linux',
        'Topic :: Scientific/Engineering :: Mathematics',
    ],
    cmdclass     = cmdclass,
    ext_modules  = ext_modules,
)

