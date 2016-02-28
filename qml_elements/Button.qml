import QtQuick 2.5

Rectangle {
    id: root
 
    property alias text: label.text
    property alias textColor: label.color
    property alias backColor: root.color
    property bool checked: false
    property alias font: label.font
    signal clicked
 
    width: 116; height: 26
    color: "white"
    border.color: "lightgray"
 
    Text {
        id: label
        anchors.centerIn: parent
        text: "Button"
        color: "blue"
        font.pixelSize: 16
    }
    MouseArea {
        anchors.fill: parent
    }
}