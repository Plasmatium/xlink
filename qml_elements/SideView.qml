import QtQuick 2.5

Rectangle {
	id: root

	property var py: parent.py

	PandasView {
		id: configList
		width: root.width
		height: root.height*0.382
		text: py.refreshConfigInfo()

		Component.onCompleted: {
		}
	}

	SepBar {
		id: sep1
		vertical: false
		y: root.height*0.382
	}
}