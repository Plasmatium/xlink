import QtQuick 2.5

Rectangle {
    id: root
    property var py: parent.py
    property var pd
    property alias delegate: delegate
    property alias view: view
    property alias mod: mod
    property var fn
    property alias currentIndex: view.currentIndex
    property var modData
    //color: '#3f3f3f'

    //width: 200; height: 400
    Component {
        id: hlt
        Rectangle {
            width: root.parent.width; height: 100
            color: "#ff3998d6"
            y: view.currentItem.y
        }
    }

    Component {
        id: delegate
        Item {            
            property var selected: view.currentIndex==index
            property var epTxtColor: selected?'#ff3998d6':'#ff3998d6'
            property var normTxtColor: selected?'white':'#00000000'
            property var sn: model['SN']
            property var mod: model
            width: root.parent.width; height: selected?100:38.2
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
                    modData = model
                }
            }
            Behavior on height {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutQuint
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
    //*
    Component.onCompleted: {
        pd = py.getDataFrame(fn)
        for(var i in pd){
            pd[i].SN = i
            mod.append(pd[i])
            //console.log(i, v[i])
            //py.log(v[i])
        }
        view.currentIndex=-1        
    }
    //*/
}