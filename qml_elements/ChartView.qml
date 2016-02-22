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
			hoverEnabled: true
		    onWheel: {
		        if (wheel.modifiers & Qt.ControlModifier) {
		        	var yy = wheel.angleDelta.y
		            if (yy > 0)
		                py.log(["zoomIn", yy]);
		            else
		                py.log(["zoomOut", yy])
		        }
		        source = "image://chart/" + 4
		    }

		    onPositionChanged: {
		    	crossH.y = mouseY
		    	crossV.x = mouseX
		        py.log(mouseX)
		        var rslt = py.getXValue(mouseX, width)
		        console.log(rslt)
		    }
		    onEntered: {
		    	crossH.color = "#ff3998d6"
		    	crossV.color = "#ff3998d6"
		    }
		    onExited: {
		    	crossH.color = "#003998d6"
		    	crossV.color = "#003998d6"
		    }
		}

		Rectangle {
			id: crossH
			width: parent.width
			height: 1
			color: "#003998d6"
			y: -1
			Behavior on y {
				NumberAnimation { duration: 100 }
			}
			Behavior on color {
				ColorAnimation { duration: 250 }
			}
		}
		Rectangle {
			id: crossV
			width: 1
			height: parent.height
			color: "#003998d6"
			x: -1
			Behavior on x {
				NumberAnimation { duration: 100 }
			}
			Behavior on color {
				ColorAnimation { duration: 250 }
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