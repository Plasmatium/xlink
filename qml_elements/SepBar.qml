import QtQuick 2.5

Rectangle {
	id: root
	//width: 10
	//height: parent.height*0.8
	property bool vertical: true
	//border.width: 1

	Rectangle {
		id: bar
		//width: 1
		//height: parent.height
		anchors.centerIn: parent
		color: "lightgrey"
	}

	Component.onCompleted: {
		if(vertical) {
			root.height = root.parent.height
			bar.height = root.height*0.98
			root.width = 10
			bar.width = 1
		}
		else {
			root.width = root.parent.width
			bar.width = root.width*0.98
			root.height = 10
			bar.height = 1

		}
		bar.anchors.centerIn = root
	}
	/*
	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.SizeHorCursor
		acceptedButtons: Qt.LeftButton //只处理鼠标左键
		//hoverEnabled: true
		drag.target: root
		drag.axis: Drag.XAxis
		drag.maximumX: root.parent.width/4*3
		drag.minimumX: root.parent.width/4
		onPositionChanged: {
			//console.log('changed')
		}
	}
	*/
}