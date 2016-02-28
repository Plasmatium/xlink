#!/usr/local/bin/python3.5
from PyQt5 import QtCore, QtGui, QtWidgets, QtQml, QtQuick
from PyQt5.QtCore import Qt, QObject, pyqtSlot, QVariant
from PyQt5.QtQml import QJSValue, QJSEngine

import numpy as np
import pandas as pd
import io
from numpy.random import random
from time import time

from pdb import set_trace
from time import sleep

import mpl
import testdata as td
import tcp_sr as ts

_view = 1
_tmp = 1
jeg = QJSEngine()

def pd2qv(df):
    data = df.T.to_dict()
    return QVariant(data)

def _initFigure(width, height):
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

    def requestPixmap(self, ID, size):
        param = ID.split(':')
        prefix = param[0]
        argv = param[1]

        switch = {
        'zoom': mpl.zoom,
        'new': mpl.new,
        'drag': mpl.drag,
        }

        pixmap = QtGui.QPixmap()
        img = switch[prefix](argv)
        pixmap.loadFromData(img)

        return pixmap, QtCore.QSize(800, 600)


class PQExchange(QObject):
    @pyqtSlot(QVariant, result=str)
    def saveConfig(self, var_dict):
        df = pd.DataFrame(var_dict.toVariant()).T
        df.index = df['SN']
        del df['SN']
        ts.dumpc('config.cdt', df)
        return 'test'

    @pyqtSlot(str, result=QVariant)
    def getDataFrame(self, fn):
        df = ts.loadc(fn)
        return pd2qv(df.sort_index())

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
        rslt = mpl.getXValue(mouseX, width)
        return QVariant(rslt)

    @pyqtSlot(str)
    def saveFig(self, path):
        fn = path+hex(hash(time()))[2:]+'.pdf'
        mpl.fig.savefig(fn, format='pdf')

    @pyqtSlot(result=str)
    def refreshConfigInfo(self):
        return ts.showConfigInfo()

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