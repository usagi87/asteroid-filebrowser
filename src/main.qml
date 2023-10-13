
import QtQuick 2.9
import org.asteroid.controls 1.0
import Qt.labs.folderlistmodel 2.1
import QtGraphicalEffects 1.15
import QtQuick.VirtualKeyboard 2.0
import QtQuick.VirtualKeyboard.Settings 2.15
import File 1.0
Application {
    id: app

	
	property var fileSource
	property var getText: ""
	
    centerColor: "#31bee7"
    outerColor:  "#052442"

File{
	id:file
}

function backToDir() {
	while (layerStack.layers.length > 0) {
            layerStack.pop(layerStack.currentLayer)
	}    
}

LayerStack {
   	id: layerStack
	firstPage: browserView
}
FolderListModel {
        id: folderModel
        folder: "file:///home/ceres/"
        nameFilters: ["*"]
        sortField: FolderListModel.Name
        sortReversed: false
        showDirs: true
        showHidden:false
        showFiles:true
        showDotAndDotDot :true
}



Component{
	id:browserView
	Item {
		id:rootM
		
		Item{
			anchors.fill: parent
		
			Spinner {
 				id: codeId
				height: parent.height
				width: parent.width
				model: folderModel.count
				delegate: SpinnerDelegate { 
					text:folderModel.get(index,"fileName")
					font.pixelSize: Dims.h(8)
					MouseArea {
						anchors.fill: parent
    		            onClicked: {
    		            	folderModel.folder = folderModel.get(codeId.currentIndex,"fileIsDir") ? folderModel.get(codeId.currentIndex,"fileURL") : folderModel.folder
        	       	 	}
        			}
				}
			}
			IconButton {
				anchors.verticalCenter: parent.verticalCenter
				anchors.right : parent.right
				iconName: "ios-checkmark-circle-outline"
				onClicked: {			
					if(!folderModel.get(codeId.currentIndex,"fileIsDir")){
						fileSource = folderModel.get(codeId.currentIndex,"filePath")
						layerStack.push(editPage)
					}
 				}
			}
		}
	}	
}

Component{
	id:renamePage
	Item{
		id:rootM
		TextField{
			id:newName
			anchors.verticalCenter:parent.verticalCenter
			anchors.horizontalCenter:parent.horizontalCenter
			width: Dims.w(80)
			previewText: "New file name"
			text: getText
			MouseArea {
        		anchors.fill:parent
        		onClicked: { 
        			getText = ""
        			layerStack.push(keyboardPage) 
        		}
    		}
        	
		}
		IconButton{
			id:closebtn
			anchors.horizontalCenter:parent.horizontalCenter
			anchors.bottom :parent.bottom
			anchors.bottomMargin: parent.height * 0.05
			width: Dims.l(20)
			iconName: "ios-close-circle-outline"
        	onClicked:{
        		getText = ""
        	 	layerStack.pop(rootM)
        	 }
		}	
		IconButton {
    		id: savebtn
    		anchors.bottom:parent.bottom
			anchors.right:closebtn.left
			anchors.rightMargin:5
			anchors.bottomMargin: parent.height * 0.05
    	    width: Dims.l(20)
    	    iconName: "ios-checkmark-circle-outline"
    	    onClicked:{
    	    	file.rename(fileSource,newName.text)
    	    	fileSource = ""
    	    	getText = ""
    	    	backToDir() 
			} 
   		}
	}
}


Component{
	id:copyPage
	Item {
		id:rootM		
		Item{
			anchors.fill: parent
		
			Spinner {
 				id: codeId
				height: parent.height
				width: parent.width
				model: folderModel.count
				delegate: SpinnerDelegate { 
					text:folderModel.get(index,"fileName")
					font.pixelSize: Dims.h(8)
					MouseArea {
						anchors.fill: parent
    		            onClicked: {
    		            	folderModel.folder = folderModel.get(codeId.currentIndex,"fileIsDir") ? folderModel.get(codeId.currentIndex,"fileURL") : folderModel.folder
        	       	 	}
        			}
				}
			}
			IconButton {
				anchors.verticalCenter: parent.verticalCenter
				anchors.right : parent.right
				iconName: "ios-checkmark-circle-outline"
				onClicked: {			
					if(folderModel.get(codeId.currentIndex,"fileIsDir")){
						file.copy(fileSource,folderModel.get(codeId.currentIndex,"filePath"))
					backToDir()
					}
 				}
			}
		}
	}	
}

Component {
	id: editPage
	Flickable {
    	contentHeight: settingsColumn.implicitHeight
    	contentWidth: width
    	boundsBehavior: Flickable.DragOverBounds
    	flickableDirection: Flickable.HorizontalFlick
		Column {
    		id: settingsColumn
       		anchors.fill: parent
			Item { width: parent.width; height: Dims.h(10);visible: true}
			ListItem {
       			title: qsTrId("Delete")
       		    iconName: "ios-remove-circle"
       		    onClicked: {
					file.remove(fileSource)
					fileSource = ""
					backToDir()				
       		    }
       		}
       		ListItem {
       			title: qsTrId("Rename")
       		    iconName: "ios-remove-circle"
       		    onClicked: {
					layerStack.push(renamePage)				
       		    }
       		}
       		ListItem {
       			title: qsTrId("Copy")
       		    iconName: "ios-remove-circle"
       		    onClicked: {
					layerStack.push(copyPage)				
       		    }
       		}
			Item { width: parent.width; height: Dims.h(10);visible: true}
		}
	}	
}

Component {
	id:keyboardPage	
	Item {
		id:rootM
		property alias inputMethodHints: txtField.inputMethodHints
		property var pop
					
		TextField {
    		id: txtField
    		anchors.top:parent.top
    		anchors.topMargin :parent.height * 0.1
    		anchors.horizontalCenter:parent.horizontalCenter
    	    width: Dims.w(80)
    	    previewText: qsTrId("")
   		}	
	
		InputPanel {
    		id: kbd
    	   	anchors {
   		    	verticalCenter: parent.verticalCenter
   		    	horizontalCenter: parent.horizontalCenter
   			}
   			width:parent.width * 0.90 //Dims.w(95)
    	   	visible: active
   		}
		IconButton {
			id:txtEnter
			anchors.bottom : parent.bottom
 			anchors.horizontalCenter : parent.horizontalCenter		
 			iconName: "ios-checkmark-circle-outline"
 			onClicked: {
 				getText = txtField.text
				layerStack.pop(rootM)				
			}
		}
		Component.onCompleted: {
		VirtualKeyboardSettings.styleName = "watch"
		
   		}
	}		
}


}

