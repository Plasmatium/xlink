import matplotlib, io
from PIL import Image
import numpy as np
from time import time
from pdb import set_trace

matplotlib.use('agg')
import matplotlib.pyplot as plt
import testdata as td

fig = plt.figure()
overlayTrig = True

imgdata = io.BytesIO()
fig.savefig(imgdata, format='jpg')
fig.subplotpars.update(left=0.1, right=0.9, top=0.9, bottom=0.1)

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

def showIpyFig(_fig):
	imgdata = io.BytesIO()
	_fig.savefig(imgdata, format='tiff')
	imgdata.seek(0)
	return Image.open(imgdata)