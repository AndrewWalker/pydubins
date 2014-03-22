======
dubins
======

Overview
========

This software finds the shortest paths between configurations for the Dubins' car [Dubins51]_, the forward only car-like vehicle with a constrained turning radius. A good description of the equations and basic strategies for doing this are described in section 15.3.1 `"Dubins Curves" <http://planning.cs.uiuc.edu/node821.html>`_ of the book "Planning Algorithms" [LaValle06]_.

The approach used to find paths is based on the algebraic solutions published in [Shkel01]_. However, rather than using angular symmetries to improve performance, the simpler approach to test all possible solutions is used here. 

This code is primarily a Cython wrapper of https://github.com/AndrewWalker/Dubins-Curves

|pypi_version| |build_status|

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
    turning_radius = 1.0
    step_size = 0.5

    qs, _ = dubins.path_sample(q0, q1, turning_radius, step_size)

Contributions
=============

This work was completed as part of [Walker11]_. 

* Francis Valentinis
* Royce Smart - who tested early versions of this code while writing up [Smart08]_.

References
==========

.. [Dubins51] Dubins, L.E. (July 1957). "On Curves of Minimal Length with a Constraint on Average Curvature, and with Prescribed Initial and Terminal Positions and Tangents". American Journal of Mathematics 79 (3): 497–516
.. [LaValle06] LaValle, S. M. (2006). "Planning Algorithms". Cambridge University Press
.. [Shkel01] Shkel, A. M. and Lumelsky, V. (2001). "Classification of the Dubins set". Robotics and Autonomous Systems 34 (2001) 179–202
.. [Walker11] Walker, A. (2011). "Hard Real-Time Motion Planning for Autonomous Vehicles", PhD thesis, Swinburne University.
.. [Smart08] Royce, S. (2008). "Evolutionary Control of Autonomous Underwater Vehicles". PhD thesis, RMIT

.. |build_status| image:: https://secure.travis-ci.org/AndrewWalker/pydubins.png?branch=master
   :target: https://travis-ci.org/AndrewWalker/pydubins
   :alt: Current build status

.. |pypi_version| image:: https://pypip.in/v/dubins/badge.png
   :target: https://crate.io/packages/dubins/
   :alt: Latest PyPI version
