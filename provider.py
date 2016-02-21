#!/usr/local/bin/python3.5
from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5 import QtWidgets
from PyQt5 import QtQml
from PyQt5 import QtQuick
import mpl

class ImageProviderGUI(QtCore.QObject):
    def __init__(self):
        QtCore.QObject.__init__(self)
        self.app = QtWidgets.QApplication(["ImageProvider"])
        self.view = QtQuick.QQuickView()
        self.view.setResizeMode(QtQuick.QQuickView.SizeRootObjectToView)
        self.context = self.view.rootContext()
        engine = self.context.engine()
        self.image_provider = ImageProvider()
        engine.addImageProvider("chart", self.image_provider)
        self.view.setSource(QtCore.QUrl("test.qml"))
        self.view.show()
        self.app.exec_()

class ImageProvider(QtQuick.QQuickImageProvider):
    def __init__(self):
        QtQuick.QQuickImageProvider.__init__(self, QtQuick.QQuickImageProvider.Pixmap)

    def requestPixmap(self, id, size):
        #pixmap = QtGui.QPixmap(100, 100)
        #pixmap.fill(QtGui.QColor(id))
        pixmap = QtGui.QPixmap()
        pixmap.loadFromData(mpl.data)
        return pixmap, QtCore.QSize(100, 100)

ImageProviderGUI()