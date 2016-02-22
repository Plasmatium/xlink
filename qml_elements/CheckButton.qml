import QtQuick 2.5

Button {
    id: root
 
    property var lcolor: "white"
    property var dcolor: "#ff3998d6"
    property bool checked: false
    property bool flipable: true
    property string checkedText: 'Checked'
    property string uncheckedText: 'Unchecked'
 
    backColor: lcolor
    textColor: dcolor

    function setColor() {
        if(checked) {
            backColor = dcolor
            textColor = lcolor
        }
        else {
            backColor = lcolor
            textColor = dcolor            
        }
    }
 
    Component.onCompleted: {
        setColor()
        if(flipable){
            text = checked ? checkedText : uncheckedText
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.clicked()
            if(flipable) {
                checked = !checked
                text = checked ? checkedText : uncheckedText
            }
            setColor()
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
	            //easing.type: easing.OutExpo
	            } }
}