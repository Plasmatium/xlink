import QtQuick 2.0

Rectangle {
	id: root
    width: 310
    height: 300
    color: "lightgray"
	signal sendClicked(string str1) // 定义信号
	signal quit()

    Grid {
        columns: 3
	    spacing: 2
	    Rectangle { color: "white"; width: 100; height: 20
	    	id: r1
	    	TextInput {
		        id: input1
		        text: "10"
		        anchors.fill: r1
		    }
	    }

	    Rectangle { color: "white"; width: 100; height: 20
	    	id: r2	    	
	    	Text {
	            id: txt
	            text: "Clicked me"
	            font.pixelSize: 10
	            anchors.centerIn: parent
	        }

	        MouseArea {
		        id: mouse_area
		        anchors.fill: r2  // 有效区域
		        onClicked: {
		        	root.quit()
		           	//root.sendClicked(input1.text+"@"+func.text)    // 发射信号到Python
		        	//parent.color="red"

		        }
		    }
	    }

	    Rectangle { color: "white"; width: 100; height: 20
	    	id: r3
	    	Text {
	    		id: func
	    		text: "print"
	    		anchors.fill: r3
	    	}
	    }

    	anchors.fill: parent
    	
    }
}