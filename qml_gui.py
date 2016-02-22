#!/usr/local/bin/python3

from PyQt5 import QtCore, QtGui, QtWidgets, QtQml, QtQuick
from PyQt5.QtCore import Qt, QObject, pyqtSlot, QVariant
from PyQt5.QtQml import QJSValue

import numpy as np
import pandas as pd
from numpy.random import random
from time import time

from pdb import set_trace
from time import sleep

import mpl
import testdata as td

_view = None
_tmp = None

def _initFigure(width, height):
    set_trace()
    fig = mpl.fig
    dpi = fig.get_dpi()
    fig.set_figwidth(width*dpi)
    fig.set_figheight(height*dpi)


def pd_test(d1, d2):
    li = [[random() for x in range(d2)] for y in range(d1)]
    return str(pd.DataFrame(li)) + '\n'*3

def _log(string):
    #set_trace()
    print(string)

def _getDataFromPython(item, param):    # todo: item, prpty, data
    #set_trace()
    #global _tmp
    #_tmp = item
    p = param.toVariant()
    prpty = p.get('prpty')
    func = globals()[p.get('func')]
    argv = p.get('argv')
    if argv==None:
        rslt = func()
    else:
        rslt = func(*argv)

    if item == None:
        return        
    if not item.setProperty(prpty, rslt):
        print('set property failed')
        print('\tsaparam: ',p, '\n\tresult: ', str(rslt)[0:100]+'\n...')
    
##############################################################################

class MainGui(QtCore.QObject):
    def __init__(self, app):
        QtCore.QObject.__init__(self)
        self.app = app
        self.view = QtQuick.QQuickView()
        self.context = self.view.rootContext()
        self.py = PQExchange()
        self.context.setContextProperty("py", self.py)



        engine = self.context.engine()
        self.image_provider = ImageProvider()
        engine.addImageProvider("chart", self.image_provider)
        self.view.setSource(QtCore.QUrl("test.qml"))

        #self.view.setResizeMode(QtQuick.QQuickView.SizeRootObjectToView)
        self.view.setColor(QtGui.QColor(Qt.transparent))
        self.view.setFlags(Qt.Window|Qt.FramelessWindowHint)

        self.context.setContextProperty("mainwindow", self.view)

        self.rootObj = self.view.rootObject()
        self.rootObj.log.connect(_log)
        self.rootObj.quit.connect(self.view.close)
        self.rootObj.getDataFromPython.connect(_getDataFromPython)
        self.rootObj.initFigure.connect(_initFigure)


        self.view.show()
        self.app.exec_()

class ImageProvider(QtQuick.QQuickImageProvider):
    def __init__(self):
        QtQuick.QQuickImageProvider.__init__(self, QtQuick.QQuickImageProvider.Pixmap)

    def requestPixmap(self, id, size):
        #set_trace()
        #pixmap = QtGui.QPixmap(100, 100)
        #pixmap.fill(QtGui.QColor(id))

        t = time()
        pixmap = QtGui.QPixmap()
        img = mpl.getImageData(td.data)
        pixmap.loadFromData(img)
        print('****', time()-t)

        return pixmap, QtCore.QSize(800, 600)

class PQExchange(QObject):
    @pyqtSlot(int, result=str)
    def plus10(self, value):
        return str(value+10)

    @pyqtSlot(QJSValue)
    def log(self, v):
        v = v.toVariant()
        print(v)

    @pyqtSlot(float, float)
    def initFigure(self, width, height):
        #set_trace()
        fig = mpl.fig
        dpi = fig.get_dpi()
        fig.set_figwidth(width/dpi)
        fig.set_figheight(height/dpi)

    @pyqtSlot(QJSValue)
    def updateImgParam(self, param):
        #set_trace()
        p = param.toVariant()
        iw = p.get('iw')
        ih = p.get('ih')
        dataID = p.get('dataID')
        td.data = dataID

        self.initFigure(iw, ih)
        mpl.overlayTrig = p.get('bOverlay')

    @pyqtSlot(float, float, result=QVariant)
    def getXValue(self, mouseX, width):
        fig = mpl.fig
        rslt = []
        #set_trace()
        for ax in fig.axes:
            xax = ax.xaxis
            rg = xax.get_view_interval()
            pix = mouseX-width*0.1
            ratio = pix/(width*0.8)
            x = rg[0]+ratio*(rg[1]-rg[0])
            rslt.append([float(x)])

        return QVariant(rslt)



############################################################################## 

app = QtGui.QGuiApplication(["XLink"])
x = MainGui(app)

'''
if __name__ == '__main__':
    path = r'test.qml'
    # path = './qml_elements/ContentWindow.qml'
 
    app = QGuiApplication([])
    a = app
    view = QQuickView(); _view = view
    view.engine().quit.connect(app.quit)
    view.engine().addImageProvider('chart', ImageProvider())
    view.setSource(QUrl(path))
    view.setColor(QColor(Qt.transparent))
    view.setFlags(Qt.Window|Qt.FramelessWindowHint)
    view.show()
 
    context = view.rootObject()
    view.rootContext().setContextProperty("mainwindow", view)

    context.log.connect(_log)   # 连接QML文件中的log信号
    context.quit.connect(view.close)
    context.getDataFromPython.connect(_getDataFromPython)
    app.exec_()
'''