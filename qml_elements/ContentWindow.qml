import QtQuick 2.5

Rectangle {
	id: root
	width: 100; height: 100
	color: "#00000000"

	property real sepRatio: 0.3


	Rectangle {
		id: sideBar
		height: root.height
		anchors.left: root.left
		width: sep.sepPos - 3
		border.width: 1
	}		

	SepBar {
		id: sep
		length: root.height - 20
		sepPos: root.width*0.3
		anchors.left: sideBar.right

	}

	Rectangle {
		id: content
		height: root.height
		anchors.right: root.right
		anchors.left: sep.right
		border.width: 1
	}	

}