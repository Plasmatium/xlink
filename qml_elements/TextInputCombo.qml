import QtQuick 2.5

Rectangle {
	id: root
	property var py: parent.py
	property alias labelText: label.text
	property alias inputText: input.text

	property var fcolor: 'white'
	property var bcolor: '#ff3998d6'

	width: 330
	height: 60
	color: '#00000000'

	Rectangle {
		width: 50
		height: 40
		color: bcolor
		Text {
			anchors.verticalCenter: parent.verticalCenter
			x: 5
			id: label
			text: 'label'
			color: fcolor
			font.pixelSize: 16
		}
	}

	Rectangle {
		border.color: 'white'
		color: bcolor
		width: 270
		height: 40
		radius: 3
		anchors.right: root.right

		anchors.rightMargin: 3
		TextInput {
			anchors.verticalCenter: parent.verticalCenter
			width: 245
			x: 5
			id: input
			text: 'input'
			color: fcolor
			font.pixelSize: 16
		}
	}
}