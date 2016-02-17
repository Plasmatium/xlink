import QtQuick 2.5

Rectangle {
    id: mainWindow
    width: 400
    height: 300

    color: "white"
    border.width: 1
    border.color: "lightgray"

    property int mainWindowX    //用来存储主窗口x坐标
    property int mainWindowY    //存储窗口y坐标
    property int xMouse         //存储鼠标x坐标
    property int yMouse         //存储鼠标y坐标



    signal sendClicked(string str1) // 定义信号
    signal quit()

    Rectangle {
        width: 40; height: 40
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.rightMargin: 1
        id: quit_button
        anchors.right: parent.right
        Text {
            id: quit
            text: "X"
            color: "red"
            anchors.centerIn: parent
            Behavior on color { ColorAnimation{ duration: 150; easing.type: easing.InOutQuart} }
        }
        MouseArea {
            anchors.topMargin: 1
            anchors.fill: parent  // 有效区域
            hoverEnabled: true
            onClicked: {
                mainWindow.quit()
                mainWindow.sendClicked("quit")    // 发射信号到Python
                //parent.color="red"
            }
            onEntered: {
                quit.color = "white"
                quit_button.color = "red"
            }
            onExited: {
                quit.color = "red"
                quit_button.color = "white"
            }
        }
        Behavior on color { ColorAnimation{ duration: 150; easing.type: easing.InOutQuart} }
    }

    Rectangle {
        id: title_rect
        width: 100
        height: 40
        anchors.topMargin: 1
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        border.width: 1

        Text {
            id: title
            anchors.centerIn: parent
            text: "title"

        }
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton //只处理鼠标左键
            onPressed: { //接收鼠标按下事件
                xMouse = mouseX
                yMouse = mouseY
                mainWindow.sendClicked("asdf")
            }
            onPositionChanged: { //鼠标按下后改变位置
                mainwindow.x = (mainwindow.x + (mouseX - xMouse))
                mainwindow.y = (mainwindow.y + (mouseY - yMouse))
                mainWindow.sendClicked(String(mainwindow.x)+','+String(mainwindow.y))
            }
        }

    }


}
/*
    Rectangle {width: mainWindow.width/3; height: 40
     id: func_button
     Text {
            id: txt
            text: "Clicked me"
            anchors.centerIn: parent
        }
    }
*/
