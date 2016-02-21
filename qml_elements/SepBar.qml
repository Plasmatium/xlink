import QtQuick 2.5

Rectangle {
	id: root
	width: 10
	height: parent.height*0.8
	property alias length: root.height
	signal positionChanged
	//border.width: 1

	Rectangle {
		id: bar
		width: parent.width/10
		height: parent.height
		anchors.centerIn: parent
		color: "lightgrey"
	}
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
}