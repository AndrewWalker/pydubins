#!/usr/bin/python
import pydubins
import unittest

def test_simple():
    qs, ts = pydubins.sample_dubins_path((0,0,0),(4,4,0), 1.0, 0.1)
    qstart = qs[0]
    qend   = qs[-1]
    print qstart
    print qend

test_simple()
