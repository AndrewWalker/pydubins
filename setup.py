from setuptools import setup, Extension
from Cython.Build import cythonize
import os

extensions = [
    Extension(
        "dubins",
        ["dubins/src/dubins.c", "dubins/dubins.pyx"],
        include_dirs = ["dubins/include", "dubins/core.pxd"]
    )
]

def read(filename):
    path = os.path.join(os.path.dirname(__file__), filename)
    contents = open(path).read()
    return contents


setup(
    name         = "dubins",
    version      = "1.1.1",
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
    ext_modules  = cythonize(extensions),
)
