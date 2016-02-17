from PyQt5.QtCore import QUrl, Qt
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView
from IPython.core.debugger import Tracer; set_trace=Tracer()
 
def run_func(string):
    print(string)

 
 
if __name__ == '__main__':
    # path = r'test\main.qml'
    path = 'test.qml'
 
    app = QGuiApplication([])
    a = app
    view = QQuickView(); v = view
    view.engine().quit.connect(app.quit)
    view.setFlags(Qt.FramelessWindowHint)
    view.setSource(QUrl(path))
    view.show()
 
    context = view.rootObject()
    context.sendClicked.connect(run_func)   # 连接QML文件中的sendClicked信号
    context.quit.connect(view.close)
    app.exec_()