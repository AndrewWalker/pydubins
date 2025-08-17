from setuptools import setup, Extension
import os
from Cython.Build import cythonize

extensions = [
    Extension("dubins",
        sources=["dubins/src/dubins.c", "dubins/dubins.pyx"],
        include_dirs = ["dubins/include"],
        extra_compile_args=["-O3"],
        extra_link_args=["-O3"]
    )
]

def read(filename):
    path = os.path.join(os.path.dirname(__file__), filename)
    contents = open(path).read()
    return contents


setup(
    name         = "dubins",
    version      = "1.1.0",
    description  = "Code to generate and manipulate dubins curves",
    long_description = read('README.rst'),
    author       = "Andrew Walker",
    author_email = "walker.ab@gmail.com",
    url          = "http://github.com/AndrewWalker/pydubins",
    license      = "MIT",
    ext_modules=cythonize(extensions, compiler_directives={'language_level': 3}),
    install_requires=["cython"],
    zip_safe=False,
)

