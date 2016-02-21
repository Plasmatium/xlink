import QtQuick 2.5

Rectangle {
	id: root
	property var captionList: []
	property var selectionList: []
	property bool mutual: true
	property string currSel
	property alias v: lv
	property alias aspect: lv.orientation
	property real btnWidth: 116
	property real btnHeight: 26
	property real btnRadius: 3
	property alias lvAdd: lv.add
	property alias model: selectorModel
	
	function mutualize() {
        for(var i=0; i < lv.count; i++) {
        	var item = lv.contentItem.children[i]
        	if(mutual) {
	        	if(item.text == currSel) {
	        		item.checked = true
	        	}
	        	else {
	        		item.checked = false
	        	}
	        }
	        selectionList[i] = item.checked
	        console.log("----", currSel, item.text, item.checked)
	        console.log(selectionList, i, "\n")
        	item.setColor()
        }
	}

	Component {
		id: selectorDelegate
		//*/
		CheckButton {
			id: element
			text: name
			width: btnWidth
			height: btnHeight
			radius: btnRadius
			checked: isChecked
			flipable: !mutual
			onClicked: {
				if(mutual) { currSel = text }
				mutualize()
			}
		}
	}

	ListModel {
		id: selectorModel
	}

	ListView {
		id: lv
		anchors.fill: parent
		model: selectorModel
		delegate: selectorDelegate
		focus: true
		orientation: ListView.Horizontal
		interactive: false
	}

	Transition {
		id: addTrans
		SequentialAnimation {
			PauseAnimation {
				duration: (addTrans.ViewTransition.index -
                       addTrans.ViewTransition.targetIndexes[0]) * 100
			}
			NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 1000 }
			NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 1000 }
		}
	}

	Component.onCompleted: {
		//lv.add = addTrans
		var tmpArr = new Array([1024])

		for(var idx in captionList) {
			selectorModel.append( {
				"name": captionList[idx], 
				"isChecked": selectionList[idx]
				} )
			tmpArr[idx] = selectionList[idx]
		}
		selectionList = tmpArr

		if(aspect == ListView.Horizontal){
			root.width = btnWidth*lv.count
			root.height = btnHeight.height			
		}
		else {
			root.width = btnWidth.width
			root.height = btnHeight.height*lv.count
		}
	}
}
