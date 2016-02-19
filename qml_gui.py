##!/usr/local/bin/python3.5

from PyQt5.QtCore import QUrl, Qt
from PyQt5.QtGui import QGuiApplication, QColor
from PyQt5.QtQuick import QQuickView

import numpy as np
import pandas as pd
from numpy.random import random

from IPython.core.debugger import Tracer; set_trace=Tracer()
from time import sleep
 
_view = None
_tmp = None

def pd_test():
    li = [[random() for x in range(1000)] for y in range(1000)]
    return pd.DataFrame(li)

def _log(string):
    print(string)

def _getDataFromPython(item, prpty):    # todo: item, prpty, data
    #set_trace()
    global _tmp
    _tmp = item
    item.setProperty(prpty, str(pd_test()) + '\n'*3)
    #print(string)
 
 
if __name__ == '__main__':
    path = r'test.qml'
    # path = './qml_elements/ContentWindow.qml'
 
    app = QGuiApplication([])
    a = app
    view = QQuickView(); _view = view
    view.engine().quit.connect(app.quit)
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
