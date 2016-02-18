from PyQt5.QtCore import QUrl, Qt
from PyQt5.QtGui import QGuiApplication, QColor
from PyQt5.QtQuick import QQuickView

from IPython.core.debugger import Tracer; set_trace=Tracer()
from time import sleep
 
def run_func(string):
    print(string)

 
 
if __name__ == '__main__':
    # path = r'test\main.qml'
    path = 'test.qml'
 
    app = QGuiApplication([])
    a = app
    view = QQuickView(); v = view
    view.engine().quit.connect(app.quit)
    view.setSource(QUrl(path))
    view.setColor(QColor(Qt.transparent))
    view.setFlags(Qt.Window|Qt.FramelessWindowHint)
    view.show()
 
    context = view.rootObject()
    view.rootContext().setContextProperty("mainwindow", view)
    context.log.connect(run_func)   # 连接QML文件中的log信号
    context.quit.connect(view.close)
    app.exec_()