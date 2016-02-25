import QtQuick 2.5

Rectangle {
    id: root
    property var py: parent.py
    property var pd
    property alias mod: mod
    property alias delegate: delegate
    property alias view: view
    property var epTxtColor: '#ff3998d6'
    property var normTxtColor: 'white'
    //color: '#3f3f3f'

    //width: 200; height: 400
    Component {
        id: hlt
        Rectangle {
            width: root.parent.width; height: 100
            color: "#ff3998d6"; radius: 5
            y: view.currentItem.y
            Behavior on y {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutQuint
                }
            }
        }
    }

    Component {
        id: delegate
        Item {
            width: root.parent.width; height: 100
            Column {
                Text { text: '--<b>SN</b>: ' + SN; color: epTxtColor}
                Text { text: '--<b>IP:</b> ' + IP; color: normTxtColor }
                Text { text: '----<b>Port:</b> ' + Port; color: normTxtColor }
                Text { text: '----<b>Regs:</b> ' + Regs; color: normTxtColor }
                Text { text: '----<b>Chs:</b> ' + Chs; color: normTxtColor }                
                Text { text: '----<b>Desc:</b> ' + Desc; color: normTxtColor }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    view.currentIndex = index
                }
                onDoubleClicked: {
                    console.log(model['SN'])
                }
            }
        }
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
        focus: true
    }

    ListModel {
    	id: mod
	}

    MouseArea {
        onClicked: {
            py.log(mod)
        }
    }
    /*
    Component.onCompleted: {
        var v = py.getData()
        for(var i in v){
            v[i].SN = i
            mod.append(v[i])
            //console.log(i, v[i])
            //py.log(v[i])
        }
    }
    */
}