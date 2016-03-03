import QtQuick 2.5
Rectangle {
	id: root
	property var py: parent.py
	property var fColor: "#ff3998d6"
	property var bColor: "white"
	property var currentIndex: view.currentIndex
	property alias mod: mod

	Component {
		id: delegate
		Item {
			height: 90
			width: 200
			Column {
				height: 90
				width: 10
				x: 20
				y: 5
				Text { color: fColor; text: '<b>FigNum</b>: '+figNum}
				Text { color: fColor; text: '<b>SN</b>:'+sn}
				Text { color: fColor; text: '<b>Begin</b>: '+begin}
				Text { color: fColor; text: '<b>End</b>: '+end}
				Text { color: fColor; text: '<b>Channel</b>: '+channel}

			}
			//SN		Fig Num
			//Begin
			//End
			//Channel
			//*/
		    MouseArea {
	            anchors.fill: parent
	            onClicked: {
	                view.currentIndex = index
	            }
	        }
	        //*/
	    }
	}
	function addData(d) {
		mod.append(d)		
	}
	function removeCurrentData() {
		mod.remove(view.currentIndex)
		view.currentIndex--
	}

	ListView {
        id: view
        anchors.fill: parent
        anchors.topMargin: 40
        clip: true
        model: mod
        delegate: delegate
        highlight: hlt
        highlightFollowsCurrentItem: false
        //focus: true
    }
    Component {
    	id: hlt    	
	    Rectangle { 
	    	color: "#ffffad80"
	    	width: 10
	    	height: 90
            y: view.currentItem.y

            Behavior on y {
            	NumberAnimation {
            		duration: 150
            		easing.type: Easing.OutQuint
            	}
            }
	    }

    }
    ListModel {
    	id: mod
	}
    Component.onCompleted: {
    }
}