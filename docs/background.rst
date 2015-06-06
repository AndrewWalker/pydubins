Background
==========

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


