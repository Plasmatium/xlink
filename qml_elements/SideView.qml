import QtQuick 2.5

Rectangle {
	id: root

	property var py: parent.py
	property var pd

	Text {
		text: '<b>Configure List</b>'
		color: '#ff3998d6'
		font.pixelSize: 22
		x: 32
		z: 1
	}

	PandasView2 {
		id: configList
		width: root.width*0.382
		height: root.height*0.618
		fn: 'config.cdt'
	}
	Rectangle {
		id: sideInfo
		width: root.width*0.618
		height: root.height*0.618
		anchors.left: configList.right
		color: "#ff3998d6"



		Column {
			id: inputArray
			x: 20
			y:40
			property var sel: configList.currentIndex!=-1
			Text {
				color: 'white'
				text: '<b>Detailed Parameters</b>'
				font.pixelSize: 20
				height: 60
			}
			TextInputCombo {
				id: inputSN
				//readOnly: true
				labelText: '<b>SN</b>'
				inputText: inputArray.sel?configList.mod.get(configList.currentIndex)['SN']:'...'
			}
			TextInputCombo {
				id: inputIP
				labelText: '<b>IP</b>'
				inputText: inputArray.sel?configList.mod.get(configList.currentIndex)['IP']:'...'
			}
			TextInputCombo {
				id: inputPort
				labelText: '<b>Port</b>'
				inputText: inputArray.sel?configList.mod.get(configList.currentIndex)['Port']:'...'
			}
			TextInputCombo {
				id: inputRegs
				labelText: '<b>Regs</b>'
				inputText: inputArray.sel?configList.mod.get(configList.currentIndex)['Regs']:'...'
			}
			TextInputCombo {
				id: inputChs
				labelText: '<b>Chs</b>'
				inputText: inputArray.sel?configList.mod.get(configList.currentIndex)['Chs']:'...'
			}
			TextInputCombo {
				id: inputDesc
				labelText: '<b>Desc</b>'
				inputText: inputArray.sel?configList.mod.get(configList.currentIndex)['Desc']:'...'
			}
		}

		//apply button
		PushButton {
			id: apply
			x: sideInfo.width*0.382-20
			y: sideInfo.height-75
			height: 40
			width: 40
			radius: 20
			font.pixelSize: 18
			text: '√'
			border.width:0
			textColor: 'white'
			backColor: '#ff3998d6'

			onClicked: {
				if(!inputArray.sel){
					return
				}
				var idx = configList.currentIndex
				var itm = configList.currentItem
				console.log(itm)
				var sn = inputSN.inputText
				configList.pd[sn] = {'SN': sn}
				var df = configList.pd[sn]
				df.IP = inputIP.inputText
				df.Regs = inputRegs.inputText
				df.Port = inputPort.inputText
				df.Chs = inputChs.inputText
				df.Desc = inputDesc.inputText

				py.saveConfig(configList.pd)
				//ToDo py.saveConfig
			}
		}		
		PushButton {
			id: addConfig
			x: sideInfo.width*0.618-20
			y: sideInfo.height-75
			height: 40
			width: 40
			radius: 20
			font.pixelSize: 22
			text: 'x'
			border.width:0
			textColor: 'white'
			backColor: '#ff3998d6'
		}
	}

	SepBar {
		id: sep1
		vertical: false
		y: root.height*0.618
		z:1
	}

	PicSelector {
		id: picSelector
		height: root.height*0.382
		width: root.width*0.5
		x: root.width*0.5
		y: root.height*0.618
		index: configList.currentIndex
	}
	DrawListView {
		id: drawListView
		y: root.height*0.618
		height: root.height*0.382
		width: root.width*0.5
	}
}