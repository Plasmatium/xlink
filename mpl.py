import matplotlib, io
from PIL import Image
import numpy as np
from time import time
from ipdb import set_trace

matplotlib.use('agg')
import matplotlib.pyplot as plt
import testdata as td

fig = plt.figure()
overlayTrig = True

imgdata = io.BytesIO()
fig.savefig(imgdata, format='jpg')

imgdata.seek(0)
data = imgdata.read()

im = Image.open(imgdata)

def getImageData(data=None):
	if data is not None:
		if not overlayTrig:
			fig.clear()

		fig.add_subplot(211)
		fig.add_subplot(212)

		for ax in fig.axes:
			ax.plot(td.makeSineData())

	imgdata = io.BytesIO()
	t = time()
	fig.savefig(imgdata, format='tiff')
	print('---', time()-t)

	imgdata.seek(0)
	return imgdata.read()
