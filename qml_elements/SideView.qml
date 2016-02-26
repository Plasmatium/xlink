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
			text: '√'

			onClicked: {
				if(!inputArray.sel){
					return
				}
				var m = configList.mod
				var idx = configList.currentIndex
				m.set(idx, {
					'SN': inputSN.inputText,
					'IP': inputIP.inputText,
					'Port': inputPort.inputText,
					'Regs': inputRegs.inputText,
					'Chs': inputChs.inputText,
					'Desc': inputDesc.inputText
					} )
				//ToDo py.saveConfig
			}
		}		
		PushButton {
			id: draw
			x: sideInfo.width*0.618-20
			y: sideInfo.height-75
			height: 40
			width: 40
			radius: 20
			text: '->'//'→'
		}
	}

	SepBar {
		id: sep1
		vertical: false
		y: root.height*0.618
	}
}