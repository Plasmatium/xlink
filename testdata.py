import numpy as np
import pandas as pd
from numpy import random

from time import time
from pipe import *

random.seed(int(time()))
sin = np.sin
x = np.arange(-2*np.pi, 2*np.pi, 1e-3)

def rdm():
	return (random.random()/0.5-0.5)**5

def makeSineData():
	y = rdm()*sin(rdm()*x+rdm())
	for i in range(100):
		y += rdm()*np.sin(rdm()*5*x+rdm())

	return pd.DataFrame(data=y, index=x, columns=['data'])

sinData = makeSineData()

data = sinData