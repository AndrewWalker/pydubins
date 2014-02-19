About
=====

This software finds the shortest paths between configurations for the
Dubin's car, the forward only car-like vehicle with a constrained
turning radius. 

Installing
==========

You can install the latest stable version from `PyPI <http://pypi.python.org/pypi/dubins>`_

.. code-block:: console

    $ pip install dubins

Or, you can install the latest development version from `GitHub <https://github.com/AndrewWalker/pydubins>`_

.. code-block:: console

    $ pip install git+git://github.com/AndrewWalker/pydubins.git

Example
=======

Sampling of a Dubin's path at finite size sizes

.. code-block:: python

    import dubins

    q0 = (x0, y0, theta0)
    q1 = (x1, y1, theta1)
    r = turning_radius
    step_size = 0.5

    qs, _ = dubins.sample_dubins_path(q0, q1, r, step_size)



Method
======

A good description of the equations and basic strategies for doing
this are described in the book `Planning Algorithms
<http://planning.cs.uiuc.edu/node821.html>`_, by Steven LaValle


The approach adopted here is based on the algebraic solutions to the
equations published by Shkel and Lumelsky "Classification of the
Dubins set", however, rather than using the symmetry approach
described in that work, a less efficient generate and test approach is
used.

Various revisions of this code have been used in:

.. code-block:: bibtex

    @phdthesis{ Walker:2011,
        title  = "Hard Real-Time Motion Planning for Autonomous Vehicles",
        author = "Andrew Walker",
        school = "Swinburne University of Technology",
        year   = "2011"
    }

and in

.. code-block:: bibtex

    @phdthesis{ Smart:2008,
        title  = "Evolutionary Control of Autonomous Underwater Vehicles", 
        author = "Royce Smart",
        school = "RMIT",
        year   = "2008"
    }

