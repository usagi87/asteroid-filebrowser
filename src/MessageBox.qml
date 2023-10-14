import QtQuick 2.9
import org.asteroid.controls 1.0

Item {
	id:rootM
	property alias message : label.text
	property var pop
	signal clicked()
	
	Text {
        id: label
        height: 300
        width: 300
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Dims.l(8)
        horizontalAlignment: Text.AlignHCenter
        wrapMode:Text.WordWrap
    }
    IconButton{
    	id:okbtn
    	anchors.horizontalCenter:parent.horizontalCenter
		anchors.bottom :parent.bottom
    	iconName:"ios-checkmark-circle-outline"
    	onClicked: {
    		rootM.clicked()
    		rootM.pop()
    	} 
    }
    
}
