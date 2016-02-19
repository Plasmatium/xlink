import QtQuick 2.5
import QtGraphicalEffects 1.0
import "./qml_elements"

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
    signal getDataFromPython(var item, string prpty)

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
    	anchors.fill: parent
    	anchors.margins: 30
    	//width: root.width-30
    	//height: root.height-30
    	color: 'white'

    	//拖动窗口
	    MouseArea {
	        anchors.fill: parent
	        acceptedButtons: Qt.LeftButton //只处理鼠标左键
	        //hoverEnabled : true
	        property var pX
	        property var pY

	        onPressed: { //接收鼠标按下事件
	        	pX = mouseX
	        	pY = mouseY
	            console.log("pressed: ", pX, pY)
	        }
	        onPositionChanged: { //鼠标按下后改变位置
	        	mainwindow.x += mouseX - pX
	        	mainwindow.y += mouseY - pY
	        }
	    }

	    //*/
    	PushButton {
    		id: quitButton
    		width: 40; height: 40
    		text: "X"
    		backColor: "white"
    		textColor: "red"
    		border.width: 0

	        anchors.topMargin: 1
	        anchors.rightMargin: 1
	        anchors.top: parent.top
	        anchors.right: parent.right

    		onClicked: {
    			root.log("quit")
    			root.quit()
    		}
    	}
    	//*/

	    ContentWindow {
	    	id: contentWindow
	    	anchors.fill: parent
	    	anchors.topMargin: 50
	    }

	    CheckButton {
	    	anchors.centerIn: parent
	    	property string str
	    	checked: true
	    	onClicked: {
	    		text = "Stop"
	    		getDataFromPython(contentWindow.pd_view, "text")
	    	}
	    }
    }
}