import QtQuick 2.5

Rectangle {
	id: root
	property var py: parent.py
	property alias labelText: label.text
	property alias inputText: input.text
	property alias readOnly: input.readOnly
	property alias labelWidth: labelR.width
	property alias inputWidth: inputR.width

	property var fcolor: 'white'
	property var bcolor: '#ff3998d6'

	width: 330
	height: 60
	color: '#00000000'

	Rectangle {
		id: labelR
		width: 50
		height: 40
		color: bcolor
		anchors.verticalCenter: parent.verticalCenter
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
		id: inputR
		border.color: fcolor
		color: bcolor
		width: 270
		height: 40
		radius: 3
		anchors.right: root.right
		anchors.verticalCenter: parent.verticalCenter

		anchors.rightMargin: 3
		TextInput {
			anchors.verticalCenter: parent.verticalCenter
			width: 245
			x: 5
			id: input
			text: 'input'
			color: fcolor
			selectByMouse: true
			selectionColor: "#ffd69839"
			wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
			font.pixelSize: 16
		}
	}
}