import QtQuick 2.5

Flickable {
	id: root
	width: 300; height: 200
	clip: true
	flickableDirection: Flickable.VerticalFlick
	contentWidth: pandasText.paintedWidth
	contentHeight: pandasText.paintedHeight

	property alias text: pandasText.text

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
		color: "#c2c2b4"		
		x: root.x + 15
		y: root.y + 15
		//width: root.width
		//height: root.height
		//anchors.fill: parent
		//anchors.leftMargin: 15
		readOnly: true
		focus: true
		wrapMode: TextEdit.Wrap
		text: "test text"
		onCursorRectangleChanged: root.ensureVisible(cursorRectangle)
	}

	Component.onCompleted: {
		root.parent.color = "#3f3f3f"
		pandasText.width = Qt.binding(
			function() {return root.parent.width} )
		pandasText.height = Qt.binding(
			function() {return root.parent.height} )
	}
}