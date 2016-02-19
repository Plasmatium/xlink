import QtQuick 2.5

Rectangle {
	id: root
	width: 1
	height: 600
	property alias length: root.height
	//border.width: 1

	gradient: Gradient {
		GradientStop { position: 0.0; color: "#00000000" }
		GradientStop { position: 0.025; color: "lightgray" }
		GradientStop { position: 0.975; color: "lightgray" }
		GradientStop { position: 1.0; color: "#00000000" }
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
	}

}