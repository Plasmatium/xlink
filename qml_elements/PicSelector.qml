import QtQuick 2.5

Rectangle {
	id: root
	property var py: parent.py
	property var index

	color: 'white'

	TextInputCombo {
		id: begin	
		width: 300
		labelText: 'Start Time'
		inputText: '16-01-01 0:0:0'
		labelWidth: 100
		inputWidth: 200
		fcolor: '#ff3998d6'
		bcolor: 'white'
	}
	TextInputCombo {
		id: end	
		anchors.top: begin.bottom
		width: 300
		labelText: 'End Time'
		inputText: '16-01-02 0:0:0'
		labelWidth: 100
		inputWidth: 200
		fcolor: '#ff3998d6'
		bcolor: 'white'
	}
	TextInputCombo {
		id: figNum
		anchors.top: end.bottom
		width: 170
		labelWidth: 100
		inputWidth: 70
		fcolor: '#ff3998d6'
		bcolor: 'white'
		labelText: 'Fig Num'
		inputText: '1'
	}
	TextInputCombo {
		id: channel
		anchors.top: figNum.bottom
		width: 170
		labelWidth: 100
		inputWidth: 70
		fcolor: '#ff3998d6'
		bcolor: 'white'
		labelText: 'Channel'
		inputText: 'ch1'
	}
	PushButton {
		id: delConfig
		x: addConfig.x+60
		anchors.top: channel.bottom
		height: 40
		width: 40
		radius: 20
		font.pixelSize: 22
		text: '-'
		border.width:0
		backColor: 'white'
		textColor: '#ff3998d6'

		onClicked: {
			console.log(drawListView)
			if(configList.currentIndex == -1){
				return
			}
			drawListView.removeCurrentData()
			//py.submitDrawConfig(sn, false, conf)
		}
	}
	PushButton {
		id: addConfig
		x: parent.width*0.05
		anchors.top: channel.bottom
		height: 40
		width: 40
		radius: 20
		font.pixelSize: 22
		text: '+'
		border.width:0
		backColor: 'white'
		textColor: '#ff3998d6'

		onClicked: {
			if(configList.currentIndex == -1){
				return
			}
			var sn = configList.mod.get(configList.currentIndex)['SN']
			var conf = {
				sn: sn,
				begin: begin.inputText,
				end: end.inputText,
				figNum: figNum.inputText,
				channel: channel.inputText
			}
			drawListView.addData(conf)
			//py.submitDrawConfig(sn, true, conf)
		}
	}
	/*---------------------------------*/
	PushButton {
		id: drawFig
		x: parent.width*0.618-10
		border.width: 0
		height: 200
		anchors.top: end.bottom
		text: "=======>\n=======>\n=======>\nDraw Figure!\n=======>\n=======>\n=======>"

		onClicked: {
			var figList = []
			var mod = drawListView.mod
			for(var i = 0; i < mod.count; i++) {
				figList[i] = mod.get(i)
			}
			py.drawRequest(figList)
		}
	}
}