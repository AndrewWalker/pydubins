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

   background
   api


References
==========

.. [Dubins57] Dubins, L.E. (July 1957). "On Curves of Minimal Length
   with a Constraint on Average Curvature, and with Prescribed Initial
   and Terminal Positions and Tangents". American Journal of 
   Mathematics 79 (3): 497–516

.. [Shkel01] Shkel, A. M. and Lumelsky, V. (2001). "Classification of
   the Dubins set". Robotics and Autonomous Systems 34 (2001) 179–202

