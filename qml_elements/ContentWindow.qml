import QtQuick 2.5

Rectangle {
	id: root
	width: 100; height: 100
	color: "#00000000"

	property real sepRatio: 0.3
	property alias pd_view: pdView

	SepBar {
		id: sep
		length: root.height - 20
		x: root.width*sepRatio

	}

	Rectangle {
		id: sideBar
		height: root.height
		anchors.left: root.left
		anchors.right: sep.left
		//border.width: 1
		//color: "#3f3f3f"

	}		


	Rectangle {
		id: content
		height: root.height/1.618
		anchors.right: root.right
		anchors.left: sep.right
		//border.width: 1

		
		PandasView {
			id: pdView
			anchors.fill: parent
		}
	}	

}