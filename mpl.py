import matplotlib, io
from PIL import Image
import numpy as np
from time import time
from pdb import set_trace

matplotlib.use('agg')
import matplotlib.pyplot as plt
import testdata as td
import tcp_sr as ts
import pandas as pd

currentID = None
conf = []
imgCache = {}

fig = plt.figure()
overlayTrig = True
fig.subplotpars.update(left=0.1, right=0.9, top=0.8, bottom=0.2, hspace=0.4)


def getImageData(data=None):
	if data is not None:
		if not overlayTrig:
			fig.clear()

		fig.add_subplot(311)
		fig.add_subplot(312)
		fig.add_subplot(313)

		for ax in fig.axes:
			ax.plot(td.makeSineData())

	return generateImgData()

def zoom(argv):
	param = argv.split(',')
	direction = ((param[0]=='direction=in') and 0.9 or 1/0.9)
	for ax in fig.axes:
		interval = ax.xaxis.get_view_interval()
		print('interval: ', interval)
		print('xValue: ', ax.xValue)
		left = (interval[0]-ax.xValue)*direction+ax.xValue
		right = (interval[1]-ax.xValue)*direction+ax.xValue
		print(left, right)
		ax.set_xlim(left, right)
	print('-'*64)
	getXValue(fig._mouseX, fig._width)

	return generateImgData()

def drag(argv):
	param = argv.split(',')
	deltaX = float(param[0].split('=')[1])

	w = fig._width
	for ax in fig.axes:
		interval = ax.xaxis.get_view_interval()
		print('begin', interval)
		ratio = (interval[1]-interval[0])/(w*0.8)
		print(ratio)
		delta = deltaX*ratio
		print(delta)
		interval -= delta
		ax.set_xlim(interval[0], interval[1])
		print('end', interval)
		print()
	print('-'*64)
	getXValue(fig._mouseX, fig._width)
	return generateImgData()

def generateImgData():
	imgdata = io.BytesIO()
	fig.savefig(imgdata, format='tiff')
	imgdata.seek(0)
	return imgdata.read()

def getXValue(mouseX, width):
	fig._mouseX = mouseX
	fig._width = width
	rslt = []
	for ax in fig.axes:
		xax = ax.xaxis
		rg = xax.get_view_interval()
		pix = mouseX-width*0.1
		ratio = pix/(width*0.8)
		x = rg[0]+ratio*(rg[1]-rg[0])
		ax.xValue = x
		rslt.append([float(x)])
	return rslt

def new(argv):
	'''
	data = ts.loadc('./dat/1fff0b8a.cdt')['ch1']
	fig.clear()
	sp = fig.add_subplot(111)
	sp.plot(data[0:100])
	'''
	if currentID in imgCache:
		print('cached img return', currentID)
		return imgCache[currentID]

	df = pd.DataFrame(conf)
	if df.empty:
		return
	m = df.figNum.max()
	fig.clear()
	for r in df.iterrows():
		row = r[1]
		data = ts.loadc('./dat/'+row.sn+'.cdt')[row.channel]
		data = data[(data.index>row.begin) & (data.index<row.end)]
		sp = fig.add_subplot(int(m)*100+10+int(row.figNum))
		sp.plot(data)
		sp.grid(True)

	imgData = generateImgData()
	imgCache[currentID] = imgData
	return imgData

def showIpyFig(_fig):
	imgdata = io.BytesIO()
	_fig.savefig(imgdata, format='tiff')
	imgdata.seek(0)
	return Image.open(imgdata)