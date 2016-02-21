import QtQuick 2.5

/*
buttons:
	Prev Fig
	Next Fig
	
	Overlay

 * 
 */

Rectangle {
	id: root
	property alias source: img.source
	property alias iw: img.width
	property alias ih: img.height
	property var py: parent.py

	//button properties
	property alias bOverlay: overlay.checked

	Image {
		id: img
		width: root.width
		height: root.height*0.618
		property int imgCount: 0
		z:1
		source: ""

		MouseArea {
			anchors.fill: parent
		    onWheel: {
		        if (wheel.modifiers & Qt.ControlModifier) {
		        	var yy = wheel.angleDelta.y
		            if (yy > 0)
		                console.log("zoomIn", yy);
		            else
		                console.log("zoomOut", yy)
		        }

		        source = "image://chart/" + 4
		    }
		}
	}

	PandasView {
		id: pdView
		width: root.width
		height: root.height*0.618
		z: 0
	}

	Rectangle {
		id: buttonGrid
		width: root.width
		anchors.top: img.bottom
		anchors.bottom: root.bottom

		Grid {
			columns: 4
			spacing: 64
			width: parent.width*0.8
			height: parent.height*0.8
			anchors.centerIn: parent

			CheckButton {
				id: overlay
			}

			PushButton {
				id: save
			}

			PushButton {
				id: b2
			}

			PushButton {
				id: b3
			}

			PushButton {
				id: b4
			}

			PushButton {
				id: b5
			}

			PushButton {
				id: b6
			}
		}
	}
}