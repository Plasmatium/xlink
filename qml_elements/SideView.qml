import QtQuick 2.5

Rectangle {
	id: root

	property var py: parent.py

	PandasView2 {
		id: configList
		width: root.width*0.618
		height: root.height*0.618

		Component.onCompleted: {
			var data = py.getDataFrame('config.cdt')
			pd = data
	        for(var i in data){
	            data[i].SN = i
	            mod.append(data[i])
	            //console.log(i, v[i])
	            //py.log(v[i])
	        }
		}
	}
	Rectangle {
		id: sideInfo
		width: root.width*0.4
		height: root.height*0.618
		anchors.left: configList.right
		color: "#ff3998d6"
		Text {
			text: configList.delegate.item.model['SN']
		}
	}

	SepBar {
		id: sep1
		vertical: false
		y: root.height*0.618
	}
}