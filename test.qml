import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import "./qml_elements"

Rectangle {
    id: root
    //adapt with screen
    width: Screen.desktopAvailableWidth/1.2
    height: width*0.6

    color: "#00000000"

    property int rootX    //用来存储主窗口x坐标
    property int rootY    //存储窗口y坐标
    property int xMouse         //存储鼠标x坐标
    property int yMouse         //存储鼠标y坐标
    property int imgCount: 0
    property var superRoot: root

    signal log(var str1) // 定义信号
    signal quit()
    // param: type is dict, contains property to set, callback func, argv
    signal getDataFromPython(var item, var param)
    signal initFigure(real width, real height)

    layer.enabled: true
    layer.effect: DropShadow {
        radius: 16
        samples: radius * 2
        source: root
        color: "#aa000000"
        transparentBorder: true
    }

    Rectangle {
    	id: mainWindow
    	anchors.fill: parent
    	//anchors.margins: 10
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
	        }
	        onPositionChanged: { //鼠标按下后改变位置
	        	mainwindow.x += mouseX - pX
	        	mainwindow.y += mouseY - pY
	        }
	    }

	    //*/
    	PushButton {
    		id: quitButton
    		width: 64; height: 40
    		text: "X"
    		backColor: "white"
    		textColor: "red"
    		border.width: 0

	        anchors.topMargin: 1
	        anchors.rightMargin: 1
	        anchors.top: parent.top
	        anchors.right: parent.right

    		onClicked: {
    			py.log("quit")
    			mainwindow.close()
    		}
    	}
    	//*/

	    ContentWindow {
	    	id: contentWindow
	    	anchors.fill: parent
	    	anchors.topMargin: 80
	    	//border.width: 1
	    }

	    //checkbutton for test
	    CheckButton {
	    	//checked: true
	    	width: 64
	    	height: 40
	    	checkedText: "Running"
	    	uncheckedText: "Idle"
	    	checked: false
	    	border.width: 0
	    	onClicked: {
				var param = {
					"bOverlay": contentWindow.chartView.bOverlay,
					"dataID": imgCount>3?null:309,
					"iw": contentWindow.chartView.iw,
					"ih": contentWindow.chartView.ih,
				}
	    		refreshImage(param)
	    	}
	    }

	    SelectButton {
	    	id: menu
	    	captionList: ['Chart', 'Running', 'Configuration']
	    	//captionList: ["1","2","3"]
	    	selectionList: [true, false]
	    	anchors.horizontalCenter: parent.horizontalCenter
	    	anchors.topMargin: 36.44
	    	anchors.top: parent.top
	    }	
    }

    Component.onCompleted: {
    	var cv = contentWindow.chartView
    	py.initFigure(cv.iw, cv.ih)

    	contentWindow.py = py
    	//root.log('print')
		//root.initFigure(cv.width, cv.height)
	}

	function refreshImage(param) {
		py.updateImgParam(param)
		var chartView = contentWindow.chartView
		chartView.source = 'image://chart/new:ID='+ imgCount++
		
	}
}