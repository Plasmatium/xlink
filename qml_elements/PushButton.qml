import QtQuick 2.5

Button {
    id: root
     
    backColor: "white"
    textColor: "#ff3998d6"

    property var bColor
    property var fColor

    Component.onCompleted: {
        bColor = Qt.lighter(backColor, 1.0)
        fColor = Qt.lighter(textColor, 1.0)
    }
 
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.clicked()
        }
        onEntered: {
            backColor = fColor
            textColor = bColor
        }
        onExited: {
            backColor = bColor
            textColor = fColor
        }        
        onPressed: {
            backColor = Qt.lighter(fColor, 1.2)
            textColor = Qt.darker(bColor, 1.2)
        }
        onReleased: {
            backColor = bColor
            textColor = fColor
        }
    }
    Behavior on backColor { ColorAnimation{ duration: 150
	            //easing.type: easing.OutExpo
	            } }
}