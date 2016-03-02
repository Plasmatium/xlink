import QtQuick 2.5

Rectangle {
	id: root
	property var py: parent.py
	property var index

	color: 'white'

	TextInputCombo {
		id: start	
		width: 300
		labelText: 'Start Time'
		inputText: '00-00-00 0.0.0'
		labelWidth: 100
		inputWidth: 200
		fcolor: '#ff3998d6'
		bcolor: 'white'
	}
	TextInputCombo {
		id: end	
		anchors.top: start.bottom
		width: 300
		labelText: 'End Time'
		inputText: '10-00-00 0.0.0'
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
		x: addConfig.x+30
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
			var sn = configList.mod.get(configList.currentIndex)['SN']
			var conf = {}
			py.submitDrawConfig(sn, false, conf)
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
				start: start.inputText,
				end: end.inputText,
				figNum: figNum.inputText,
				channel: channel.inputText
			}
			py.submitDrawConfig(sn, true, conf)
		}
	}
	/*---------------------------------*/
}