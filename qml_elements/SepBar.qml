import QtQuick 2.5

Rectangle {
	id: root
	width: 10
	height: 600
	color: "#00000000"
	property alias length: root.height
	property real sepPos: root.x+3
	border.width: 1

	Rectangle {
		width: 1
		height: root.height
		anchors.horizontalCenter: parent.horizontalCenter
		gradient: Gradient {
			GradientStop { position: 0.0; color: "#00000000" }
			GradientStop { position: 0.025; color: "lightgray" }
			GradientStop { position: 0.975; color: "lightgray" }
			GradientStop { position: 1.0; color: "#00000000" }
		}
	}

	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.SizeHorCursor
		acceptedButtons: Qt.LeftButton //只处理鼠标左键

		onPressed: {
			//sepPos = mouseX-4
		}
		onPositionChanged: {
			sepPos = mouseX
			console.log(mouseX)
		}
	}

}