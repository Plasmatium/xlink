import numpy as np
import pandas as pd
from numpy import random

from time import time
from pipe import *

random.seed(int(time()))
sin = np.sin

def rdm():
	return (random.random()/0.5-0.5)**5
def rdmX():
	x = np.arange(-2*np.pi*rdm(), 2*np.pi*rdm(), 1e-3)
	return x

def makeSineData():
	x = rdmX()
	y = rdm()*sin(rdm()*x+rdm())
	for i in range(100):
		y += rdm()*np.sin(rdm()*5*x+rdm())

	return pd.DataFrame(data=y, index=x, columns=['data'])

sinData = makeSineData()

data = sinData