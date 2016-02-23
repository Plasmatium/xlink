import QtQuick 2.5

Rectangle {
	id: root
	width: 100; height: 100
	color: "#00000000"

	property real sepRatio: 0.382
	property alias chartView: chartView
	property var py: parent.py
	//property var superRoot: parent.parent.superRoot

	SepBar {
		id: sep
		vertical: true
		x: root.width*sepRatio

	}

	SideView {
		id: sideBar
		height: root.height
		anchors.left: root.left
		anchors.right: sep.left
		//border.width: 1

	}		


	ChartView {
		id: chartView
		height: root.height
		anchors.right: root.right
		anchors.left: sep.right
		//border.width: 1
	}

	Component.onCompleted: {

	}
}
/*}

	ChartView {
		id: chartView
		anchors.left: sideBar.right
		anchors.right: root.right
	}
*/