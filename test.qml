import QtQuick 2.5
import QtGraphicalEffects 1.0
//import "Button"

Rectangle {
    id: root
    width: 1600
    height: 900

    color: "#00000000"

    property int rootX    //用来存储主窗口x坐标
    property int rootY    //存储窗口y坐标
    property int xMouse         //存储鼠标x坐标
    property int yMouse         //存储鼠标y坐标
    signal log(string str1) // 定义信号
    signal quit()

    layer.enabled: true
    layer.effect: DropShadow {
        radius: 15
        samples: radius * 2
        source: root
        color: "#aa000000"
        transparentBorder: true
    }

    Rectangle {
    	id: mainWindow
    	width: root.width-30
    	height: root.height-30
    	color: 'white'
    	anchors.centerIn: parent

    	//拖动窗口
	    MouseArea {
	        anchors.fill: parent
	        acceptedButtons: Qt.LeftButton //只处理鼠标左键
	        onPressed: { //接收鼠标按下事件
	            xMouse = mouseX
	            yMouse = mouseY
	            root.log("asdf")
	        }
	        onPositionChanged: { //鼠标按下后改变位置
	            mainwindow.x = (mainwindow.x + (mouseX - xMouse))
	            mainwindow.y = (mainwindow.y + (mouseY - yMouse))
	            root.log(String(mainwindow.x)+','+String(mainwindow.y))
	        }
	    }

	    /*/
    	Button {
    		id: quitButton
    		width: 40; height: 40
	        anchors.topMargin: 1
	        anchors.rightMargin: 1
	        anchors.top: parent.top
	        anchors.right: parent.right
    		text: "X"

    		onClicked: {
    			root.log("quit")
    			root.quit()
    		}
    	}
    	//*/

    	//*/
	    CheckButton {
	    	anchors.centerIn: parent
	    	checked: true
	    	onClicked: {
	    		text = "Stop"
	    	}
	    }
	    //*/
    }
}
