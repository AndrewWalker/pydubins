from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

extensions = [
    Extension("pydubins", ["pydubins/src/dubins.c", "pydubins/pydubins.pyx"],
        include_dirs = ["pydubins/include"]
    )
]

setup(
    ext_modules = cythonize(extensions)
)

