import QtQuick 2.5

Button {
    id: root
 
    property var lcolor: "white"
    property var dcolor: "#ff3998d6"
 
    backColor: lcolor
    textColor: dcolor
 
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.clicked()
            checked = !checked
            if(checked) {
            	backColor = dcolor
            	textColor = lcolor
            }
            else {
            	backColor = lcolor
            	textColor = dcolor
            }
        }
        onEntered: {
        	if(checked) {backColor = Qt.lighter(dcolor,1.2)}
        	else {backColor = Qt.darker(lcolor,1.2)}        	
        }
        onExited: {
        	if(checked) {backColor = dcolor}
        	else {backColor = lcolor}       	
        }
    }
    Behavior on backColor { ColorAnimation{ duration: 150
	            easing.type: easing.OutExpo
	            } }
}