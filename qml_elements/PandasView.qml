import QtQuick 2.5

Rectangle {
	id: root
	width: 300; height: 200
	color: "#3f3f3f"

	property alias text: pandasText.text

	Flickable {
		id: flickable
		anchors.fill: parent
		clip: true
		flickableDirection: Flickable.VerticalFlick
		contentWidth: pandasText.paintedWidth
		contentHeight: pandasText.paintedHeight


		function ensureVisible(r)
		{
			if (contentX >= r.x)
			    contentX = r.x;
			else if (contentX+width <= r.x+r.width)
			    contentX = r.x+r.width-width;
			if (contentY >= r.y)
			    contentY = r.y;
			else if (contentY+height <= r.y+r.height)
			    contentY = r.y+r.height-height;
		}

		TextEdit {
			id: pandasText
			color: "#bebe90"		
			x: flickable.x + 15
			y: flickable.y + 15
			//width: root.width
			//height: root.height
			//anchors.fill: parent
			//anchors.leftMargin: 15
			readOnly: true
			focus: true
			wrapMode: TextEdit.Wrap
			text: "No content."
			onCursorRectangleChanged: flickable.ensureVisible(cursorRectangle)
		}

		Component.onCompleted: {
			pandasText.width = Qt.binding(
				function() {return flickable.parent.width} )
			pandasText.height = Qt.binding(
				function() {return flickable.parent.height} )
		}
	}
}