import unittest
import math
import dubins

class DubinsCurvesTests(unittest.TestCase):

    def test_colocated_configurations(self):
        # Regression: previous version of the code did not work correctly 
        # for goal and initial configurations were too close together
        qi = (0,0,0)
        qg = (0,0,0)
        turning_radius = 1.0
        code = dubins.path_type(qi, qg, turning_radius)
        self.assertEquals(code, 0)

    def test_invalid_turning_radius(self):
        with self.assertRaises(RuntimeError):
            dubins.path_type((0,0,0), (1,0,0), -1.0)

    def test_simple(self):
        length = dubins.path_length((0,0,0), (10,0,0), 1.0)
        self.assertAlmostEqual(length, 10.0)

    def test_almost_full_loop(self):
        r = 2.0
        dy = 0.1
        length = dubins.path_length((0,0,0), (0,-dy,0), r)
        self.assertAlmostEqual(length, 2*math.pi*r + dy)

    def test_easy_lrl(self):
        # Regression for https://github.com/AndrewWalker/Dubins-Curves/issues/2
        r = 1.0
        q0 = (0, 0, math.pi/2.)
        q1 = (1, 0, -math.pi/2.)
        path_type = dubins.path_type(q0, q1, r)
        self.assertAlmostEqual(path_type, dubins.LRL)

    def test_half_loop(self):
        r = 1.0
        dx = r * math.sqrt(2)/2
        dy = r * math.sqrt(2)/2
        length = dubins.path_length((0,0,0), (0, 2*r, -math.pi), r)
        self.assertAlmostEqual(length, math.pi*r)

    def test_non_unit_turning_radius(self):
        length = dubins.path_length((0,0,0), (10,0,0), 2.0)
        self.assertAlmostEqual(length, 10.0)

    def test_turning_radius_scaling(self):
        a = dubins.path_length((0,0,0), (10,10,math.pi/4.0), 1.0)
        b = dubins.path_length((0,0,0), (10,10,math.pi/4.0), 2.0)
        self.assert_(b > a)

