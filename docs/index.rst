.. dubins documentation master file, created by
   sphinx-quickstart on Sat Jun  6 16:07:35 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

dubins
======

This software finds the shortest paths, and related information,
between configurations for the Dubins' car - a vehicle model that
describes a kinematic two-dimensional model of a car that can only
drive forward, or turn with a bounded turning radius.  

The Dubins' car was originally described L. E. Dubins in [Dubins57]_,
and is important tool for demonstrating concepts in robotics including
path planning subject to non-holonomic constraints.

The method used to find paths is based on the algebraic solutions
published in [Shkel01]_. However, rather than using angular symmetries
to improve performance, the simpler approach of testing all candidate
solutions is used here. 

Contents
========

.. toctree::
   :maxdepth: 1


Mathematics
===========

.. note:: A deep  understanding of the mathematics of Dubins' curves
    isn't necessary for making use of this module, but it may help
    if any changes are required to the module.

The motion of the Dubins' car can be described in terms of the
differential equations.

.. math::

    \dot{x}      &=& v \cos( \theta ) \\
    \dot{y}      &=& v \sin( \theta ) \\
    \dot{\theta} &=& \omega

Where :math:`x` and :math:`y` are the position of the vehicle,
:math:`\theta` is the angular heading of the vehicle, :math:`v` is a
velocity command input, and :math:`\omega` is the rotational rate
input.  

Another way of saying this is that the Dubins' car can be described by
a configuration :math:`q = [x, y, \theta]^T`.

The forward only constraint on the vehicle is imposed by requiring
:math:`0 < v \le v_{max}` and the limited turning rate constraint by
limiting :math:`|\omega| < \omega_{max}`.  

A Dubins' path describes the optimal (shortest path) that satisfies the
constraints.  These optimal paths can be shown to require :math:`v =
v_{max}` for the whole path and :math:`\omega` is equal to :math:`\pm
\omega_{max}` or 0.  Often, the constraints are rewritten (as the
equivalent) :math:`v_{max} = 1` and :math:`\frac{\omega_{max}}{v_{max}}`


The Dubins API
==============

.. automodule:: dubins
   :members:
   :undoc-members:


References
==========

.. [Dubins57] Dubins, L.E. (July 1957). "On Curves of Minimal Length
   with a Constraint on Average Curvature, and with Prescribed Initial
   and Terminal Positions and Tangents". American Journal of 
   Mathematics 79 (3): 497–516

.. [Shkel01] Shkel, A. M. and Lumelsky, V. (2001). "Classification of
   the Dubins set". Robotics and Autonomous Systems 34 (2001) 179–202

